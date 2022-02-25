{ pkgs, ... }: {
  home.packages = with pkgs; [ lorri ];

  services.lorri.enable = true;
}
