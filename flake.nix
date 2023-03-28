{
  description = "Billy's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";
    bnixpkgs.url = "github:brhoades/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

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

    rnix.url = "github:nix-community/rnix-lsp";
    rnix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, latest, bnixpkgs, secrets, homeage
    , firefox-nightly, nur, home-manager, rnix, flake-utils }:
    let
      overlays = [
        nur.overlay
        (p: _: {
          # hack to let modules access inputs w/o top-level arg
          inputs = mixedInputs p.system;
        })
        (p: _: { inherit ((mixedInputs p.system).latest) ngrok; })
      ];
      common = [
        {
          # nixos
          nixpkgs.overlays = overlays;
        }
        homeage.homeManagerModules.homeage
      ];
      mixedInputs = system:
        inputs // {
          inherit inputs;
          latest = import latest {
            inherit system;
            config.allowUnfreePredicate = (pkg: true);
          };
          bnixpkgs = import bnixpkgs {
            inherit system;
            config.allowUnfreePredicate = (pkg: true);
          };
        };
      lib = import ./nix/lib { inherit nixpkgs home-manager overlays; };
      profiles = {
        root = _: { imports = [ ./nix/profiles/root.nix ]; };
        ikaia = _: { imports = common ++ [ ./nix/machines/ikaia ]; };
        work = _: { imports = common ++ [ ./nix/machines/work.nix ]; };
        iakona = _: { imports = common ++ [ ./nix/machines/iakona ]; };
        iaukea = _: { imports = common ++ [ ./nix/machines/iaukea ]; };
        # vm or headless profile
        default = _: { imports = common ++ [ ./nix/profiles/default.nix ]; };
        headless-development = _: {
          imports = common ++ [ ./nix/profiles/headless-development.nix ];
        };
      };

    in rec {
      inherit self inputs profiles;
      homeConfigurations = rec {
        aaron = iakona;
        ikaia = lib.homeConfigurationFromProfile profiles.ikaia rec {
          inherit (nixpkgs) system;
          extraSpecialArgs = mixedInputs system;
        };

        work = lib.homeConfigurationFromProfile profiles.work rec {
          inherit (nixpkgs) system;
          extraSpecialArgs = mixedInputs system;
        };

        iakona = lib.homeConfigurationFromProfile profiles.iakona rec {
          inherit (nixpkgs) system;
          extraSpecialArgs = mixedInputs system;
        };

        iaukea = lib.homeConfigurationFromProfile profiles.iaukea rec {
          system = "aarch64-darwin";
          extraSpecialArgs = mixedInputs system;
        };
      };
    };
}
