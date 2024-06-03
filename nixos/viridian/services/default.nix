{ ... }:

{
  imports = [
    ./traefik
    ./minecraft
    ./borgbackup.nix
    ./forgejo.nix
    ./httpd.nix
    ./mpd.nix
    ./samba.nix
  ];
}
