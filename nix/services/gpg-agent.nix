{ options, ... }:

{
  services.gpg-agent = {
    # enable = options.brodes.development;
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    # pinentryFlavor = "curses";
  };

  programs.gpg = {
    enable = true;
    settings = {
      default-key = "5BEA9B121D098D860A0AC25E0017C0956096FC18";
      keyserver = "https://keys.openpgp.org";
    };
  };
}
