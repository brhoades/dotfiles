{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "FiraCode";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      enable_audio_bell = "no";
      # SO BRIGHT.
      # visual_bell_duration = "0.05";

      background_opacity = "0.85";
      # wheel_scroll_multiplier = "1"; for X11
      touch_scroll_multiplier = "2";
      strip_trailing_spaces = "smart"; # only on text selections not square
    };

    keybindings = {
      "ctrl+c" = "copy_and_clear_or_interrupt";
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
