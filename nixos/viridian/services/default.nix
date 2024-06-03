{ ... }:

{
  imports = [
    ./traefik
    ./minecraft
    ./borgbackup.nix
    ./forgejo.nix
    ./mpd.nix
    ./samba.nix
  ];
}
