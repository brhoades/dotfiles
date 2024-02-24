{ ... }: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = {
      default_shell = "zsh";
      copy_on_select = false;
    };
  };
}
