{ pkgs, ... }:

{
  programs.password-store = {
    enable = true;
    package = pkgs.gopass;
  };
}
