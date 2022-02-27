{ pkgs, ... }:
with pkgs;
with lib;
let
  dlux = rustPlatform.buildRustPackage rec {
    pname = "dlux";
    version = "0.1.2";
    name = "${pname}-${version}b";

    nativeBuildInputs = [ libudev pkgconfig ];
    buildInputs = nativeBuildInputs;

    src = fetchFromGitHub {
      owner = "brhoades";
      repo = pname;
      rev = version;
      sha256 = "03bis0d7r7mllimz6byirh94qzn444k0a1l1m6xvndd7riizqy4y";
    };

    cargoSha256 = "0bklj0hzjc22zywp7998pl836a7r7scic14wsxc16pdklwss90cz";

    meta = {
      description = "dlux is a tiny daemon for hardware brightness control";
      homepage = "https://github.com/brhoades/dlux";
      license = licenses.mit;
    };
  };
in {
  # systemd.user.services.dlux = {
  # Unit = { Description = "dlux monitor brightness control daemon"; };

  # Service = {
  # Type = "simple";
  # ExecStart = "${dlux}/bin/dlux daemon ${./dlux.yaml}";
  # };
  # };
}
