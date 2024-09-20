{...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "20x20";
        frame_width = 5;
        frame_color = "#282828";
        corner_radius = 10;
      };

      urgency_low = {
        background = "#1d2021";
        foreground = "#d4be98";
      };

      urgency_normal = {
        background = "#1d2021";
        foreground = "#d4be98";
      };

      urgency_critical = {
        background = "#1d2021";
        foreground = "#d4be98";
      };
    };
  };
}
