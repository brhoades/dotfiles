{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Fira Code Retina";
      bold_font = "Fira Code Bold";
      italic_font = "Fira Code Light";
      bold_italic_font = "Fira Code Light";
    };
  };
}
