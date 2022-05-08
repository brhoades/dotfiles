{
  description = "Billy's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";

    user-secrets = {
      url = "path:/var/lib/secrets/users/aaron";
      flake = false;
    };

    firefox-nightly.url =
      "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";

    nur.url = "https://github.com/nix-community/NUR/archive/master.tar.gz";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, latest, user-secrets, firefox-nightly, nur
    , home-manager }: rec {
      inherit self inputs;
      overlays = [ firefox-nightly.overlay nur.overlay ];
      lib = import ./nix/lib { inherit nixpkgs home-manager overlays; };
      profiles = {
        ikaia = import ./nix/machines/ikaia;
        ioane = import ./nix/machines/ioane;
      };

      homeConfigurations = {
        ikaia = lib.homeConfigurationFromProfile profiles.ikaia {
          system = "x86_64-linux";
        };

        # The default configuration is just the minimal profile
        ioane = lib.homeConfigurationFromProfile profiles.ioane {
          system = "x86_64-linux";
        };
      };
    };
}
