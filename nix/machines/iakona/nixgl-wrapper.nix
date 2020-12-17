{ pkgs, ... }:
let
  src = pkgs.fetchFromGitHub {
    owner = "guibou";
    repo = "nixGL";
    rev = "7d6bc1b21316bab6cf4a6520c2639a11c25a220e";
    sha256 = "02y38zmdplk7a9ihsxvnrzhhv7324mmf5g8hmxqizaid5k5ydpr3";
  };

  nixGL = import src {};
  mkGLWrap = { pkg, pkgname ? pkg.pname, dstname ? pkgname, pkgver ? pkg.version }: (pkgs.stdenv.mkDerivation rec {
    inherit src;
    pname = "nixgl-${pkgname}";
    version = pkgver;
    buildInputs = [ pkg nixGL.nixGLIntel ];

    installPhase = ''
      mkdir -p $out/bin
      echo "#!/usr/bin/env bash" > "$out/bin/${pkgname}"
      echo "KITTY_ENABLE_WAYLAND=1 nixGLIntel "${pkg}/bin/${pkgname}" \$@" >> "$out/bin/${pkgname}"
      chmod +x "$out/bin/${pkgname}"
      if [[ "${pkgname}" != "${dstname}" ]]; then
        ln -s $out/bin/${pkgname} $out/bin/${dstname}
      fi
    '';
  });
in {
  nixpkgs.config.packageOverrides = pkgs: {
    kitty = mkGLWrap { pkg = pkgs.kitty; };
    rofi = mkGLWrap {
      pkg = pkgs.rofi-unwrapped;
      dstname = "rofi";
    };
  };
}
