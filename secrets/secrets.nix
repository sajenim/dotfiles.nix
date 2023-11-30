let
  # Users
  sabrina = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPn1X4oHniIkR1bEP/KFt70gmtA3tc8UTLd53P9xQzNe";
  sajenim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAXk3P0EcVnSnWnll+m5Vv/s3QyiC73ERNLJmgxnRE1q";
  
  # Hosts
  viridian = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINR3TagUNIDTEPkVVBl6Pot+6GocrQ5/2Dq72RRiQWqe";
  fuchsia = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK/NsyclB3T7zJ7N8Mi+cxtPH1jzG7jEn3QK33rO0RgQ";
  
  users = [ sabrina sajenim ];
  hosts = [ viridian fuchsia ];
in
  {
    "traefik.age".publicKeys = users ++ hosts;
    "microbin.age".publicKeys = users ++ hosts;
    "wireguard.age".publicKeys = users ++ hosts;
  }
  
