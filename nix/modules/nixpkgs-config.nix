{
  allowUnfree = true;

  packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball {
      # XXX: move into flake
      url = "https://github.com/nix-community/NUR/archive/e648691.tar.gz";
      sha256 = "1r3q7rqn4fz8mrp834kngr4n0lqay86f6204fhqwm1x6vml11752";
    }) { inherit pkgs; };
  };
}
