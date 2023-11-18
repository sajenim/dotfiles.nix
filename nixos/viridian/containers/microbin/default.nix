{ config, inputs, ... }:

{
  age.secrets.microbin = {
    # Environment variables for microbin
    file = inputs.self + /secrets/microbin.age;
    owner = "root";
    group = "root";
  };

  virtualisation.oci-containers.containers = {
    microbin = {
      autoStart = true;
      image = "danielszabo99/microbin:2.0.4";
      ports = [
        "8181:8080/tcp"
      ];
      volumes = [
        "/var/lib/microbin:/app/microbin_data:rw"
      ];
      environmentFiles = [
        config.age.secrets.microbin.path
      ];
    };
  };
}
