{ ... }:

{
  imports = [
    ./traefik
    ./adguardhome.nix
    ./borgbackup.nix
    ./minecraft.nix
  ];
}
