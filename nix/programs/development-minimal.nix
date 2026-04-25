{ pkgs, ... }: {
  imports = [ ./git.nix ./vim.nix ];

  home.packages = with pkgs; [
    yq
    jq
    python3

    nixfmt-classic
  ];
}
