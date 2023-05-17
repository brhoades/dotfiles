{ pkgs, ... }: {
  imports = [ ./emacs.nix ./git.nix ./vim.nix ];

  # if go
  home.packages = with pkgs; [
    go # godef gocode gotags gotools golint delve gocode
    # errcheck go-tools unconvert
    github-cli

    lorri
    gdb
    tree
    nmap
    trippy

    yq
    jq
    tmate
    python3

    kubectl
    kubectx
    tcpdump
    nixfmt
    nix-tree
    colmena
  ];

  home.sessionVariables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };
}
