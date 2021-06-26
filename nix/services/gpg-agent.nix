{ pkgs, config, ... }:
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
      # set per machine
      default-key = pkgs.lib.mkDefault config.user.signing.key;
      keyserver = "https://keyserver.ubuntu.com";
    };
  };
}
