{
  imports = [ ./options.nix ];

  nixpkgs.config = { allowUnfree = true; };
  xdg.configFile."nixpkgs/config.nix".source = { allowUnfree = true; };
}
