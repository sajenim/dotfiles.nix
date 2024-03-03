{ ... }:

{
  imports = [
    ./traefik
    ./borgbackup.nix
    ./mpd.nix
    ./httpd.nix
  ];
}
