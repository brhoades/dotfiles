{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../../programs/desktop.nix
    ../../programs/development.nix
    ../../services/desktop.nix
    ../../programs/steam.nix
    ../../programs/emacs.nix
    ../../programs/wine.nix
    ../../programs/dlux.nix
    ../../programs/bup.nix
    ./msmtp.nix
  ];

  user = {
    name = "Billy J Rhoades II";
    email = "me@brod.es";
    signing =  {
      key = "6D052A5305F89A0E!";
    };
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
