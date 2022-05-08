{ pkgs, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    steam = (pkgs.steam.override {
      nativeOnly = true; # use nixos-provided libraries, not steam's.
      extraPkgs = (_: with pkgs; [ mono gtk3 gtk3-x11 libgdiplus zlib ]);
    });
  };

  home.packages = [ pkgs.inputs.latest.steam ];
}
