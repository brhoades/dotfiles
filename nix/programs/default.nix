{ pkgs, ... }: {
  imports = [ ./zsh ./tmux.nix ./pazi.nix ./direnv.nix ./vim.nix ./diagnostics.nix ];

  programs.nix-index.enable = true;
}
