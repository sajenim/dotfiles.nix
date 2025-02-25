{
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = [inputs.xmonad-config.packages.${pkgs.system}.default];
  };
}
