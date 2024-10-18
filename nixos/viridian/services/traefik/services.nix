{...}: {
  services.traefik.dynamicConfigOptions.http.services = {
    ender1.loadBalancer.servers = [
      {url = "http://192.168.50.202:80";}
    ];
  };
}
