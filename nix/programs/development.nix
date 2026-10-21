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
      inputs.nixos-master.go
      delve
      errcheck
      unconvert
      github-cli

      tree
      nmap

      yq
      jq
      python3

      kubectl
      kubectx
      tcpdump
      nixfmt
      nix-tree
      pkgs.inputs.latest.claude-code
    ]
    ++ (if isLinux then [ gdb ] else [ ]);

  programs.vscode = {
    enable = true;
    profiles.default.enableExtensionUpdateCheck = true;
  };
}
