{pkgs, ...}: {
  home.packages = with pkgs; [
    # protonmail-bridge requires password manager
    pass
    # encrypt and decrypt our email messages
    protonmail-bridge
  ];

  accounts.email.accounts = {
    primary = {
      primary = true;
      userName = "its.jassy@pm.me";
      realName = "Jasmine Wilson";
      address = "its.jassy@pm.me";
      imap = {
        host = "127.0.0.1";
        port = 1143;
        tls.useStartTls = true;
      };
      smtp = {
        host = "127.0.0.1";
        port = 1025;
        tls.useStartTls = true;
      };
      thunderbird.enable = true;
    };

    torrents = {
      userName = "its.kalopsia@pm.me";
      realName = "Kalopsia";
      address = "its.kalopsia@pm.me";
      imap = {
        host = "127.0.0.1";
        port = 1143;
        tls.useStartTls = true;
      };
      smtp = {
        host = "127.0.0.1";
        port = 1025;
        tls.useStartTls = true;
      };
      thunderbird.enable = true;
    };

    sajkbd_primary = {
      userName = "sajkbd@pm.me";
      realName = "Sajenim";
      address = "sajkbd@pm.me";
      imap = {
        host = "127.0.0.1";
        port = 1143;
        tls.useStartTls = true;
      };
      smtp = {
        host = "127.0.0.1";
        port = 1025;
        tls.useStartTls = true;
      };
      thunderbird.enable = true;
    };

    sajkbd_support = {
      userName = "support@sajkbd.io";
      realName = "Sajenim";
      address = "support@sajkbd.io";
      imap = {
        host = "127.0.0.1";
        port = 1143;
        tls.useStartTls = true;
      };
      smtp = {
        host = "127.0.0.1";
        port = 1025;
        tls.useStartTls = true;
      };
      thunderbird.enable = true;
    };

    sajkbd_sales = {
      userName = "sales@sajkbd.io";
      realName = "Sajenim";
      address = "sales@sajkbd.io";
      imap = {
        host = "127.0.0.1";
        port = 1143;
        tls.useStartTls = true;
      };
      smtp = {
        host = "127.0.0.1";
        port = 1025;
        tls.useStartTls = true;
      };
      thunderbird.enable = true;
    };
  };

  # Cross platform, decentralized, open-standard communication.
  programs.thunderbird = {
    enable = true;
    profiles = {
      proton.isDefault = true;
    };
  };

  home.persistence."/persist/home/sajenim" = {
    directories = [
      # email configuration
      ".config/protonmail"
      # email cache of messages
      ".local/share/protonmail"
      # gpg encrypted passwords
      ".password-store"
    ];
  };
}
