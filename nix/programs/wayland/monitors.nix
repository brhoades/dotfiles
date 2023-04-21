{ config, pkgs, ... }: {
  options.brodes.windowManager.monitors = with pkgs.lib; {
    primary = mkOption {
      description = "primary monitor output. used for notifications";
      type = types.nullOr types.str;
    };
  };
}

