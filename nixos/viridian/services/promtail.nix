{ config, ... }:

{
  services.promtail = {
    enable = true;
    configuration = {
      server = {
        http_listen_port = 9080;
        grpc_listen_port = 0;
      };
      positions = {
        filename = "/tmp/positions.yaml";
      };
      clients = [{
        url = "http://127.0.0.1:${toString config.services.loki.configuration.server.http_listen_port}/loki/api/v1/push";
      }];
      scrape_configs = [{
        job_name = "system";
        static_configs = [{
          targets = [ "localhost" ]; # Promtail target is localhost
          labels = {
            instance = "viridian.kanto.dev"; # Label identifier for instance
            env = "kanto"; # Environment label
            job = "secure"; # Job label
            __path__ = "/var/log/sshd.log";
          };
        }];
      }];
    };
  };
}
