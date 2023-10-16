{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    # having issues with fonts after an update?
    # fc-cache -rf  to reset. kitty is sensitive.
    settings = {
      font_family = "Fira Code";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      enable_audio_bell = "no";

      background_opacity = "0.85";
      touch_scroll_multiplier = "2";
      strip_trailing_spaces = "smart"; # only on text selections not square
    };

    environment = {
      "TERM" = "tmux-256color"; # kitty defaults to xterm-kitty, which busts ssh
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
