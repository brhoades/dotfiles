{
  description = "Billy's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";

    user-secrets = {
      url = "path:/var/lib/secrets/users/aaron";
      flake = false;
    };

    # upstream firefox-nightly has an unpinned json fetch
    firefox-nightly.url = "github:colemickens/flake-firefox-nightly";

    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, latest, user-secrets, firefox-nightly, nur
    , home-manager }: rec {
      inherit self inputs;
      system = "x86_64-linux";
      overlays = [
        nur.overlay
        (_: _: {
          # allow home-manager to access secrets and latest
          inputs = {
            inherit user-secrets system firefox-nightly;
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
            {
              # nixos
              nixpkgs.overlays = overlays;
            }
            ./nix/profiles/root.nix
          ];
        };
        ikaia = _: {
          imports = [
            {
              # nixos
              nixpkgs.overlays = overlays;
            }
            ./nix/machines/ikaia
          ];
        };
        ioane = _: {
          imports = [
            {
              # nixos
              nixpkgs.overlays = overlays;
            }
            ./nix/machines/ioane
          ];
        };
        iakona = _: {
          imports = [
            {
              # nixos
              nixpkgs.overlays = overlays;
            }
            ./nix/machines/iakona
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
