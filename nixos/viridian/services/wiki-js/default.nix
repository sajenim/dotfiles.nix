{config, ...}: {
  systemd.services.wiki-js = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  services.wiki-js = {
    enable = true;
    settings.db = {
      db = "wiki-js";
      host = "/run/postgresql";
      type = "postgres";
      user = "wiki-js";
    };
  };

  services.postgresql = {
    ensureDatabases = ["wiki-js"];
    ensureUsers = [
      {
        name = "wiki-js";
        ensureDBOwnership = true;
      }
    ];
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    wiki-js = {
      rule = "Host(`docs.sajkbd.io`)";
      entryPoints = [
        "websecure"
      ];
      service = "wiki-js";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    wiki-js.loadBalancer.servers = [
      {url = "http://127.0.0.1:${toString config.services.wiki-js.settings.port}";}
    ];
  };
}
