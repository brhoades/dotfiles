{ pkgs, ... }: {
  imports =
    [ ./zsh ./tmux.nix ./pazi.nix ./direnv.nix ./vim.nix ./general-tools.nix ];

  programs.nix-index.enable = true;
}
