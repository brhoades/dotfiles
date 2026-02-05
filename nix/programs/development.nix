{ pkgs, inputs, ... }:
let isLinux = with pkgs; lib.strings.hasInfix "linux" stdenv.hostPlatform.system;
in {
  imports = [ ./emacs ./git.nix ./vim.nix ./zellij.nix ./fzf.nix ];

  # if go would be nice
  home.packages = with pkgs;
    [
      go
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
      pkgs.inputs.latest.claude-code
    ] ++ (if isLinux then [ gdb ] else [ ]);

  home.sessionVariables = { GOROOT = "${pkgs.go.out}/share/go"; };

  programs.vscode = {
    enable = true;
    profiles.default.enableExtensionUpdateCheck = true;
  };
}
