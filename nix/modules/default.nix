{ pkgs, ... }: {
  imports = [ ./options.nix ];

  nixpkgs.config = { allowUnfree = true; };
  xdg.configFile."nixpkgs/config.nix".source = let
    file = pkgs.writeTextFile {
      name = "config.nix";
      text = ''
        { allowUnfree = true; };
      '';
    };
  in "${file}/config.nix";
}
