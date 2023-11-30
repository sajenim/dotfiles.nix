{ ... }:

{
  # Home automation that puts local control and privacy first.
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"
      "adguard"
      "jellyfin"
      ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/defaultoconfig/
      default_config = {};
      http = {
        use_x_forwarded_for = true;
        trusted_proxies = [
          "192.168.1.102"
        ];
      };
    };
    configDir = "/var/lib/home-assistant";
  };
}

