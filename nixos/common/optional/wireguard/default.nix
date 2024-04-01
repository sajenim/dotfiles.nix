{ pkgs, config, ... }:

{
  age.secrets.wireguard = {
    rekeyFile = ./private.age;
    owner = "root";
    group = "root";
  };
  networking = {
    nat = {
      enable = true;
      externalInterface = "eno1";
      internalInterfaces = [ "wg0" ];
    };
    wireguard.interfaces = {
      wg0 = {
        # IP address and subnet of the server's end of the tunnel interface
        ips = [ "10.100.0.1/24" ];
        listenPort = 51820;
        # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
        # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eno1 -j MASQUERADE
       '';
        # This undoes the above command
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eno1 -j MASQUERADE
        '';
        # Path to the private key file.
        privateKeyFile = config.age.secrets.wireguard.path;
        peers = [
          { # Pixel 6 Pro
            publicKey = "VaXMnFAXdbJCllNY5sIjPp9AcSM7ap2oA0tU9SIMK3E=";
            allowedIPs = [ "10.100.0.2/32" ];
          }
          { # Samsung S23 Ultra
            publicKey = "dL91i7+VDWfeLCOr53JlzQ32WJ3lRJGqdecoqUpEnlQ=";
            allowedIPs = [ "10.100.0.3/32" ];
          }
        ];
      };
    };
  };
}
