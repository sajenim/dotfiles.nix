{pkgs, ...}: {
  imports = [
    ./mangohud
  ];

  home = {
    packages = with pkgs; [
      gamemode
      prismlauncher
      unstable.bolt-launcher
    ];
  };
}
