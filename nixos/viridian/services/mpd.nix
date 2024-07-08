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
      /srv/multimedia/library/music fuchsia.kanto.dev(rw,nohide,insecure,no_subtree_check)
    '';
  };
  networking.firewall = {
    # # for NFSv3; view with `rpcinfo -p`
    allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
  };
}
