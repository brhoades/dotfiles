 { pkgs, ... }:
 let
   bpass = with pkgs; stdenv.mkDerivation rec {
     name = "bpass-${version}";
     version = "0.1";
     # XXX: these don't do what I think
     propagatedBuildInputs = [
       coreutils
       busybox
       fzf
       gopass
     ];

     src = writeShellScriptBin "bpass" ''
       EXTRAPASS="-c"
       if [[ "$1" == "-c" ]]; then
         EXTRAPASS="-c"
         shift
       fi

       FZFARGS=""
       if [[ $# -gt 0 ]]; then
         FZFARGS="--query="$@""
       fi

       export PSTORE=$(readlink "$HOME/.local/share/password-store")
       RESULT="$(find $PSTORE -type f -not -path '*\.git*' -exec ${pkgs.coreutils}/bin/realpath --relative-to $PSTORE \{\} \; | sed 's/.gpg//' | ${pkgs.fzf}/bin/fzf -1 "$FZFARGS")"
       [[ $? -eq 0 ]] || exit $?

       COM="gopass show "$EXTRAPASS" "$RESULT""
       $COM
     '';

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
