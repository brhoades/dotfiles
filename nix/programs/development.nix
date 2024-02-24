{ pkgs, inputs, ... }: {
  imports = [ ./emacs ./git.nix ./vim.nix ./zellij.nix ];

  # if go
  home.packages = with pkgs; [
    go godef gocode gotags gotools golint delve gocode
    errcheck go-tools unconvert
    gopls
    github-cli

    gdb
    tree
    nmap

    yq
    jq
    tmate
    python3

    kubectl
    kubectx
    tcpdump
    nixfmt
    nix-tree
  ];

  home.sessionVariables = { GOROOT = "${pkgs.go.out}/share/go"; };
}
