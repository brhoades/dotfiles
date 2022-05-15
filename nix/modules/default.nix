{ pkgs, ... }: {
  imports = [ ./options.nix ];

  nixpkgs.config = { allowUnfree = true; };
  xdg.configFile."nixpkgs/config.nix".source = pkgs.writeTextFile {
    name = "config.nix";
    text = ''
      { allowUnfree = true; }
    '';
  };
}
