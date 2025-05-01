{pkgs, ...}: {

  # Install some applications for managing mpd 
  home.packages = with pkgs; [
    mpc-cli
    ncmpcpp
  ];

  # Setup our mpd client service
  services.mpd = {
    enable = true;
    musicDirectory = "nfs://viridian.home.arpa/srv/multimedia/library/music";
    dbFile = null;
    extraConfig = ''
      database {
        plugin "proxy"
        host "viridian.home.arpa"
        port "6600"
      }

      audio_output {
        type "pipewire"
        name "pipewire server"
        server "127.0.0.1" # MPD must connect to the local sound server
      }
    '';
  };
}
