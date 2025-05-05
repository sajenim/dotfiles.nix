{config, ...}: {
  services.jupyterhub = {
    enable = true;
    port = 9475;
    extraConfig = ''
      c.Authenticator.allowed_users = {'sajenim'}
    '';
  };

  services.traefik.dynamicConfigOptions.http.routers = {
    jupyter = {
      rule = "Host(`jupyter.home.arpa`)";
      entryPoints = [
        "websecure"
      ];
      service = "jupyter";
    };
  };

  services.traefik.dynamicConfigOptions.http.services = {
    jupyter.loadBalancer.servers = [
      {url = "http://127.0.0.1:${toString config.services.jupyterhub.port}";}
    ];
  };

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/jupyterhub"
    ];
  };
}
