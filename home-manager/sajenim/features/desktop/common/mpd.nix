{ pkgs, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "nfs://192.168.1.102/srv/multimedia/library/music";
    dbFile = null;
    extraConfig = ''
      database {
        plugin "proxy"
        host "192.168.1.102"
        port "6600"
      }

      audio_output {
        type "pulse"
        name "PulseAudio"
        server "127.0.0.1" # MPD must connect to the local sound server
      }
    '';
  };

  services.mpd-discord-rpc = {
    enable = true;
    package = pkgs.unstable.mpd-discord-rpc;
    settings = {
      hosts = [ "192:6600" ];
    };
  };
}
