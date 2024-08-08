{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  users.users.spectre = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$eCJ0MDPsx3tww9LP0LU8..$sE8u5keO7QNKNAR1t2R6GqsDzvGD0Xn9Fi3to14Gf9/";
  };
  users.mutableUsers = false;
}
