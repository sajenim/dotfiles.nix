{pkgs, ...}: {
  services.mpd = {
    enable = true;
    musicDirectory = "nfs://viridian.kanto.dev/srv/multimedia/library/music";
    dbFile = null;
    extraConfig = ''
      database {
        plugin "proxy"
        host "viridian.kanto.dev"
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
  };
}
