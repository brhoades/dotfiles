 { pkgs, ... }:
 let
   bpass = with pkgs; stdenv.mkDerivation rec {
     name = "bpass-${version}";
     version = "0.1";

     src = writeShellScriptBin "bpass" ''
       EXTRAPASS=""
       if [[ "$1" == "-c" ]]; then
         EXTRAPASS="-c0"
         shift
       fi

       FZFARGS=""
       if [[ $# -gt 0 ]]; then
         FZFARGS="--query="$@""
       fi

       export PSTORE="$HOME/.local/share/password-store"
       RESULT="$(${busybox}/bin/find $PSTORE -type f -not -path '*\.git*' -exec ${coreutils}/bin/realpath --relative-to $PSTORE \{\} \; | ${busybox}/bin/sed 's/.gpg//' | ${fzf}/bin/fzf -1 "$FZFARGS")"
       [[ $? -eq 0 ]] || exit $?
       echo "Chose $RESULT"

       ${gopass}/bin/gopass show $EXTRAPASS "$RESULT"
     '';

     buildInputs = with pkgs; [
     ];

     installPhase = ''
       mkdir -p "$out/bin"

       cp "${src}/bin/bpass" "$out/bin"
     '';

     meta = {
       description = "bpass wrapper for fuzzy pass";
       homepage = https://brod.es;
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
           root:
           cliptimeout: 60
           path: /home/aaron/.local/share/password-store
           notifications: false
     '';
   };
 }
