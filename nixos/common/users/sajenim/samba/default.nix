{ pkgs, config, ... }:

{
  age.secrets.smb-secrets = {
    rekeyFile = ./smb-secrets.age;
  };

  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];

  fileSystems."/home/sajenim/.backup" = {
    device = "//192.168.20.4/sajenim";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";

      in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  };

  environment.etc = {
    "nixos/smb-secrets".source = config.age.secrets.smb-secrets.path;
  };
}

