{ pkgs, ... }:
let
  awesome = pkgs.awesome.overrideAttrs (oa: {
    version = "ad0290bc1aac3ec2391aa14784146a53ebf9d1f0";
    src = pkgs.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "ad0290bc1aac3ec2391aa14784146a53ebf9d1f0";
      hash = "sha256-uaskBbnX8NgxrprI4UbPfb5cRqdRsJZv0YXXshfsxFU=";
    };

    patches = [ ];

    postPatch = ''
      patchShebangs tests/examples/_postprocess.lua
    '';
  });
in
{
  xdg.configFile = {
    awesome = { source = ./config; recursive = true; };
  };

  xsession.windowManager.awesome = {
    enable = true;
    package = awesome;
  };
}

