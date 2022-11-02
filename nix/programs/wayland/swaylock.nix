{ config, lib, pkgs, ... }: {
  options.brodes.windowManager = {
    swaylock = with lib; {
      pkg = mkOption {
        type = types.package;
        default = pkgs.swaylock;
      };

      background = mkOption {
        # types.oneOf [null ...] does not work :)
        type = types.nullOr (types.oneOf [types.str types.path]);
        default = ../../files/backgrounds/geometric-sunset-wpc-yellow-warm.jpg;
      };
    };

    lockCmd = with lib;
      mkOption {
        type = types.nullOr types.str;
        default = null;
      };
  };

  config.brodes.windowManager.lockCmd = let
    slcfg = config.brodes.windowManager.swaylock;
    bg = if slcfg.background == null then "" else "-i ${toString slcfg.background}";
  in "${slcfg.pkg}/bin/swaylock ${bg} -F -e -c grey --indicator-idle-visible";
}
