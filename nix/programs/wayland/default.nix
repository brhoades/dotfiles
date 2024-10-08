{ config, pkgs, lib, ... }:

with lib;
let
  fonts = {
    names = [ "FontAwesome" "Roboto" ];
    style = "Condensed";
    size = 12.0;
  };
  # rightMon = ''"Dell Inc. DELL U2415 CFV9N98G0YDS"'';
  rightMon = ''"Dell Inc. DELL U2720Q F8KFX13"'';
  mainMon = ''"ASUSTek COMPUTER INC PA278CV M3LMQS362198"'';
  topMon = ''"ASUSTek COMPUTER INC PA278CV M3LMQS362207"'';
  laptopMon = ''"Chimei Innolux Corporation 0x14E4 0x00000000"'';
in {
  imports = [ ./mako.nix ./swayidle.nix ./monitors.nix ];

  # wayland-only packages
  home.packages = with pkgs; [
    grim
    slurp # scrot-like behavior

    wl-clipboard # xclip-like behavior

    (import ./schway.nix { inherit pkgs; })

    waypipe

    pulseaudio
  ];

  # This catches rofi, but not sway-launched programs.
  pam.sessionVariables = { MOZ_ENABLE_WAYLAND = "1"; };

  wayland.windowManager.sway = let
    # We use variables to avoid repeating the names in multiple places.
    ws1 = "1:fcs";
    ws2 = "2:trm";
    ws3 = "3:web";
    ws4 = "4:wrk";
    ws5 = "5";
    ws6 = "q";
    ws7 = "w";
    ws8 = "e";
    ws9 = "r";
    ws10 = "a";
    mod = "Mod4";
    includes = [ ./config.d/zoom ./config.d/runelite ];
  in {
    enable = true;
    extraConfig = let
      echo = "${pkgs.busybox}/bin/echo";
      micDevice =
        "alsa_input.usb-RODE_Microphones_RODE_NT-USB-00.analog-stereo";
      mute = pkgs.writeShellScriptBin "mute" ''
        touch /tmp/PTT.log
        ${echo} "first $(date +"%T.%3N")" >> /tmp/PTT.log
        ${pkgs.xautomation}/bin/xte 'keyup XF86AudioPlay'
        ${echo} "end $(date +"%T.%3N")" >> /tmp/PTT.log
      '';
    in ''
      # Don't steal focus
      focus_on_window_activation urgent
      # focus_follows_mouse no

      # Some trouble makers
      no_focus [window_role="^[dD]iscord"]

      output ${topMon} mode 2560x1440@75Hz
      output ${topMon} pos 0 0
      output ${topMon} scale 1
      output ${topMon} transform 0

      # center
      output ${mainMon} mode 2560x1440@75Hz
      output ${mainMon} pos 0 1440
      output ${mainMon} transform 0
      output ${mainMon} scale 1

      # right
      output ${rightMon} mode 3840x2160@59.997002Hz
      output ${rightMon} pos 2560 1440
      output ${rightMon} transform 0
      output ${rightMon} scale 1.25

      # laptop
      output ${laptopMon} pos 0 0

      # default background, rotated in cron (some day)
      # output "*" background "$''${
      #   toString ../../files/backgrounds/geometric-sunset-wpc-yellow-warm.jpg
      # }" fill
      output "*" background #111111 solid_color

      output * adaptive_sync on

      input "1133:4123:Logitech_M705" {
        accel_profile adaptive
        pointer_accel 0.3 # way too zippy
      }

      # workspace -> monitor
      workspace ${ws4}  output ${rightMon}
      workspace ${ws10} output ${rightMon}
      workspace ${ws6}  output ${rightMon} # q
      workspace ${ws3}  output ${mainMon}
      workspace ${ws1}  output ${mainMon}
      workspace ${ws2}  output ${topMon}

      bindsym Ctrl+${mod}+l exec "${config.brodes.windowManager.lockCmd}"

      # for discord
      # bindsym Scroll_Lock exec "${pkgs.xautomation}/bin/xte 'keydown XF86AudioPlay'"
      # bindsym --release Scroll_Lock exec "${mute}/bin/mute"
      # # logitech wireles mouse
      bindsym --whole-window button9 exec "pactl set-source-mute ${micDevice} 0"
      bindsym --whole-window --release button9 exec "pactl set-source-mute ${micDevice} 1"
      # # big mouse
      bindsym Scroll_Lock exec "pactl set-source-mute ${micDevice} 0"
      bindsym --release Scroll_Lock exec "pactl set-source-mute ${micDevice} 1"

      bindsym F12 exec "swaymsg workspace ${ws3}"
      # bindcode 105+62+96 workspace ${ws3}

      # window behavior overrides
      for_window [window_type="notification"] toggle floating
      # thunderbird reminders
      for_window [title="^[0-9]+ Reminders?$" app_id="thunderbird"] toggle floating

    '' + concatMapStringsSep "\n" (f: ''include "${f}"'') includes;

    config = {
      inherit fonts;

      startup = [
        { command = "Discord"; }
        { command = "signal-desktop"; }
        { command = "thunderbird"; }
        { command = ''bash -c "MOZ_ENABLE_WAYLAND=1 exec firefox"''; }
        { command = "mako"; }
      ];

      assigns = {
        "${ws1}" = [
          # { class = "Steam"; }
          # { class = "Emacs"; }
          # { title = "^(zoom|Zoom)"; }
        ];
        # "${ws2}" = [
        #   { class = "net-runelite-client-RuneLite"; }
        #   { title = "RuneLite Launcher"; }
        # ];

        "${ws4}" = [
          {
            class = "Slack";
          }

          # Sway has a hell of a time matching the thunderbird app_id / class
          # it claims to. These four seem to always work versus just class/app_id
          # sometimes working. Maybe thunderbird changes its class on launch?
          { app_id = "thunderbird"; }
          { class = "^[tT]hunderbird.*"; }
          { title = ".*Mozilla Thunderbird$"; }
          { class = "^[Mm]ail"; }
        ];

        "${ws10}" =
          [ { class = "^[Dd]iscord.*"; } { class = "^[Ss]ignal.*"; } ];
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
      keybindings = let
        dirkeys = {
          "j" = "down";
          "k" = "up";
          "l" = "right";
          "h" = "left";
        };
      in {
        "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "${mod}+space" =
          "exec ${pkgs.rofi}/bin/rofi -show run -modi run -only-match -matching fuzzy";

        # alternatively, you can use the cursor keys:
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # move focused window
        # "${mod}+Shift+j" = "move left";
        # "${mod}+Shift+k" = "move down";
        # "${mod}+Shift+l" = "move up";
        # "${mod}+Shift+semicolon" = "move right";
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";

        # alternatively, you can use the cursor keys:
        # "${mod}+Shift+Left" = "move left";
        # "${mod}+Shift+Down" = "move down";
        # "${mod}+Shift+Up" = "move up";
        # "${mod}+Shift+Right" = "move right";

        # Workspace reassignment
        "${mod}+Shift+Left" = "move workspace to output left";
        "${mod}+Shift+Right" = "move workspace to output right";
        "${mod}+Shift+Up" = "move workspace to output up";
        "${mod}+Shift+Down" = "move workspace to output down";

        # split in horizontal orientation
        "${mod}+Shift+v" = "split h";

        # split in vertical orientation
        "${mod}+v" = "split v";

        # enter fullscreen mode for the focused container
        "${mod}+f" = "fullscreen toggle";

        # change container layout (stacked, tabbed, toggle split)
        # "${mod}+s" = "layout stacking";
        # "${mod}+w" = "layout tabbed";
        # "${mod}+e" = "layout toggle split";

        "${mod}+d" = "layout toggle all";
        # kill focused window
        "${mod}+s" = "kill";

        # toggle tiling / floating
        "${mod}+Shift+space" = "floating toggle";

        # change focus between tiling / floating windows
        # "${mod}+space" = "focus mode_toggle";

        # focus the tab above/below.
        # "${mod}+a" = "focus up";
        # "${mod}+Shift+a" = "focus down";

        # focus the child container
        #"${mod}+d" = "focus child";

        # switch to workspace, left hand only keys
        "${mod}+1" = "workspace ${ws1}";
        "${mod}+2" = "workspace ${ws2}";
        "${mod}+3" = "workspace ${ws3}";
        "${mod}+4" = "workspace ${ws4}";
        "${mod}+5" = "workspace ${ws5}";
        "${mod}+q" = "workspace ${ws6}";
        "${mod}+w" = "workspace ${ws7}";
        "${mod}+e" = "workspace ${ws8}";
        "${mod}+r" = "workspace ${ws9}";
        "${mod}+a" = "workspace ${ws10}";

        # legacy switch keybinds
        "${mod}+6" = "workspace ${ws6}";
        "${mod}+7" = "workspace ${ws7}";
        "${mod}+8" = "workspace ${ws8}";
        "${mod}+9" = "workspace ${ws9}";
        "${mod}+0" = "workspace ${ws10}";

        # move focused container to workspace, left hand only keys
        "${mod}+Shift+1" = "move container to workspace ${ws1}";
        "${mod}+Shift+2" = "move container to workspace ${ws2}";
        "${mod}+Shift+3" = "move container to workspace ${ws3}";
        "${mod}+Shift+4" = "move container to workspace ${ws4}";
        "${mod}+Shift+5" = "move container to workspace ${ws5}";
        "${mod}+Shift+q" = "move container to workspace ${ws6}";
        "${mod}+Shift+w" = "move container to workspace ${ws7}";
        "${mod}+Shift+e" = "move container to workspace ${ws8}";
        "${mod}+Shift+r" = "move container to workspace ${ws9}";
        "${mod}+Shift+a" = "move container to workspace ${ws10}";
        ## legacy move keybinds
        "${mod}+Shift+6" = "move container to workspace ${ws6}";
        "${mod}+Shift+7" = "move container to workspace ${ws7}";
        "${mod}+Shift+8" = "move container to workspace ${ws8}";
        "${mod}+Shift+9" = "move container to workspace ${ws9}";
        "${mod}+Shift+0" = "move container to workspace ${ws10}";
        # reload the configuration file
        "${mod}+Shift+c" = "reload";

        # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
        # "${mod}+Shift+r" = "restart";
        # exit i3 (logs you out of your X session)
        # "${mod}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'\"";
        # "${mod}+r" = "mode \"resize\"";

        # Media Keys
        "XF86AudioRaiseVolume" =
          ''exec --no-startup-id pactl set-sink-volume "@DEFAULT_SINK@" "+5%"'';
        "XF86AudioLowerVolume" =
          ''exec --no-startup-id pactl set-sink-volume "@DEFAULT_SINK@" "-5%"'';
        "XF86AudioMute" =
          ''exec --no-startup-id pactl set-sink-mute  "@DEFAULT_SINK@" toggle'';
        "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 4";
        "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 4";

        # custom keyboard keys
        "XF86Launch8" = ''
          exec --no-startup-id pactl set-source-volume "@DEFAULT_SOURCE@" "+2%"'';
        "XF86Launch9" = ''
          exec --no-startup-id pactl set-source-volume "@DEFAULT_SOURCE@" "-2%"'';
        "XF86Launch7" = ''
          exec --no-startup-id pactl set-source-mute "@DEFAULT_SOURCE@" toggle'';

        # "Ctrl + XF86Launch6" = ''exec --no-startup-id "${ddc}" up'';
        # "Alt + XF86Launch6" = ''exec --no-startup-id "${ddc}" down'';

        # bindcode 70 exec "pactl set-source-mute alsa_input.usb-RODE_Microphones_RODE_NT-USB-00.analog-stereo 0"
        # bindcode --release 70 exec "pactl set-source-mute alsa_input.usb-RODE_Microphones_RODE_NT-USB-00.analog-stereo 1"
        #bindsym Scroll_Lock exec "xte 'keydown Scroll_Lock'"
        #bindsym --release Scroll_Lock exec "xte 'keyup Scroll_Lock'"
      } //
      # change focus view
      mapAttrs' (key: dir: nameValuePair ("${mod}+${key}") ("focus ${dir}"))
      dirkeys //
      # move focused view
      mapAttrs'
      (key: dir: nameValuePair ("${mod}+Shift+${key}") ("move ${dir}")) dirkeys;

      gaps = {
        smartGaps = true;
        inner = 6;
        outer = 2;
        smartBorders = "on";
      };

      window = { hideEdgeBorders = "smart"; };
    };
  };

  brodes.windowManager.i3status_rs = {
    inherit fonts;
    enable = true;
    position = "top";
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
        background = "#900000";
        border = "#900000";
        text = "#ffffff";
      };
    };
  };
}
