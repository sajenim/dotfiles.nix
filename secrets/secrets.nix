let
  # Users
  sabrina = {
    viridian = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPn1X4oHniIkR1bEP/KFt70gmtA3tc8UTLd53P9xQzNe";
  };
  
  # Hosts
  viridian = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINR3TagUNIDTEPkVVBl6Pot+6GocrQ5/2Dq72RRiQWqe";
  fuchsia = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ4L6G8YIDE2Ej02lnQ6KSU5B011VO5kR9UBnVNcBJsg";
  
  users = [ sabrina.viridian ];
  hosts = [ viridian fuchsia];
in
  {
    "traefik.age".publicKeys = users ++ hosts;
    "microbin.age".publicKeys = users ++ hosts;
    "wireguard.age".publicKeys = users ++ hosts;
  }
  
