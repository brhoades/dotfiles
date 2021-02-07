{ config, pkgs, ... }:
{
  options.brodes.windowManager.i3status_rs = with pkgs.lib; {
    enable = mkEnableOption "Enable i3status-rs for sway";

    pkg = mkOption {
      type = types.package;
      default = pkgs.i3status-rust;
    };

    theme = mkOption {
      type = types.str;
      default = "space-villain";
    };

    icons = mkOption {
      type = types.str;
      default = "awesome";
    };

    fonts = mkOption {
      type = types.listOf types.str;
      default = [];
    };

    output = mkOption {
      type = types.nullOr types.str;
    };

    position = mkOption {
      type = types.nullOr types.str;
    };

    colors = mkOption {
      type = types.attrs;
    };

    blocks = {
      net = {
        enable = mkEnableOption "Enable the net block";
        device = mkOption {
          type = types.nullOr types.str;
          default = null;
        };
        format = mkOption {
          type = types.nullOr types.str;
          default = null;
        };
        interval = mkOption {
          type = types.int;
          default = 5;
        };
      };

      temperature = {
        enable = mkEnableOption "Enable the temperature block";

        device = mkOption {
          type = types.nullOr types.str;
          default = null;
        };

        interval = mkOption {
          type = types.int;
          default = 5;
        };
      };

      microphone = {
        enable = mkEnableOption "Enable the microphone block";
      };

      bluetooth = {
        enable = mkEnableOption "Enable the microphone block";

        mac = mkOption {
          type = types.nullOr types.str;
          default = null;
        };

        label = mkOption {
          type = types.nullOr types.str;
          default = null;
        };
      };
    };
  };

  config.wayland.windowManager.sway = let
    swayOn = config.wayland.windowManager.sway.enable;
    cfg = config.brodes.windowManager.i3status_rs;
    netCfg = cfg.blocks.net;
    btCfg = cfg.blocks.bluetooth;

    netBlock = if !netCfg.enable then "" else ''
[[block]]
block = "net"
ip = false
speed_up = false
graph_up = true
use_bits = false
${if netCfg.format == null then "" else "format = \"${netCfg.format}\""}
${if netCfg.device == null then "" else "device = \"${netCfg.device}\""}
interval = ${toString netCfg.interval}

'';

    btBlock = if !btCfg.enable then "" else ''
[[block]]
block = "bluetooth"
mac = "${btCfg.mac}"
label = "${btCfg.label}"

'';

    tempCfg = cfg.blocks.temperature;
    tempBlock = if !tempCfg.enable then "" else ''
[[block]]
block = "temperature"
chip = "${tempCfg.device}"
collapsed = false
interval = ${toString tempCfg.interval}
format = "{min}°-{max}°"

'';

  micBlock = if !cfg.blocks.microphone.enable then "" else ''
[[block]]
block = "sound"
device_kind = "source"
color_overrides = { warning_bg = "#ff0000" }

'';


    statusFile = pkgs.writeText "config.toml" ''
theme = "${cfg.theme}"
icons = "${cfg.icons}"

${netBlock}
[[block]]
block = "memory"
display_type = "memory"
format_mem = "{Mup}%"
format_swap = "{SUp}%"
${tempBlock}
[[block]]
block = "cpu"
interval = 1

[[block]]
block = "load"
interval = 1
format = "{1m}"

[[block]]
block = "sound"
device_kind = "sink"
${micBlock}
${btBlock}
[[block]]
block = "time"
interval = 1
format = "%a %m/%d %R"

'';
  in {
    config = pkgs.lib.mkIf (swayOn && cfg.enable) {
      bars = [
         {
           inherit (cfg) fonts colors position;

           statusCommand = "${cfg.pkg}/bin/i3status-rs ${statusFile}";
           trayOutput = cfg.output;
         }
      ];
    };
  };
}
