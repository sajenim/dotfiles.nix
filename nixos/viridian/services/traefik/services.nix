{...}: {
  services.traefik.dynamicConfigOptions.http.services = {
    ender1.loadBalancer.servers = [
      {url = "http://192.168.1.103:80";}
    ];
  };
}
