{ ... }: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false; # every zsh starts in zellij

    settings = {
      default_shell = "zsh";
      copy_on_select = false;
      mouse_mode = false; # don't interfere with copying
    };
  };
}
