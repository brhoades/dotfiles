{ config, pkgs, lib, ... }:

{
  imports = [
    ../machines/common.nix
    ../programs/development.nix
    ../programs
    ../machines/common.nix
  ];

  user = {
    name = lib.mkDefault "Billy J Rhoades II";
    email = lib.mkDefault "me@brod.es";
    signing = lib.mkDefault { key = "6D052A5305F89A0E!"; };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = lib.mkDefault "aaron";
  home.homeDirectory = lib.mkDefault "/home/aaron";

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
