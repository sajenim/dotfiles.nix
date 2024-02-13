{ ... }:

{
  imports = [
    ./traefik
    ./borgbackup.nix
    ./mpd.nix
  ];
}
