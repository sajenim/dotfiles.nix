{ ... }:

{
  imports = [
    ./traefik
    ./crowdsec
    ./minecraft
    ./borgbackup.nix
    ./forgejo.nix
    ./lighttpd.nix
    ./mpd.nix
    ./samba.nix
    ./grafana.nix
    ./mysql.nix
    ./prometheus.nix
  ];
}
