{...}: {
  services.libinput = {
    enable = true;
    mouse = {accelProfile = "flat";};
  };

  # DBus daemon to configure input devices.
  services.ratbagd.enable = true;
}
