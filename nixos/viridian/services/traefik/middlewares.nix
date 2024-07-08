{ config, ... }:

{
  # Crowdsec Local API key for the bouncer.
  age.secrets.traefik-bouncer-key = {
    rekeyFile = ../crowdsec/traefik-bouncer-key.age;
    owner = "traefik";
    group = "traefik";
  };

  # Attached to the routers, pieces of middleware are a means of tweaking the requests before they are sent to your service
  services.traefik.dynamicConfigOptions.http.middlewares = {
    # Restrict access to internal networks
    internal.ipwhitelist.sourcerange = [
      "127.0.0.1/32"    # localhost
      "192.168.20.1/24" # lan
    ];

    # Restrict access based on geo-location
    geoblock.plugin.geoblock = {
      silentStartUp = "false";
      allowLocalRequests = "true";
      # If set to true will show a log message
      logLocalRequests = "false";
      logAllowedRequests = "false";
      logApiRequests = "false";
      # Application programming interface
      api = "https://get.geojs.io/v1/ip/country/{ip}";
      apiTimeoutMs = "750";
      # Max size of least recently used cache
      cacheSize = "25";
      # List of countries to block access
      countries = [
        "RU" # Russian Federation (the)
      ];
      # Inverts filter logic
      blackListMode = "true";
      # Unknown Countries (IPs with no country association)
      allowUnknownCountries = "false";
      unknownCountryApiResponse = "nil";
      # Adds the X-IPCountry header to the HTTP request header.
      addCountryHeader = "false";
      # Even if an IP stays in the cache for a period of a month, it must be fetch again after a month.
      forceMonthlyUpdate = "true";
    };

    # Disable Crowdsec IP checking but apply Crowdsec Appsec checking. This mode is intended to be used when Crowdsec IP checking is applied at the Firewall Level.
    crowdsec.plugin.bouncer = {
      enabled = "true";
      crowdsecMode = "appsec";
      crowdsecLapiKeyFile = config.age.secrets.traefik-bouncer-key.path; 
      crowdsecLapiScheme = "http";
      crowdsecLapiHost = "127.0.0.1:8080";
      crowdsecAppsecEnabled = "true";
      crowdsecAppsecHost = "127.0.0.1:7422";
    };
  };
}

