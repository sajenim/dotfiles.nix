{ config, inputs, pkgs, ... }:
let
  port = "8080";
in
{
  imports = [
    inputs.crowdsec.nixosModules.crowdsec
    inputs.crowdsec.nixosModules.crowdsec-firewall-bouncer
  ];

  nixpkgs.overlays = [
    inputs.crowdsec.overlays.default
  ];

  age.secrets.enrollment-key = {
    rekeyFile = ./enrollment_key.age;
    owner = "crowdsec";
    group = "crowdsec";
  };

  services.crowdsec = let
    yaml = (pkgs.formats.yaml {}).generate;
    acquisitions_file = yaml "acquisitions.yaml" {
      source = "journalctl";
      journalctl_filter = ["_SYSTEMD_UNIT=sshd.service"];
      labels.type = "syslog";
    };
  in {
    enable = true;
    allowLocalJournalAccess = true;
    enrollKeyFile = config.age.secrets.enrollment-key.path;
    settings = {
      api.server = {
        listen_uri = "127.0.0.1:${port}";
      };
      crowdsec_service.acquisition_path = acquisitions_file;
      crowdsec_service.acquisition_dir = ./acquis.d;
    };
  };

  services.crowdsec-firewall-bouncer = {
    enable = true;
    settings = {
      api_key = "2025f0be-35ca-406c-8737-810321c918c2";
      api_url = "http://localhost:${port}";
    };
  };

  systemd.services.crowdsec.serviceConfig = {
    ExecStartPre = let
      bouncer = pkgs.writeScriptBin "register-bouncer" ''
        #!${pkgs.runtimeShell}
        set -eu
        set -o pipefail

        if ! cscli bouncers list | grep -q "firewall-bouncer"; then
          cscli bouncers add "firewall-bouncer" --key "2025f0be-35ca-406c-8737-810321c918c2"
        fi

        if ! cscli bouncers list | grep -q "traefik-bouncer"; then
          cscli bouncers add "traefik-bouncer" --key "18c725d5-3a22-4331-a8e8-abfd3018a7c0"
        fi
      '';
      scenario = pkgs.writeScriptBin "install-scenario" ''
        #!${pkgs.runtimeShell}
        set -eu
        set -o pipefail

        if ! cscli collections list | grep -q "crowdsecurity/linux"; then
          cscli collections install "crowdsecurity/linux"
        fi

        if ! cscli collections list | grep -q "crowdsecurity/appsec-virtual-patching"; then
          cscli collections install "crowdsecurity/appsec-virtual-patching"
        fi

        if ! cscli collections list | grep -q "crowdsecurity/appsec-generic-rules"; then
          cscli collections install "crowdsecurity/appsec-generic-rules"
        fi
      '';
    in [
      "${bouncer}/bin/register-bouncer"
      "${scenario}/bin/install-scenario"
    ];
  };

  environment.persistence."/persist" = {
    directories = [
      { directory = "/var/lib/crowdsec"; user = "crowdsec"; group = "crowdsec"; }
    ];
    hideMounts = true;
  };
}

