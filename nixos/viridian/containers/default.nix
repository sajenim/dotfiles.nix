{ ... }:

{
  imports = [
    ./dashboard.nix
    ./multimedia.nix
  ];

  virtualisation.oci-containers.backend = "docker";
}
