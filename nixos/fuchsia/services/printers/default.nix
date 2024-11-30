{pkgs, ...}: {
  hardware.printers = {
    ensurePrinters = [
      {
        name = "HP_DeskJet_2800_series_276B08";
        description = "HP DeskJet 2800 series";
        location = "Local Printer";
        deviceUri = "dnssd://HP%20DeskJet%202800%20series%20%5B276B08%5D._ipp._tcp.local/?uuid=5e8778d6-018e-48ec-8838-c8cf40170b95";
        model = "drv:///hp/hpcups.drv/hp-Deskjet_2800_series.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }

      {
        name = "DYMO_Label_Writer_5XL_on_DYMOLW5XL315c26E";
        description = "DYMO LabelWriter 5XL";
        location = "Local Printer";
        deviceUri = "dnssd://DYMO%20Label%20Writer%205XL%20on%20DYMOLW5XL315c26E._pdl-datastream._tcp.local/";
        model = "53hwxkc5kmnm06xvkx8f6w3dcsh7jlhg-lw5xl.ppd";
        ppdOptions = {
          DymoPrintQuality = "Graphics";
        };
      }
    ];
    ensureDefaultPrinter = "HP_DeskJet_2800_series_276B08";
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplipWithPlugin
      (pkgs.callPackage ./lw5xl.nix {})
    ];
  };

  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.hplipWithPlugin];
  };
}
