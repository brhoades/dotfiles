{ pkgs, ... }:
with pkgs; with lib; let
  dlux = rustPlatform.buildRustPackage rec {
    pname = "dlux";
    version = "0.1.2";
    name = "${pname}-${version}";

    nativeBuildInputs = [ libudev pkgconfig ];
    buildInputs = nativeBuildInputs;

    src = fetchFromGitHub {
      owner = "brhoades";
      repo = pname;
      rev = version;
      sha256 = "0rp711k68q3d53ssmdh5vcwwbqnx9za5i3wfhiwnzad4gzm0aq19";
    };

    cargoSha256 = "1cy9asgwyfbxj75rnbi61ldsmiqp4dxgbgh8pwki91y1gwj7pwri";

    meta = {
      description = "dlux is a tiny daemon for hardware brightness control";
      homepage = https://github.com/brhoades/dlux;
      license = licenses.mit;
    };
  };
in {
  systemd.user.services.dlux = {
    Unit = {
      Description = "dlux monitor brightness control daemon";
    };

    Service = {
      Type = "simple";
      ExecStart = "${dlux}/bin/dlux daemon ${./dlux.yaml}";
    };
  };
}
