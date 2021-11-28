{ config, pkgs, lib, ... }: {
  imports = [ ./swaylock.nix ];

  options.brodes.windowManager.swayidle = with lib; {
    enable = mkEnableOption "Enable swayidle on sway start";

    pkg = mkOption {
      type = types.package;
      default = pkgs.swayidle;
    };

    dpms = {
      enable = mkEnableOption "enable dpms actions after a timeout";

      timeout = mkOption {
        type = types.nullOr types.int;
        default = 900;
      };

      apply = mkOption {
        type = types.str;
        default = ''swaymsg "output * dpms off"'';
      };

      undo = mkOption {
        type = types.str;
        default = ''swaymsg "output * dpms on"'';
      };
    };

    lock = {
      sleep.enable = mkEnableOption "lock before sleep";
      idle = {
        enable = mkEnableOption "lock before idle timeout";

        timeout = mkOption {
          type = types.nullOr types.int;
          default = 900;
        };
      };
    };
  };

  config.wayland.windowManager.sway = let
    cfg = config.brodes.windowManager.swayidle;
    enabled = cfg.enable && config.wayland.windowManager.sway.enable;
    lockCmd = "${config.brodes.windowManager.lockCmd} -f";
    idleLock = if !cfg.lock.idle.enable then
      [ ]
    else
      [ ''timeout ${toString cfg.lock.idle.timeout} "${lockCmd}"'' ];
    sleepLock =
      if !cfg.lock.sleep.enable then [ ] else [ ''before-sleep "${lockCmd}"'' ];
    dpms = if !cfg.dpms.enable then
      [ ]
    else [
      "	timeout ${toString cfg.dpms.timeout} '${cfg.dpms.apply}'"
      "		resume '${cfg.dpms.undo}'"
    ];
    invocation = lib.concatStringsSep " \\\n"
      ([ "exec ${cfg.pkg}/bin/swayidle -w" ] ++ dpms ++ sleepLock ++ idleLock);

    # bindsym Ctrl+${mod}+l exec 
  in lib.mkIf enabled {
    extraConfig = lib.mkAfter ''
      for_window [app_id="firefox"] inhibit_idle fullscreen
      for_window [app_id="vlc"] inhibit_idle fullscreen
      for_window [app_id="mpv"] inhibit_idle fullscreen
      for_window [app_id="google-chrome*"] inhibit_idle fullscreen

      ${invocation}
    '';
  };
}
