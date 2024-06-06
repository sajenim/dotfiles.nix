{ config, ... }:

{
  services.endlessh-go = {
    enable = true;
    port = 22;  # SSH port
    prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";
      port = 2112; # Prometheus metrics port
    };
    extraOptions = [
      "-interval_ms=1000"
      "-logtostderr"
      "-v=1"
      "-geoip_supplier=ip-api"
    ];
    openFirewall = true;
  };

  services.prometheus.scrapeConfigs = [
    {
      job_name = "endlessh";
      static_configs = [{
        targets = [ "127.0.0.1:${toString config.services.endlessh-go.prometheus.port}" ];
      }];
    }
  ];
}

