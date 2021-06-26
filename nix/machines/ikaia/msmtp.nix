{ ... }: {
  programs.msmtp = { enable = true; };

  accounts.email.accounts.ikaiadesktop = rec {
    primary = true;
    realName = "ikaia desktop";
    address = "ikaia@brod.es";
    userName = address;

    smtp = {
      host = "mail.brod.es";
      port = 465;
      tls.enable = true;
    };
    msmtp = {
      enable = true;
      extraConfig = { passwordeval = "cat ${toString ./secrets/msmtp}"; };
    };
  };
}
