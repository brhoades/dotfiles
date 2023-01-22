{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ../services/keybase.nix
    ../programs/default.nix
    ../programs/development.nix
    ../programs/ngrok-work.nix
    ../services/desktop.nix
  ];

  user = {
    name = "Billy J Rhoades II";
    email = "billy@ngrok.com";
    signing = { key = "6D052A5305F89A0E!"; };
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
  home.stateVersion = "21.11";
}
