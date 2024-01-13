{ inputs, outputs, pkgs, ... }:

{
  imports = [
    "${inputs.self}/nixos/common/optional/steam.nix"
  ];

  users.users.sajenim = {
      isNormalUser = true;
      extraGroups = [ "audio" "docker" "networkmanager" "wheel" ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keyFiles = [
        "${inputs.self}/home-manager/sabrina/id_ed25519.pub"
      ];
      hashedPassword = "$y$j9T$qIhW5qL9J9w.w6JWa.bGo/$oddG3HJyOZ1mwHzYnYPJ/MzN38oHEBEvPDc0sB3rAf9";
  };
  users.mutableUsers = false;

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      sajenim = import "${inputs.self}/home-manager/sajenim/home.nix";
    };
  };
}
