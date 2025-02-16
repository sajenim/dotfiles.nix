{pkgs, ...}: {
  imports = [
    ./mangohud
  ];

  home = {
    packages = with pkgs; [
      gamemode
      protonup-ng
      prismlauncher
      unstable.bolt-launcher
    ];
  };
}
