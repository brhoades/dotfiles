{ config, pkgs, inputs, ... }: {
  options.brodes.windowManager.i3status_rs = with pkgs.lib; {
    enable = mkEnableOption "Enable i3status-rs for sway";

    pkg = mkOption {
      type = types.package;
      default = pkgs.inputs.bnixpkgs.i3status-rust;
    };

    theme = mkOption {
      type = types.str;
      default = "space-villain";
    };

    icons = mkOption {
      type = types.str;
      default = "awesome";
    };

    fonts = mkOption { type = types.attrs; };

    output = mkOption {
      description = "Display to output the system tray on";
      type = types.nullOr types.str;
    };

    position = mkOption { type = types.nullOr types.str; };

    colors = mkOption { type = types.attrs; };

    blocks = {
      net = {
        enable = mkEnableOption "Enable the net block";

        device = mkOption {
          type = types.nullOr types.str;
          default = null;
        };

        format = mkOption {
          type = types.nullOr types.str;
          default =
            "^icon_net_down $speed_down.eng(3,B,K) ^icon_net_up $speed_up.eng(3,B,K) ";
        };

        format_alt = mkOption {
          type = types.nullOr types.str;
          default =
            "$ssid $signal_strength $ip ^icon_net_down $speed_down.eng(3,B,K) ^icon_net_up $speed_up.eng(3,B,K)";
        };

        interval = mkOption {
          type = types.int;
          default = 5;
        };
      };

      networkmanager = {
        enable = mkEnableOption "Enable the network manager block";

        primaryOnly = mkOption {
          type = types.nullOr types.bool;
          default = false;
        };

        include = mkOption {
          type = types.nullOr types.listOf types.str;
          default = null;
        };

        exclude = mkOption {
          type = types.nullOr types.listOf types.str;
          default = [ "br\\-[0-9a-f]{12}" "docker\\d+" ];
        };

        onClick = mkOption {
          type = types.nullOr types.str;
          default = "${pkgs.kitty}/bin/kitty --hold nmcli";
        };
      };

      battery = {
        enable = mkEnableOption "Enable the battery block";

        format = mkOption {
          type = types.nullOr types.str;
          default = "$icon $percentage $time";
        };

        interval = mkOption {
          type = types.int;
          default = 10;
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

        format = mkOption {
          type = types.str;
          default = "$icon $min - $max";
        };
      };

      microphone = { enable = mkEnableOption "Enable the microphone block"; };

      bluetooth = {
        enable = mkEnableOption "Enable the microphone block";

        mac = mkOption {
          type = types.nullOr types.str;
          default = null;
        };

        format = mkOption {
          type = types.nullOr types.str;
          default = "$icon $name{$percentage|}";
        };
      };

      notify.enable = mkEnableOption "Enable the notify block";

      weather = {
        enable = mkEnableOption "Enable the weather block";

        autolocate = mkOption {
          type = types.bool;
          default = true;
        };

        format = mkOption {
          type = types.str;
          default = "$icon $weather $temp";
        };

        interval = mkOption {
          type = types.int;
          default = 600;
        };

        # TOML string to configure the service
        service = mkOption {
          type = types.nullOr types.str;
          default = null;
        };
      };

      backlight = {
        enable = mkEnableOption "Enable the brightness block";

        device = mkOption {
          type = types.str;
          default = "intel_backlight";
        };

        stepWidth = mkOption {
          type = types.int;
          default = 5;
        };

        invertIcons = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config.wayland.windowManager.sway = let
    swayOn = config.wayland.windowManager.sway.enable;
    cfg = config.brodes.windowManager.i3status_rs;
    netCfg = cfg.blocks.net;
    nmCfg = cfg.blocks.networkmanager;
    btCfg = cfg.blocks.bluetooth;
    batCfg = cfg.blocks.battery;
    tempCfg = cfg.blocks.temperature;
    blCfg = cfg.blocks.backlight;
    micCfg = cfg.blocks.microphone;
    notifyCfg = cfg.blocks.notify;
    wthrCfg = cfg.blocks.weather;

    netBlock = if !netCfg.enable then
      ""
    else ''
      [[block]]
      block = "net"
      ${if netCfg.format == null then "" else ''format = "${netCfg.format}"''}
      ${if netCfg.format_alt == null then
        ""
      else
        ''format_alt = "${netCfg.format_alt}"''}
      ${if netCfg.device == null then "" else ''device = "${netCfg.device}"''}

    '';

    nmBlock = let
      exclude = if nmCfg.exclude == null then
        ""
      else
        "exclude = [${builtins.concatMapStringsSep ", " nmCfg.exclude}]";
      include = if nmCfg.include == null then
        ""
      else
        "include = [${builtins.concatMapStringsSep ", " nmCfg.include}]";
    in if !nmCfg.enable then
      ""
    else ''
      [[block]]
      block = "networkmanager"
      ${if nmCfg.onClick == null then
        ""
      else
        ''on_click = "${toString nmCfg.onClick}"''}
      ${include}
      ${exclude}
      ${if nmCfg.primaryOnly == null then
        ""
      else
        "primary_only = ${toString nmCfg.primaryOnly}"}
      interval = ${toString netCfg.interval}

    '';

    btBlock = if !btCfg.enable then
      ""
    else ''
      [[block]]
      block = "bluetooth"
      mac = "${btCfg.mac}"
      format = "${btCfg.format}"

    '';

    tempBlock = if !tempCfg.enable then
      ""
    else ''
      [[block]]
      block = "temperature"
      chip = "${tempCfg.device}"
      interval = ${toString tempCfg.interval}
      format = "${tempCfg.format}"

    '';

    micBlock = if !micCfg.enable then
      ""
    else ''
      [[block]]
      block = "sound"
      device_kind = "source"
      # no longer supported?
      # color_overrides = { warning_bg = "#ff0000" }

    '';

    batBlock = if !batCfg.enable then
      ""
    else ''
      [[block]]
      block = "battery"
      ${if batCfg.format == null then "" else ''format = "${batCfg.format}"''}
      interval = ${toString netCfg.interval}

    '';

    # only supports dunst, not mako
    notifyBlock = if !notifyCfg.enable then
      ""
    else ''
      [[block]]
      block = "notify"

    '';

    # only supports dunst, not mako
    weatherBlock = if !wthrCfg.enable then
      ""
    else ''
      [[block]]
      block = "weather"
      format = "${wthrCfg.format}"
      ${if wthrCfg.service == null then "" else "service = ${wthrCfg.service}"}

    '';

    backlightBlock = if !blCfg.enable then
      ""
    else ''
      [[block]]
      block = "backlight"
      device = "${blCfg.device}"
      step_width = ${toString blCfg.stepWidth}
      invert_icons = ${if blCfg.invertIcons then "true" else "false"}

    '';

    statusFile = pkgs.writeText "config.toml" ''
      [icons]
      icons = "${cfg.icons}"

      [theme]
      theme = "${cfg.theme}"

      ${netBlock}
      ${nmBlock}
      [[block]]
      block = "memory"
      format = "$icon $mem_used.eng(3,B,M) /$mem_total.eng(3,B,M)"

      ${tempBlock}
      [[block]]
      block = "cpu"
      interval = 5

      [[block]]
      block = "load"
      interval = 15
      format = "$icon $1m.eng(3)"

      [[block]]
      block = "sound"
      device_kind = "sink"
      ${backlightBlock}
      ${micBlock}
      ${btBlock}
      ${batBlock}
      ${notifyBlock}
      ${weatherBlock}
      [[block]]
      block = "time"
      interval = 1
      format = "%a %m/%d %R"

    '';
  in {
    config = pkgs.lib.mkIf (swayOn && cfg.enable) {
      bars = [{
        inherit (cfg) fonts colors position;

        statusCommand = "${cfg.pkg}/bin/i3status-rs ${statusFile}";
        trayOutput = cfg.output;
      }];
    };
  };
}
