{ config, pkgs, ... }:
{
  systemd.user.timers.update-latest-symlink = {
    Unit = {
      Description = "Update the latest symlink for screenshots.";
      Requires = "update-latest-symlink.service";
    };

    Timer = { 
      # after booting, if we missed a run, run it now
      Persistent = true;
      OnCalendar = "*-*-* 00:00:00";
    };
  };

  systemd.user.services.update-latest-symlink = {
    Unit = {
      Description = config.systemd.user.timers.sync-pictures.Unit.Description;
      Wants = "update-latest-symlink.target";
    };

    Service = {
      Type = "oneshot";
      ExecStart = let
        src = pkgs.writeShellScriptBin "update-symlink.sh" ''
          set +x
          cd "${config.home.homeDirectory}/Pictures/screenshots"
          LATEST="$(date '+%Y')/$(date +'%m')"
          rm latest
          [[ ! -d "$LATEST" ]] && mkdir -p "$LATEST"
          ln -s "$LATEST" latest
        '';
        in "${src}/bin/update-symlink.sh";


    };

    Install.Also = "update-latest-symlink.target";
  };
}
