{ pkgs, config, ... }: {
  imports = [
    # ../../programs/development.nix
    ../../programs/emacs.nix
    ../../programs/development-minimal.nix
    ../../programs/kitty.nix
    ../../programs/vim.nix
    ../../programs/git.nix
    ../../programs
    # ../../programs/zsh.nix
    ../../programs/zsh
    ../../programs/tmux.nix
    ../../programs/pazi.nix
    ../../programs/direnv.nix
    ../common.nix
  ];

  home.packages = with pkgs; [
    mosh
    nix-index
    rustup
    github-cli
  ];

  programs.kitty = {
    keybindings = {
      "alt+left" = "send_text all \x1b\x62";
      "alt+right" = "send_text all \x1b\x66";
    };
  };

  programs.man.enable = false; # doesn't even build on aarch64
  manual.manpages.enable = false; 

  user = {
    name = "Billy J Rhoades II";
    email = "brhoades@rippling.com";
    signing = { key = "F372D673E3A1FCFA!"; };
  };

  home = {
    # an anonymous function is setting these as well
    username = pkgs.lib.mkForce "billy";
    homeDirectory = pkgs.lib.mkForce "/Users/billy";

    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";
  };
}
