{ pkgs, ... }: {
  programs.zsh = {
    initExtraBeforeCompInit = ''
      source "/home/aaron/work/ngrok/.cache/ngrok-host-shellhook"
    '';
  };

  home.packages = with pkgs; [ lorri ];

  services.lorri.enable = true;
}
