{ ... }:

{
  programs = {
    zsh.enable = true;
    # Load and unload environment variables.
    direnv.enable = true;
    # Android debug bridge: communicate with devices.
    adb.enable = true;
  };
}

