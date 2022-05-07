{ pkgs }:
with pkgs; stdenv.mkDerivation rec {
  name = "schway-${version}";
  version = "0.1";

  src = writeShellScriptBin "schway" (builtins.readFile ./schway.sh);

  buildInputs = [
    grim
    slurp
    wl-clipboard

    src
  ];

  installPhase = ''
    mkdir -p "$out/bin"

    cp "${src}/bin/schway" "$out/bin"
  '';

  meta = {
    description = "schway wraps grim/slurp to mimic scrot";
    homepage = "https://brod.es";
    license = "MIT";
  };
}
