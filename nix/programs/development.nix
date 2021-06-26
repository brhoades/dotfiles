{ pkgs, ... }: {
  imports = [ ./emacs.nix ./git.nix ];

  # if go
  home.packages = with pkgs; [
    go # godef gocode gotags gotools golint delve gocode
    # errcheck go-tools unconvert
    github-cli

    lorri
    gdb
    tree
    nmap

    yq jq
    tmate
    python3

    kubectl kubectx
    tcpdump
  ];

  home.sessionVariables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };
}
