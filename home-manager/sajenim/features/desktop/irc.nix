{pkgs, ...}: {
  home.packages = with pkgs; [
    weechat
  ];

  home.persistence."/persist/home/sajenim" = {
    directories = [
      # WeeChat configuration files: *.conf, certificates, etc.
      ".config/weechat"
      # WeeChat data files: logs, scripts, scripts data, xfer files, etc.
      ".local/share/weechat"
      # WeeChat cache files: scripts cache.
      ".cache/weechat"
    ];
  };
}
