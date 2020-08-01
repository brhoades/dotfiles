{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = let
    kitty = (import <nixpkgs> {}).kitty;
  in {
    kitty = kitty.override {
      # broken due to gl.
      # buildInputs = [ pkgs.mesa_noglu ];
    };
  };

  programs.kitty = {
    enable = true;

    font = {
      name = "Fira Code Regular 8";
      package = pkgs.fira;
    };
  };
}
