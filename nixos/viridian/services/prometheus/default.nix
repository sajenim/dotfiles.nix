{config, ...}: {
  services.prometheus = {
    enable = true;
    port = 9001; # Port to listen on.

    # Valid in all configuration contexts, defaults for other configuration sections.
    globalConfig = {
      scrape_interval = "15s";
    };

    # Collect specific metrics, format them, and expose them through HTTP endpoints for prometheus to scrape.
    exporters = {
      node = {
        enable = true;
        enabledCollectors = ["systemd" "processes"];
        port = 9100;
      };
    };

    # Specify a set of targets and parameters describing how to scrape them.
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = ["127.0.0.1:${toString config.services.prometheus.exporters.node.port}"];
          }
        ];
      }
    ];
  };
}
