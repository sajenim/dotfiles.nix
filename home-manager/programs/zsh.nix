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
    };

    # An attribute set that adds to named directory hash table
    dirHashes = {
      # QMK Keymaps
      km-crkbd = "$HOME/keyboards/qmk_keymaps/keyboards/crkbd/keymaps/sajenim";
      km-kchrn = "$HOME/keyboards/qmk_keymaps/keyboards/keychron/q4/ansi_v2/keymaps/sajenim";
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
      # Emacs mode
      bindkey -e

      # Customize prompt
      PROMPT="%F{1}♥ %f%F{2}~ %f"
      RPROMPT="%~"
    '';
  };
}

