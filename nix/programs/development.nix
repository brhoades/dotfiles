{ pkgs, ... }:
let
  isLinux = with pkgs; lib.strings.hasInfix "linux" stdenv.hostPlatform.system;
in
{
  imports = [
    ./emacs
    ./git.nix
    ./vim.nix
    ./fzf.nix
  ];

  # if go would be nice
  home.packages =
    with pkgs;
    [
      inputs.latest.go
      inputs.latest.gotags
      inputs.latest.gotools
      inputs.latest.golint
      delve
      errcheck
      inputs.latest.go-tools
      unconvert
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
      nixfmt
      nix-tree
      pkgs.inputs.latest.claude-code
    ]
    ++ (if isLinux then [ gdb ] else [ ]);

  home.sessionVariables = {
    GOROOT = "${pkgs.go.out}/share/go";
  };

  programs.vscode = {
    enable = true;
    profiles.default.enableExtensionUpdateCheck = true;
  };
}
