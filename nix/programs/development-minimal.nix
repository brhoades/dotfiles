{ pkgs, ... }: {
  imports = [ ./git.nix ./vim.nix ];

  home.packages = with pkgs; [
    yq
    jq
    python3

    nixfmt
  ];

  home.sessionVariables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };
}
