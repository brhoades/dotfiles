{ pkgs, ... }:

{
  imports = [
    ./kitty.nix
    ./password-manager.nix
    ./firefox.nix
  ];

  home.packages = with pkgs; [
    feh 
    pavucontrol

    google-chrome
    thunderbird

    signal-desktop discord slack

    barrier
    xorg.xrandr xorg.xkill scrot

    fira fira-code fira-code-symbols roboto

    # i3-status-rust requires 4
    font-awesome_4
    lm_sensors # i3-status-rust queries for temps
  ];

  gtk = {
    enable = false;
    font = {
      package = pkgs.roboto;
      name = "Roboto 12";
    };
  };

  fonts.fontconfig.enable = true;

  programs.rofi = {
    enable = true;

    theme = "Monokai";

    extraConfig = ''
      run-shell-command: {terminal} -e zsh -c "{cmd}"
      rofi.run-command: ${pkgs.zsh}/bin/zsh -i -c '{cmd}'
      rofi.glob: true
      rofi.regex: true
      rofi.window-command:                 xkill -id {window}
    '';

  };

  xresources.properties = {
    # This mirrors ikaia's DPI.
    "Xft.dpi" = 192; 
    "*.dpi" = 192; 
    "Xft.antialias" = true;
    # "Xft.hinting" = 1;
  };

  xsession = {
    numlock.enable = true;
    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 64;  
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraConfig = ''
      # Don't steal focus
      focus_on_window_activation urgent
      # focus_follows_mouse no
    '';

    config = let
      mod = "Mod4";
      fonts = [
        "FontAwesome 10"
        "Roboto 12"
      ];
      # Define names for default workspaces for which we configure key bindings later on.
      # We use variables to avoid repeating the names in multiple places.
      ws1 = "1:fcs";
      ws2 = "2:cht";
      ws3 = "3:web";
      ws4 = "4";
      ws5 = "5";
      ws6 = "6";
      ws7 = "7";
      ws8 = "8";
      ws9 = "9";
      ws10 = "10";
    in {
      inherit fonts;

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
        "Return" = "mode \"default\"";
        "Escape" = "mode \"default\"";
        "${mod}+r" = "mode \"default\"";
      };

      modifier = mod;
      keybindings = {
        "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${mod}+space" = "exec \"${pkgs.rofi}/bin/rofi -show run -modi run -only-match -matching fuzzy\"";

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

         # focus the parent container
         "${mod}+a" = "focus parent";

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

         "${mod}+Ctrl+greater" = "move workspace to output right";
         "${mod}+Ctrl+less" = "move workspace to output left";

         # reload the configuration file
         "${mod}+Shift+c" = "reload";
         # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
         "${mod}+Shift+r" = "restart";
         # exit i3 (logs you out of your X session)
         "${mod}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'\"";

         "${mod}+r" = "mode \"resize\"";
        
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
        
        # Assignments
        # assign [class="Firefox"] $ws3
        # assign [class="Chromium"] $ws3
        # assign [class="Google-chrome-beta"] $ws2
        # assign [class="RuneLite"] $ws1
        # assign [class="^Steam"] $ws1
        # assign [class="^Emacs"] $ws1
        # assign [class="^discord"] $ws10
        # assign [class="^Signal"] $ws10
        # assign [window_role="WEECHAT"] $ws10
        # assign [class="^Slack"] $ws4
        
        # exec terminator -r WEECHAT -x weechat
        # exec firefox
        # exec signal-desktop
        # exec discord
        # exec dunst
        # exec autocutsel -selection CLIPBOARD -fork
        # exec autocutsel -selection PRIMARY -fork
      };

      gaps = {
        smartGaps = true;
        inner = 6;
        outer = 2;
        smartBorders = "on";
      };

      window = {
        hideEdgeBorders = "smart";
      };

      bars = [{
        inherit fonts;
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${../../dotconfig/i3/desktop.toml}";
        position = "top";
        trayOutput = "DVI-D-0";
        colors = {
          separator = "#666666";
          background = "#222222";
          statusline = "#dddddd";

          focusedWorkspace = {
            background = "#0088CC";
            border = "#0088CC";
            text = "#ffffff";
          };
          activeWorkspace = {
            background = "#333333";
            border = "#333333";
            text = "#ffffff";
          };
          inactiveWorkspace = {
            background = "#333333";
            border = "#333333";
            text = "#888888";
          };
          urgentWorkspace = {
            background = "#2f343a";
            border = "#900000";
            text = "#ffffff";
          };
        };
      }];
    };
  };
}
