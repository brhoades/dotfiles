{ username ? "aaron", email ? "aaron@brod.es"
, name ? "Billy J Rhoades II (default profile)",

}:
{ config, pkgs, ... }:

{
  imports = [
    ../machines/common.nix
    ../programs/default.nix
    ../programs/development.nix
    ../programs/emacs.nix
  ];

  user = {
    inherit email name;
    signing = { key = "6D052A5305F89A0E!"; };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory =
    if username == "root" then "/root" else "/home/${username}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
