{ lib, config, pkgs, ... }: {
  programs.mako = {
    enable = true;

    font = "Roboto 12";
    anchor = "top-center";
    margin = "1"; # distance from top
    padding = "2"; # interior

    defaultTimeout = 5 * 1000;
    maxVisible = 1;

    output = "DP-2";

    # ../default.nix wayland
    # AA for slightly transparent
    backgroundColor = "#222222AA";
    textColor = "#FFFFFFFF";
    borderColor = "#333333BB";

    icons = false;
  };

  # https://neuron.zettel.page/6479cd5e.html
  systemd.user = {
    startServices = true;

    services.mako = {
      Unit.Description = "start mako to show notifications";
      Unit.After = [ "graphical-session.target" ];
      Install.WantedBy = [ "multi-user.target" ];
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.mako}/bin/mako";
      };
    };
  };

  home.packages = with pkgs;
    [
      libnotify # notify-send
    ];

  xdg.configFile."mako/config".onChange =
    lib.mkIf config.programs.mako.enable ''
      systemctl --user restart mako.service
    '';
}
