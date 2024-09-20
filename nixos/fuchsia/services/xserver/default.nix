{...}: {
  # Setup our display server
  services.xserver = {
    enable = true;
    xkb.layout = "au";
    videoDrivers = ["amdgpu"];
    displayManager.startx.enable = true;
  };
}
