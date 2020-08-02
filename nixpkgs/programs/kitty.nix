{ pkgs, ... }:

{
#  nixpkgs.config.packageOverrides = let
#    kitty = (import <nixpkgs-unstable> {}).kitty;
#  in {
#    kitty = kitty.override {
#      # broken due to gl.
#      # buildInputs = [ pkgs.mesa_noglu ];
#    };
#  };

  home.packages = with pkgs; [
    kitty
  ];

  programs.kitty = {
    # :enable = true;
  };
}
