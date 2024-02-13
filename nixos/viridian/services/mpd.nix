{ ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "/srv/multimedia/library/music";
    network = {
      listenAddress = "any";
      port = 6600;
    };
    extraConfig = ''
      audio_output {
        type "null"
        name "This server does not need to play music."
      }
    '';
  };

  services.nfs.server = {
    enable = true;
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
    exports = ''
      /srv/multimedia/library/music 192.168.1.101(rw,nohide,insecure,no_subtree_check)
    '';
  };
}
