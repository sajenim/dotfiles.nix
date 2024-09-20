{pkgs, ...}: {
  # Our custom power state
  environment.etc = {
    "default/amdgpu-custom-states.card1" = {
      text = ''
        # For Navi (and Radeon7) we can only set highest SCLK & MCLK, "state 1":
        OD_SCLK:
        1: 1800MHz
        OD_MCLK:
        1: 875MHz
        # More fine-grain control of clocks and voltages are done with VDDC curve:
        OD_VDDC_CURVE:
        0: 800MHz @ 699mV
        1: 1450MHz @ 795mV
        2: 1800MHz @ 950mV
        # Force power limit (in micro watts):
        FORCE_POWER_CAP: 200000000
        FORCE_PERF_LEVEL: manual
      '';

      # The UNIX file mode bits
      mode = "0440";
    };
  };

  # Install our overclocking script.
  environment.systemPackages = with pkgs; [amdgpu-clocks];
}
