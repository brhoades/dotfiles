{ config, pkgs, ... }:

{
  imports = [
    ../machines/common.nix
    ../programs/development-minimal.nix
  ];

  user = {
    name = "Billy J Rhoades II (root)";
    email = "root@brod.es";
    signing = { key = "6D052A5305F89A0E!"; };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "root";
  home.homeDirectory = "/root";

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
