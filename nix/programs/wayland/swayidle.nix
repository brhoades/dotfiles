{ config, pkgs, lib, ... }:
{
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
        default = "output dpms * off";
      };

      undo = mkOption {
        type = types.str;
        default = "output dpms * on";
      };
    };
  };

  config.wayland.windowManager.sway = let
    cfg = config.brodes.windowManager.swayidle;
    enabled = cfg.enable && config.wayland.windowManager.sway.enable;
    dpms = if !cfg.dpms.enable then [] else [
      "\ttimeout ${toString cfg.dpms.timeout} '${cfg.dpms.apply}'"
      "\t\tresume '${cfg.dpms.undo}'"
    ];
    invocation = lib.concatStringsSep " \\\n" (["exec ${cfg.pkg}/bin/swayidle -w"] ++ dpms);
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
