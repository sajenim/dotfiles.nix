{pkgs, ...}: {
  hardware.printers = {
    ensurePrinters = [
      {
        name = "DYMO_Label_Writer_5XL_on_DYMOLW5XL315c26E";
        description = "DYMO LabelWriter 5XL";
        deviceUri = "dnssd://DYMO%20Label%20Writer%205XL%20on%20DYMOLW5XL315c26E._pdl-datastream._tcp.local/";
        model = "lw5xl.ppd";
        ppdOptions = {
          DymoPrintQuality = "Graphics";
        };
      }
    ];
    ensureDefaultPrinter = "DYMO_Label_Writer_5XL_on_DYMOLW5XL315c26E";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = [
      pkgs.cups-dymo
      (pkgs.writeTextDir "share/cups/model/lw5xl.ppd" (builtins.readFile ./lw5xl.ppd))
    ];
  };
}
