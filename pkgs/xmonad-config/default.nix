{ pkgs }:

pkgs.haskellPackages.developPackage {
  root = ./.;
  source-overrides = {
    xmonad = (builtins.fetchTarball {
      url = "https://github.com/xmonad/xmonad/archive/refs/tags/v0.18.0.tar.gz";
      sha256 = "0jlc60n5jarcxgjxm1vcsgc3s2lwmn3c3n56hialhzx54wfskkbc";
    });
  };
}

