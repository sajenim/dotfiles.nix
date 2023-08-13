{ ... }:

{
  # Klipper is a 3d-Printer firmware.
  # It combines the power of a general purpose computer with one or more micro-controllers. 
  services.klipper = {
    enable = true;
    # Setup User:Group
    user = "root";
    group = "root";
    # Klipper configuration
    configFile = ./printer.cfg;
  };
  
  # Moonraker is a Python 3 based web server
  # Exposes APIs with which client applications may use to interact with the 3D printing firmware Klipper. 
  services.moonraker = {
    enable = true;
    # Setup User:Group
    user = "root";
    group = "root";
    # Listen address and port
    address = "0.0.0.0";
    port = 7125;
    # Moonraker configuration
    settings.authorization = {
      force_logins = false;
      cors_domains = [
        "https://fluidd.kanto.dev"
      ];
      trusted_clients = [
        "10.0.0.0/8"
        "127.0.0.0/8"
        "192.168.1.0/24"
      ];
    };
    # Moonraker exposes APIs to perform system-level operations, such as reboot, shutdown, and management of systemd units.
    allowSystemControl = true;
  };

  # Fluidd is a free and open-source Klipper web interface for managing your 3d printer.
  services.fluidd = {
    enable = true;
    # Listen address and port  
    nginx.listen = [{
      addr = "192.168.1.100";
      port = 4624;
    }];
  };

  # Allow uploads > 1MB to fluidd
  services.nginx.clientMaxBodySize = "1000m";
}
