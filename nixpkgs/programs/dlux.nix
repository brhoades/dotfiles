{ pkgs, ... }:
with pkgs; with lib; let
  dlux = rustPlatform.buildRustPackage rec {
    pname = "dlux";
    version = "0.1.1";
    name = "${pname}-${version}";

    nativeBuildInputs = [ libudev pkgconfig ];
    buildInputs = nativeBuildInputs;

    src = fetchFromGitHub {
      owner = "brhoades";
      repo = pname;
      rev = version;
      sha256 = "0z9f2hwnqfamnfn3vy05hgbrhch84zriv5x3a514xwfg9hhg4slz";
    };

    cargoSha256 = "1vkzwblq0r3hkxymc1kf4cv8f29dsk6pvcbbb6xnkgagrx7dxmms";

    meta = {
      description = "dlux is a tiny daemon for hardware brightness control";
      homepage = https://github.com/brhoades/dlux;
      license = licenses.mit;
    };
  };
  lat = fileContents ~/.config/dlux/secrets/lat;
  long = fileContents ~/.config/dlux/secrets/long;
  height = 200;
  brightness = 40;
in {
  systemd.user.services.dlux = {
    Unit = {
      Description = "dlux monitor brightness control daemon";
    };

    Service = {
      Type = "simple";
      ExecStart = ''
        ${dlux}/bin/dlux \
          --log-level="debug"
          --lat="${lat}" \
          --long="${long}" \
          --height="${toString height}" \
          --brightness="${toString brightness}"
      '';
    };
  };
}
