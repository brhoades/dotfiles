{ pkgs, ... }: {
  home.packages = with pkgs; [ fzf _1password-cli ];

  programs.zsh.initExtraBeforeCompInit = ''
    source "${toString ./op.bash}"
  '';
}
