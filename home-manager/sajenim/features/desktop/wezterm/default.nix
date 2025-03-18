{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    package = pkgs.unstable.wezterm;

    # Enable our shell integrations
    enableZshIntegration = true;

    # Install our theme
    colorSchemes = {
      gruvbox_material_dark_medium = {
        background = "#282828"; # bg0
        foreground = "#D4BE98"; # fg0

        selection_bg = "#3C3836"; # bg_current_word
        selection_fg = "#A89984"; # grey2

        cursor_bg = "#A89984"; # bg_current_word
        cursor_fg = "#3C3836"; # grey2
        cursor_border = "#A89984"; # grey2

        ansi = [
          "#282828" # bg0
          "#EA6962" # red
          "#A9B665" # green
          "#D8A657" # yellow
          "#7DAEA3" # blue
          "#D3869B" # purple
          "#89B482" # aqua
          "#D4BE98" # fg0
        ];

        brights = [
          "#7C6F65" # grey0
          "#EA6962" # red
          "#A9B665" # green
          "#D8A657" # yellow
          "#7DAEA3" # blue
          "#D3869B" # purple
          "#89B482" # aqua
          "#DDC7A1" # fg1
        ];
      };
      # https://github.com/sainnhe/gruvbox-material
    };

    # Load our wezterm configuration
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
