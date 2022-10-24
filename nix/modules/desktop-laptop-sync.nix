{ pkgs, config, ... }:
with pkgs; {
  home.packages = [
    unison
  ];

  systemd.user.timers.sync-pictures = {
    Unit = {
      Description = "Sync Pictures with ikapua so they appear across ikaia and iakona";
      # TODO: should not run when on battery.
      # BindsTo = ac-power.target
      Requires = "sync-pictures.service";
    };

    Timer = { 
      # 3 minutes after boot
      OnBootSec = "3m";
      # every 15m afterward
      OnUnitActiveSec = "15m";
    };

    Install.WantedBy = ["timers.target"];
  };

  systemd.user.services.sync-pictures = {
    Unit = {
      Description = config.systemd.user.timers.sync-pictures.Unit.Description;
      Wants = "sync-pictures.timer";
    };

    Service = {
      Type = "oneshot";
      ExecStart = ''"${pkgs.unison}/bin/unison" -ui text -dumbtty -batch -retry 3 -copyonconflict -ignore "Path screenshots/latest" "${config.home.homeDirectory}/Pictures" "ssh://aaron@sea.brod.es//media/users/billy/pictures/laptop-desktop-sync"'';
    };

    Install.Also = "sync-pictures.target";
  };
}
