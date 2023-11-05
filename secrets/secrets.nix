let
  # Users
  sabrina = {
    viridian = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPn1X4oHniIkR1bEP/KFt70gmtA3tc8UTLd53P9xQzNe";
  };
  
  # Hosts
  viridian = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINR3TagUNIDTEPkVVBl6Pot+6GocrQ5/2Dq72RRiQWqe";
  
  users = [ sabrina.viridian ];
  hosts = [ viridian ];
in
  {
    "traefik.age".publicKeys = users ++ hosts;
  }
  
