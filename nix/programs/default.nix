{ pkgs, ... }: {
  imports = [ ./zsh ./tmux.nix ./pazi.nix ./direnv.nix ./vim.nix ];

  programs.nix-index.enable = true;
}
