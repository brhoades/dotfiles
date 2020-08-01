{ options, ... }:

{
  services.gpg-agent = {
    # enable = options.brodes.development;
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentryFlavor = "curses";
  };
}
