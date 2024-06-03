{ ... }:

{
  imports = [
    ./traefik
    ./minecraft
    ./borgbackup.nix
    ./mpd.nix
  ];
}
