{ inputs, outputs, lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf # command-line fuzzy finder
  ];

  programs.zsh = {
    enable = true;
    
    # Enable extra features
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    dotDir = ".config/zsh";
    
    # Commands that should be added to to top of '.zshrc'
    initExtraFirst = ''
    '';

    # Aliases
    shellAliases = {
      c  = "clear";
      hm = "cd ~/";
      tp = "trash-put";
      ud = "cd ..";
      la = "ls -a";
      ll = "ls -l";
      tt = "wezterm cli set-tab-title ";
    };

    # An attribute set that adds to named directory hash table
    dirHashes = {
      # QMK Keymaps
      crkbd = "$HOME/Projects/qmk_keymaps/keyboards/crkbd/keymaps/sajenim";
      kchrn = "$HOME/Projects/qmk_keymaps/keyboards/keychron/q4/ansi_v2/keymaps/sajenim";
    };
 
    # Install plugins
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "5a81e13792a1eed4a03d2083771ee6e5b616b9ab";
          sha256 = "dPe5CLCAuuuLGRdRCt/nNruxMrP9f/oddRxERkgm1FE=";
        };
      }
    ];
   
    # Extra commands that should be added to '.zshrc'
    initExtra = ''
      eval "$(direnv hook zsh)"
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      PROMPT='%F{blue}%n %F{cyan}%~ %F{red}♥ %f';
    '';
  };
}

