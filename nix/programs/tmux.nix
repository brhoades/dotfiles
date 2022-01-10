{ lib, pkgs, ... }:

{
  systemd.user.services = {
    tmux-daemon = {
      Unit = { Description = "tmux background session"; };

      Service = let tmux = "${pkgs.tmux}/bin/tmux";
      in {
        Type = "forking";
        ExecStart = "${tmux} new-session -s %u -d";
        ExecStop = "${tmux} kill-session -t %u";
      };
    };
  };

  home.packages = with pkgs; [ wl-clipboard ];

  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 20000;

    plugins = with pkgs.tmuxPlugins; [
      # sensible defaults
      # messes with XTERM colors? "terminal does not support clear"
      # sensible

      # Show a symbol when prefix is on
      prefix-highlight

      resurrect
      continuum

      # copy to x11/wayland clipboard
      yank
    ];

    # Copy mode (search /)
    keyMode = "vi";

    extraConfig = ''
      # https://github.com/ddollar/tmux/blob/master/examples/screen-keys.conf
      # $Id: screen-keys.conf,v 1.7 2010-07-31 11:39:13 nicm Exp $
      #
      # By Nicholas Marriott. Public domain.
      #
      # This configuration file binds many of the common GNU screen key bindings to
      # appropriate tmux key bindings. Note that for some key bindings there is no
      # tmux analogue and also that this set omits binding some commands available in
      # tmux but not in screen.
      #
      # Note this is only a selection of key bindings and they are in addition to the
      # normal tmux key bindings. This is intended as an example not as to be used
      # as-is.

      # Set the prefix to ^A.
      unbind C-b
      set -g prefix ^A
      bind a send-prefix

      # Bind appropriate commands similar to screen.
      # lockscreen ^X x
      unbind ^X
      bind ^X lock-server
      unbind x
      bind x lock-server

      # screen ^C c
      unbind ^C
      bind ^C new-window
      unbind c
      bind c new-window

      # detach ^D d
      unbind ^D
      bind ^D detach

      # displays *
      unbind *
      bind * list-clients

      # next ^@ ^N sp n
      unbind ^@
      bind ^@ next-window
      unbind ^N
      bind ^N next-window
      unbind " "
      bind " " next-window
      unbind n
      bind n next-window

      # title A
      unbind A
      bind A command-prompt "rename-window %%"

      # other ^A
      unbind ^A
      bind ^A last-window

      # prev ^H ^P p ^?
      unbind ^H
      bind ^H previous-window
      unbind ^P
      bind ^P previous-window
      unbind p
      bind p previous-window
      unbind BSpace
      bind BSpace previous-window

      # windows ^W w
      unbind ^W
      bind ^W list-windows
      unbind w
      bind w list-windows

      # quit \
      unbind '\'
      bind '\' confirm-before "kill-server"

      # kill K k
      unbind K
      bind K confirm-before "kill-window"
      unbind k
      bind k confirm-before "kill-window"

      # redisplay ^L l
      unbind ^L
      bind ^L refresh-client
      unbind l
      bind l refresh-client

      # split -v |
      unbind |
      bind | split-window

      # :kB: focus up
      unbind Tab
      bind Tab select-pane -t:.+
      unbind BTab
      bind BTab select-pane -t:.-

      # " windowlist -b
      unbind '"'
      bind '"' choose-window

      # https://github.com/tmux-plugins/tmux-prefix-highlight
      set -g status-right '#{prefix_highlight} | %a %Y-%m-%d %H:%M'

      # ctrl+arrows
      set-window-option -g xterm-keys on

      # restore automatically
      set -g @continuum-restore 'on'

      # systemd support for continuum
      set -g @continuum-boot 'on'

      set -g @override_copy_command '${pkgs.wl-clipboard}/bin/wl-copy'

      set -g default-terminal "screen-256color"

      # When set to default, was causing control to have a massive delay.
      # Zero purportedly affects other keys but I've not noticed.
      set  -s escape-time       0

      set -g update-environment "WAYLAND_DISPLAY \
                                "

      # Theme
      # set -g @themepack 'powerline/block/green'
    '';
  };
}
