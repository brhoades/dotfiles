{
  description = "Billy's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";

    secrets = {
      url = "git+ssh://git@sea.brod.es/~/secrets";
      flake = false;
    };

    homeage.url = "github:jordanisaacs/homeage";
    homeage.inputs.nixpkgs.follows = "nixpkgs";

    # upstream firefox-nightly has an unpinned json fetch
    firefox-nightly.url = "github:colemickens/flake-firefox-nightly";

    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, latest, secrets, homeage, firefox-nightly, nur
    , home-manager }: rec {
      inherit self inputs;
      common = [
        {
          # nixos
          nixpkgs.overlays = overlays;
        }
        homeage.homeManagerModules.homeage
      ];
      system = "x86_64-linux";
      overlays = [
        nur.overlay
        (_: _: {
          # allow home-manager to access secrets and latest
          inputs = {
            inherit secrets system firefox-nightly;
            latest = import latest {
              system = self.system;
              config.allowUnfreePredicate = (pkg: true);
            };
          };
        })
      ];
      lib = import ./nix/lib { inherit nixpkgs home-manager overlays; };
      profiles = {
        root = _: {
          imports = [
            ./nix/profiles/root.nix
          ];
        };
        ikaia = _: {
          imports = common ++ [
            ./nix/machines/ikaia
          ];
        };
        ioane = _: {
          imports = common ++ [
            ./nix/machines/ioane
          ];
        };
        iakona = _: {
          imports = common ++ [
            ./nix/machines/iakona
          ];
        };
        # vm or headless profile
        default = _: {
          imports = common ++ [
            ./nix/profiles/default.nix
          ];
        };
      };

      homeConfigurations = rec {
        aaron = iakona;
        # this lets home-manager --flake '.#' work, but it isn't permanent
        "" = iakona;
        ikaia =
          lib.homeConfigurationFromProfile profiles.ikaia { inherit system; };

        ioane =
          lib.homeConfigurationFromProfile profiles.ioane { inherit system; };

        iakona =
          lib.homeConfigurationFromProfile profiles.iakona { inherit system; };
      };
    };
}
