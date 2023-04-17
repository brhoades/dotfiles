{ pkgs, ... }: {
  home.packages = with pkgs; [ fzf _1password ];

  programs.zsh.initExtraBeforeCompInit = ''
    source "${toString ./op.bash}"
  '';
}
