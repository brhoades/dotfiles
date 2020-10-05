{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Fira Code Retina";
      bold_font = "Fira Code Bold";
      italic_font = "Fira Code Light";
      bold_italic_font = "Fira Code Light";

      enable_audio_bell = "no";
      visual_bell_dueration = "0.5";

      background_opacity = "0.85";
      whell_scroll_multiplier = "2";
      strip_trailing_spaces = "smart"; # only on text selections not square
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt"; # if selection, copy, otherwise interrupt
      "ctrl+v" = "paste_from_clipboard"; 
    };
  };

  programs.readline = {
    enable = true;

    bindings = {
      # works in most terminals: xterm, gnome-terminal, terminator, st, sakura, termit, …
      "\\e[1;5C" = "forward-word";
      "\\e[1;5D" = "backward-word";

      # urxvt
      "\\eOc" = "forward-word";
      "\\eOd" = "backward-word";

      ### ctrl+delete
      "\\e[3;5~" = "kill-word";
      # in this case, st misbehaves (even with tmux)
      "\\e[M" = "kill-word";
      # and of course, urxvt must be always special
      "\\e[3^" = "kill-word";

      ### ctrl+backspace
      "\\C-h" = "backward-kill-word";

      ### ctrl+shift+delete
      "\\e[3;6~" = "kill-line";
      "\\e[3@" = "kill-line";
    };
  };
}
