{ pkgs, ... }: {
  home.packages = with pkgs; [ fzf _1password-cli ];

  programs.zsh.initContent = with pkgs;
    lib.mkOrder 550 ''
      source "${toString ./op.bash}"
    '';
}
