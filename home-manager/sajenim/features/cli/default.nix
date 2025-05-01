{pkgs, ...}: {
  imports = [
    ./git.nix
    ./irc.nix
    ./mpd.nix
    ./nvim.nix
    ./remarkable.nix
    ./ssh.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    pulsemixer
  ];
}
