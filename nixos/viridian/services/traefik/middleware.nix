{ ... }:

{
  # Attached to the routers, pieces of middleware are a means of tweaking the requests before they are sent to your service
  services.traefik.dynamicConfigOptions.http.middlewares = {
    # Restrict access to admin devices only
    admin.ipwhitelist.sourcerange = [
      "127.0.0.1/32"    # localhost
      "192.168.1.101"   # fuchsia
      "10.100.0.2"      # Pixel 6 Pro
    ];
    # Restrict access to internal networks
    internal.ipwhitelist.sourcerange = [
      "127.0.0.1/32"    # localhost
      "192.168.1.1/24"  # lan
      "10.100.0.0/24"   # wireguard clients
    ];
    # Restrict access based on geo-location
    geoblock.plugin.geoblock = {
      silentStartUp = "true";
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
      # List of countries to allow access
      countries = [
        "AU" # Australia
      ];
      # Inverts filter logic
      blackListMode = "false";
      # Unknown Countries (IPs with no country association)
      allowUnknownCountries = "false";
      unknownCountryApiResponse = "nil";
      # Adds the X-IPCountry header to the HTTP request header.
      addCountryHeader = "false";
      # Even if an IP stays in the cache for a period of a month, it must be fetch again after a month.
      forceMonthlyUpdate = "true";
    };
  };
}

