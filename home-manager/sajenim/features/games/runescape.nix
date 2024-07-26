{ inputs, lib, ... }:

{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak.remotes = lib.mkOptionDefault [
    { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
    { name = "JagexLauncher"; location = "https://jagexlauncher.flatpak.mcswain.dev/JagexLauncher.flatpakrepo"; }
  ];

  services.flatpak.packages = [
    { appId = "org.freedesktop.Platform.Compat.i386/x86_64/23.08"; origin = "flathub"; }
    { appId = "org.freedesktop.Platform.GL32.default/x86_64/23.08"; origin = "flathub"; }
    { appId = "com.jagex.Launcher"; origin = "JagexLauncher"; }
    { appId = "com.jagex.Launcher.ThirdParty.RuneLite"; origin = "JagexLauncher"; }
  ];
}

