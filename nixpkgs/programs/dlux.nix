{ pkgs, ... }:
with pkgs; with lib; let
  dlux = rustPlatform.buildRustPackage rec {
    pname = "dlux";
    version = "0.1";
    name = "${pname}-${version}";

    nativeBuildInputs = [ libudev pkgconfig ];
    buildInputs = nativeBuildInputs;

    src = fetchFromGitHub {
      owner = "brhoades";
      repo = pname;
      rev = version;
      sha256 = "1qbc7gqkr9h9yagw3zzbwacpjhb77xdf648fwzfp5ykmxmpj9cj3";
    };

    cargoSha256 = "0hf17mbch5b1gnq7g5jdffiapbjkr0p1zp4ccqin2j5a1h6gph45";

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
          --lat="${lat}" \
          --long="${long}" \
          --height="${toString height}" \
          --brightness="${toString brightness}"
      '';
    };
  };
}
