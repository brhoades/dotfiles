{ pkgs, ... }: {
  imports = [ ./git.nix ./vim.nix ./zellij.nix ];

  home.packages = with pkgs; [
    yq
    jq
    python3

    nixfmt
  ];
}
