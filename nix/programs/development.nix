{ pkgs, inputs, ... }:
let isLinux = with pkgs; lib.strings.hasInfix "linux" system;
in {
  imports = [ ./emacs ./git.nix ./vim.nix ./zellij.nix ./fzf.nix ];

  # if go
  home.packages = with pkgs; [
    go
    godef
    gotags
    gotools
    golint
    delve
    errcheck
    go-tools
    unconvert
    gopls
    github-cli

      tree
      nmap

      yq
      jq
      tmate
      python3

      kubectl
      kubectx
      tcpdump
      nixfmt-classic
      nix-tree
    ] ++ (if isLinux then [ gdb ] else [ ]);

  home.sessionVariables = { GOROOT = "${pkgs.go.out}/share/go"; };
}
