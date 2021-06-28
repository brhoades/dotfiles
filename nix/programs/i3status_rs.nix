{ config, pkgs, ... }: {
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
          default = "{speed_up;M} {speed_down;M} {graph_down;M}";
        };

        format_alt = mkOption {
          type = types.nullOr types.str;
          default =
            "{ssid} {signal_strength} {ip} {speed_down} {speed_up} {graph_down;K}";
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
          default = "{percentage}% {time}";
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
      };

      microphone = { enable = mkEnableOption "Enable the microphone block"; };

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

      notify.enable = mkEnableOption "Enable the notify block";

      weather = {
        enable = mkEnableOption "Enable the weather block";

        autolocate = mkOption {
          type = types.bool;
          default = true;
        };

        format = mkOption {
          type = types.str;
          default = "{weather} {temp}";
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
    };
  };

  config.wayland.windowManager.sway = let
    swayOn = config.wayland.windowManager.sway.enable;
    cfg = config.brodes.windowManager.i3status_rs;
    netCfg = cfg.blocks.net;
    nmCfg = cfg.blocks.networkmanager;
    btCfg = cfg.blocks.bluetooth;
    batCfg = cfg.blocks.battery;

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
      label = "${btCfg.label}"

    '';

    tempCfg = cfg.blocks.temperature;
    tempBlock = if !tempCfg.enable then
      ""
    else ''
      [[block]]
      block = "temperature"
      chip = "${tempCfg.device}"
      collapsed = false
      interval = ${toString tempCfg.interval}
      format = "{min}-{max}"

    '';

    micBlock = if !cfg.blocks.microphone.enable then
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
    notifyBlock = if !cfg.blocks.notify.enable then
      ""
    else ''
      [[block]]
      block = "notify"
    '';

    # only supports dunst, not mako
    weatherBlock = if !cfg.blocks.weather.enable then
      ""
    else ''
      [[block]]
      block = "weather"
      format = "${cfg.blocks.weather.format}"
      ${if cfg.blocks.weather.service == null then
        ""
      else
        "service = ${cfg.blocks.weather.service}"}

    '';

    statusFile = pkgs.writeText "config.toml" ''
      theme = "${cfg.theme}"
      icons = "${cfg.icons}"

      ${netBlock}
      ${nmBlock}
      [[block]]
      block = "memory"
      display_type = "memory"
      format_mem = "{mem_used_percents}"
      format_swap = "{swap_used_percents}"
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
