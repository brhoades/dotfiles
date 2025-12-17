# dotfiles

Personal dotfiles managed with Nix and home-manager. MacOS directly installs these through `./scripts/macos-run-hm.sh`
while my dozen+ Linux boxes pull this in via a NixOS flake.

## Overview

This repository uses a Nix flake to declaratively manage my Linux user
configurations. The setup emphasizes reproducibility but still lets some
things, like emacs, color outside the lines and blur purity.

## Structure

```
.
├── nix/
│   ├── profiles/     # Main configuration bundles (root, default, development, etc.)
│   ├── machines/     # Machine-specific instantiations (legacy crap)
│   ├── programs/     # Program-specific configs
│   ├── services/     # Service configurations
│   ├── modules/      # Custom home-manager modules
│   ├── lib/          # Helper functions
│   └── files/        # Static config files
├── dotemacs.d/       # Emacs config (symlinked separately b/c emacs byte-compiles)
├── dotconfig/        # Additional legacy app configs (i3, rofi)
├── zshconfigs/       # Legcy zsh-specific configs
├── scripts/          # Utility scripts and other things installed by nix or to run it
└── flake.nix 
```

## Profiles

The repository is moving to be organized around profiles rather than individual
machines. Profiles bundle together related configurations for different use
cases:

- root - Minimal root user configuration
- default - Base profile for VMs/headless systems
- headless-development - Development environment without GUI
- development - Full development setup with assumed desktop environment

Machine configurations are primarily just wrappers around these profiles.

## Usage
Good luck. Individual modules or patterns may be copied. 

MacOS can be directly installed with the included `./scripts/macos-run-hm.sh`, a matching
hostname profile in the flake, and [nix-darwin](https://github.com/nix-darwin/nix-darwin).
Adding additional hostnames is an easy entrypoint.

Integrating this repo into NixOS is more delicate. See the home-manager documentation,
the link [here](https://nix-community.github.io/home-manager/#sec-install-nixos-module) may
help but don't be surprised if it breaks.

Here's an excerpt from my private NixOS flake where I consume this repo as an input:
```nix
  # [...]
  # https://github.com/nix-community/home-manager/issues/1698#issuecomment-754057568
  # don't see a way to do this locally to HM
  hmInputShim = system: {
    # enforces nixos' latest over home-manager's
    home-manager.extraSpecialArgs.inputs = dotfiles.inputs
    // (mkInputs system);
  };
  hosts = {
    ikaia = {
      fastConnection = true;
      remoteBuild = true;
      hostname = "...";
      sshUser = "aaron";
      nixosSystem = nixos.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = mkInputs system;
        modules = [
          ./common.nix
          ./ikaia
          home.nixosModules.home-manager
          agenix.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          (hmInputShim system)
          {
            # I want to nuke this:
            home-manager.users.aaron = dotfiles.profiles.ikaia;
            home-manager.users.root = dotfiles.profiles.root;
          }
        ];
      };
    };
  # [...]
```

Where I use deploy-rs while also allowing local installs in the primary flake:
```nix
  outputs = inputs@{ self, nixos, deploy-rs, ... }: rec {
    hosts = import ./hosts inputs;
    images = import ./images inputs;

    nixosConfigurations = builtins.mapAttrs (_: sys: sys.nixosSystem) hosts;
    deploy.nodes = builtins.mapAttrs (machine: sys: {
      inherit (sys) hostname fastConnection remoteBuild;
      profiles.system = {
        user = "root";
        inherit (sys) sshUser;
        path = deploy-rs.lib.x86_64-linux.activate.nixos sys.nixosSystem;
        sshOpts = [ "-t" ];
        magicRollback = false; # breaks sudo input collection
      };
    }) hosts;
}
```
