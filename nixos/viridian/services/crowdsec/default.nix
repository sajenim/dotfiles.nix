{
  config,
  inputs,
  pkgs,
  ...
}: let
  port = "8080";
in {
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

  services.crowdsec = {
    enable = true;
    allowLocalJournalAccess = true;
    enrollKeyFile = config.age.secrets.enrollment-key.path;
    settings = {
      api.server = {
        listen_uri = "127.0.0.1:${port}";
      };
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

        if ! cscli collections list | grep -q "crowdsecurity/traefik"; then
          cscli collections install "crowdsecurity/traefik"
        fi

        if ! cscli collections list | grep -q "crowdsecurity/http-cve"; then
          cscli collections install "crowdsecurity/http-cve"
        fi

        if ! cscli collections list | grep -q "crowdsecurity/sshd"; then
          cscli collections install "crowdsecurity/sshd"
        fi

        if ! cscli collections list | grep -q "crowdsecurity/base-http-scenarios"; then
          cscli collections install "crowdsecurity/base-http-scenarios"
        fi
      '';
    in [
      "${bouncer}/bin/register-bouncer"
      "${scenario}/bin/install-scenario"
    ];
  };

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/var/lib/crowdsec";
        user = "crowdsec";
        group = "crowdsec";
      }
    ];
    hideMounts = true;
  };
}
