{ ... }: {
  programs.zsh.shellAliases = {
    kubectl = "/usr/local/ngrok/bin/kubectl";
    enterngrok = "${/home/aaron/lib/enterngrok}";
  };

  home.packages = with pkgs; [ lorri ];

  services.lorri.enable = true;
}
