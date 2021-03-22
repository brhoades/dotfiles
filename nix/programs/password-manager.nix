{ pkgs, ... }:
let
  bpass = with pkgs;
    stdenv.mkDerivation rec {
      name = "bpass-${version}";
      version = "0.1";

      fzf = writeShellScriptBin "pass-fzf" ''
        set -euo pipefail

        cd $1
        shift

        ${pkgs.findutils}/bin/find . -type f -not -path '*\.git*' | sed -e 's/\.gpg$//' | exec ${pkgs.fzf}/bin/fzf -1 -0 "$@"
      '';

      src = writeShellScriptBin "bpass" ''
        set -euo pipefail

        EXTRAPASS="-c"
        if [[ "$1" == "-c" ]]; then
          EXTRAPASS="-c"
          shift
        fi

        FZFARGS=""
        if [[ $# -gt 0 ]]; then
          FZFARGS="--query="$@""
        fi

        export PSTORE="$HOME/.local/share/password-store"

        RESULT="$(${fzf}/bin/pass-fzf "$PSTORE" "$FZFARGS")"
        [[ $? ]] || exit $?

        exec ${pkgs.gopass}/bin/gopass show "$EXTRAPASS" "$RESULT"
      '';

      installPhase = ''
        mkdir -p "$out/bin"
        cp -v "${src}/bin/bpass" "$out/bin"
      '';

      meta = {
        description = "bpass wrapper for fuzzy pass";
        homepage = "https://brod.es";
        license = "MIT";
      };
    };
in {
  programs.password-store = {
    enable = true;
    package = pkgs.gopass;
  };

  home = {
    packages = with pkgs; [ pass bpass ];
    sessionVariables.GOPASS_NO_NOTIFY = true;
  };

  xdg.configFile.gopassConfig = {
    target = "gopass/config.yml";
    text = ''
      autoimport: false
      cliptimeout: 60
      exportkeys: false
      mime: true
      nocolor: false
      nopager: false
      notifications: false
      path: /home/aaron/.local/share/password-store
      safecontent: false
      mounts: {}
    '';
  };
}
