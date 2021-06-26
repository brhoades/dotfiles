{ pkgs, config, ... }:

{
  xsession.windowManager.i3 = let
    # We use variables to avoid repeating the names in multiple places.
    ws1 = "1:fcs";
    ws2 = "2:trm";
    ws3 = "3:web";
    ws4 = "4:wrk";
    ws5 = "5";
    ws6 = "6";
    ws7 = "7";
    ws8 = "8";
    ws9 = "9";
    ws10 = "10:cht";
    mod = "Mod4";
    fonts = config.wayland.windowManager.sway.config.fonts;
  in {
    enable = true;
    package = pkgs.i3-gaps;
    extraConfig = ''
      # Don't steal focus
      focus_on_window_activation urgent
      # focus_follows_mouse no

      # Some trouble makers
      no_focus [window_role="^[dD]iscord"]

      workspace ${ws10} output DVI-D-0 # left monitor
      workspace ${ws4} output DVI-D-0  # left monitor
      workspace ${ws3} output DP-2     # 21:9 main
      workspace ${ws1} output DP-2     # 21:9 main
      workspace ${ws2} output HDMI-0   # 4k Monitor
    '';

    config = {
      inherit fonts;

      startup = [
        { command = "Discord"; }
        { command = "signal-desktop"; }
        { command = "thunderbird"; }
        { command = "firefox"; }
      ];

      assigns = {
        "${ws1}" =
          [ { class = "RuneLite"; } { class = "Steam"; } { class = "Emacs"; } ];

        "${ws3}" = [
          # { class = "Firefox"; }
          # { class = "Chromium"; }
          # { class = "Google-chrome(-beta|-stable)?"; }
        ];

        "${ws4}" = [
          { class = "Slack"; }
          { class = "^[Mm]ail"; } # thunderbird
          {
            class = "Daily";
            title = ".*[Tt]hunderbird.*";
          } # thunderbird
        ];

        "${ws10}" = [ { class = "^[Dd]iscord.*"; } { class = "Signal"; } ];
      };

      # resize window (you can also use the mouse for that)
      modes.resize = {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.

        "j" = "resize shrink width 10 px or 10 ppt";
        "k" = "resize grow height 10 px or 10 ppt";
        "l" = "resize shrink height 10 px or 10 ppt";
        "semicolon" = "resize grow width 10 px or 10 ppt";

        # same bindings, but for the arrow keys
        "Left" = "resize shrink width 10 px or 10 ppt";
        "Down" = "resize grow height 10 px or 10 ppt";
        "Up" = "resize shrink height 10 px or 10 ppt";
        "Right" = "resize grow width 10 px or 10 ppt";

        # back to normal: Enter or Escape or $mod+r
        "Return" = ''mode "default"'';
        "Escape" = ''mode "default"'';
        "${mod}+r" = ''mode "default"'';
      };

      modifier = mod;
      keybindings = {
        "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${mod}+space" = ''
          exec "${pkgs.rofi}/bin/rofi -show run -modi run -only-match -matching fuzzy"'';

        # change focus
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";

        # alternatively, you can use the cursor keys:
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # move focused window
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";

        # alternatively, you can use the cursor keys:
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Workspace rotation
        "${mod}+Shift+comma" = "move workspace to output left";
        "${mod}+Shift+period" = "move workspace to output right";

        # split in horizontal orientation
        "${mod}+h" = "split h";

        # split in vertical orientation
        "${mod}+v" = "split v";

        # enter fullscreen mode for the focused container
        "${mod}+f" = "fullscreen toggle";

        # change container layout (stacked, tabbed, toggle split)
        "${mod}+s" = "layout stacking";
        # "${mod}+w" = "layout tabbed";
        # kill focused window
        "${mod}+w" = "kill";
        "${mod}+e" = "layout toggle split";

        # toggle tiling / floating
        "${mod}+Shift+space" = "floating toggle";

        # change focus between tiling / floating windows
        # "${mod}+space" = "focus mode_toggle";

        # focus the tab above/below.
        "${mod}+a" = "focus up";
        "${mod}+Shift+a" = "focus down";

        # focus the child container
        #"${mod}+d" = "focus child";

        # switch to workspace
        "${mod}+1" = "workspace ${ws1}";
        "${mod}+2" = "workspace ${ws2}";
        "${mod}+3" = "workspace ${ws3}";
        "${mod}+4" = "workspace ${ws4}";
        "${mod}+5" = "workspace ${ws5}";
        "${mod}+6" = "workspace ${ws6}";
        "${mod}+7" = "workspace ${ws7}";
        "${mod}+8" = "workspace ${ws8}";
        "${mod}+9" = "workspace ${ws9}";
        "${mod}+0" = "workspace ${ws10}";

        # move focused container to workspace
        "${mod}+Shift+1" = "move container to workspace ${ws1}";
        "${mod}+Shift+2" = "move container to workspace ${ws2}";
        "${mod}+Shift+3" = "move container to workspace ${ws3}";
        "${mod}+Shift+4" = "move container to workspace ${ws4}";
        "${mod}+Shift+5" = "move container to workspace ${ws5}";
        "${mod}+Shift+6" = "move container to workspace ${ws6}";
        "${mod}+Shift+7" = "move container to workspace ${ws7}";
        "${mod}+Shift+8" = "move container to workspace ${ws8}";
        "${mod}+Shift+9" = "move container to workspace ${ws9}";
        "${mod}+Shift+0" = "move container to workspace ${ws10}";
        # reload the configuration file
        "${mod}+Shift+c" = "reload";
        # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
        "${mod}+Shift+r" = "restart";
        # exit i3 (logs you out of your X session)
        "${mod}+Shift+e" = ''
          exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"'';

        "${mod}+r" = ''mode "resize"'';

        # Media Keys
        # bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 2 +5% #increase sound volume
        # bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 2 -5% #decrease sound volume
        # bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle
        # bindsym XF86MonBrightnessDown exec light -U 4 # hw does +1
        # bindsym XF86MonBrightnessUp exec light -A 4

        # bindcode 70 exec "pactl set-source-mute alsa_input.usb-RODE_Microphones_RODE_NT-USB-00.analog-stereo 0"
        # bindcode --release 70 exec "pactl set-source-mute alsa_input.usb-RODE_Microphones_RODE_NT-USB-00.analog-stereo 1"
        #bindsym Scroll_Lock exec "xte 'keydown Scroll_Lock'"
        #bindsym --release Scroll_Lock exec "xte 'keyup Scroll_Lock'"
      };

      gaps = {
        smartGaps = true;
        inner = 6;
        outer = 2;
        smartBorders = "on";
      };

      window = { hideEdgeBorders = "smart"; };

      bars = config.wayland.windowManager.sway.config.bars;
    };
  };
}
