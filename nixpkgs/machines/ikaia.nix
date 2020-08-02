{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ../programs/desktop.nix
    ../programs/git.nix
    ../programs/emacs.nix
  ];

  user = {
    name = "Billy J Rhoades II";
    email = "me@brod.es";
    signing =  {
      key = "6D052A5305F89A0E!";
    };
  };

  # Gets around arch locale issues with direnv.
  home.sessionVariables = with pkgs; {
    # https://github.com/NixOS/nix/issues/599
    # Never worked.
    # LOCALE_ARCHIVE = pkgs.glibc-locales + "/lib/locale/archive";
    LOCALE_ARCHIVE = /usr/lib/locale/locale-archive;
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aaron";
  home.homeDirectory = "/home/aaron";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
