{...}: {
  # Attached to the routers, pieces of middleware are a means of tweaking the requests before they are sent to your service
  services.traefik.dynamicConfigOptions.http.middlewares = {
    # Restrict access to internal networks
    internal.ipwhitelist.sourcerange = [
      "127.0.0.1/32" # localhost
      "192.168.50.1/24" # lan
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

    # Intrusion Prevention System
    crowdsec.plugin.bouncer = {
      enabled = "true";
      defaultDecisionSeconds = "60";
      crowdsecMode = "live";
      crowdsecAppsecEnabled = "true";
      crowdsecAppsecHost = "localhost:7422";
      crowdsecAppsecFailureBlock = "true";
      crowdsecAppsecUnreachableBlock = "true";
      crowdsecLapiKey = "18c725d5-3a22-4331-a8e8-abfd3018a7c0";
      crowdsecLapiHost = "localhost:8080";
      crowdsecLapiScheme = "http";
      crowdsecLapiTLSInsecureVerify = "false";
      forwardedHeadersTrustedIPs = [
        # private class ranges
        "10.0.0.0/8"
        "172.16.0.0/12"
        "192.168.0.0/16"
      ];
      clientTrustedIPs = [
        # private class ranges
        "10.0.0.0/8"
        "172.16.0.0/12"
        "192.168.0.0/16"
      ];
    };
  };
}
