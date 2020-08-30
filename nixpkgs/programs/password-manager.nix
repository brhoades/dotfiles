{ pkgs, ... }:

{
  programs.password-store = {
    enable = true;
    package = pkgs.gopass;
  };

  home.sessionVariables = {
    GOPASS_NO_NOTIFY = true;
  };

  xdg.configFile.gopassConfig = {
    target = "gopass/config.yml";
    text = ''
      root:
        cliptimeout: 60
        notifications: false
    '';
  };
}
