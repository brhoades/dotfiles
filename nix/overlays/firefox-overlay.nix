let
  # Change this to a rev sha to pin
  # moz-rev = "master";
  moz-ref = "e1f7540";
  moz-url = builtins.fetchTarball {
    url =
      "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";
    sha256 = "0wlmf82p93py1vk89j4pv9c92is9zpr9va3f0xwqlh3l2j5nkl1i";
  };
  nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
in nightlyOverlay
