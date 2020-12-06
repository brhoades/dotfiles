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
      default-key = "AA01843B936D466B886AB3DF3F21ED9DCDB84AF1";
      keyserver = "https://keys.openpgp.org";
    };
  };
}
