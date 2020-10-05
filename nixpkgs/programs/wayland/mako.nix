{ pkgs, ... }:
{
  programs.mako = {
    enable = true;
    font = "Roboto 12";
    defaultTimeout = 5 * 1000;
    output = "DP-2";
    anchor = "bottom-left";
  };

  # https://neuron.zettel.page/6479cd5e.html
  systemd.user = {
    startServices = true;

    services.mako = {
      Install.WantedBy = [ "multi-user.target" ];
      Install.After = [ "graphical-session.target" ];
      Unit.Description = "start mako to show notifications";
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.mako}/bin/mako";
      };
    };
  };
}
