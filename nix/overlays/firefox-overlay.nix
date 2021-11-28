let
  # Change this to a rev sha to pin
  moz-rev = "master";
  moz-url = builtins.fetchTarball {
    url =
      "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";
  };
  nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
in nightlyOverlay
