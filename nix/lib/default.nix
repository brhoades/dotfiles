# https://raw.githubusercontent.com/TLATER/dotfiles/b4014deafdebc8f02128cba4c7c4a3865effee24/nixpkgs/lib/default.nix
{ nixpkgs, home-manager, overlays }:
nixpkgs.lib // rec {
  # Create a module with correctly set overlays from a given
  # profile.
  #
  nixosModuleFromProfile = profile:
    { ... }@args:
    (profile args) // {
      nixpkgs.overlays = overlays;
    };

  # Create a NixOS module that configures home-manager to use
  # the given profile.
  #
  nixosConfigurationFromProfile = profile: username:
    { ... }@args: {
      home-manager.users.${username} = nixosModuleFromProfile profile;
    };

  # Create a homeManagerConfiguration that can be installed
  # using `home-manager --flake`.
  #
  # https://nix-community.github.io/home-manager/release-notes.html#sec-release-22.11-highlights
  homeConfigurationFromProfile = profile:
    { system, username ? "aaron", homeDirectory ? "/home/${username}"
    , extraSpecialArgs ? { } }:
    (withPkgs system (pkgs:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home = {
	      inherit homeDirectory username; # system extraSpecialArgs;
            };
          }
          (nixosModuleFromProfile profile)
        ];
      }));
    

  withPkgs = system: f:
    let pkgs = import nixpkgs {
      inherit overlays system;
      config.allowUnfree = true;
    };
    in f pkgs;

  localPackagesExcept = system: exceptions:
    withPkgs system
    (pkgs: removeAttrs (import ../pkgs { inherit pkgs; }) exceptions);

  files = import ./files.nix { inherit nixpkgs; };
}
