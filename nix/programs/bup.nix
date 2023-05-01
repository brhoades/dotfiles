{ lib, pkgs, ... }:
let
  bup = with pkgs;
    with lib;
    stdenv.mkDerivation rec {
      name = "bup-${version}";
      version = "0.1";

      buildInputs = [
        awscli
        wl-clipboard
        youtube-dl
        coreutils
        debianutils.out # tempfile
      ];
      bucketName = "i.brod.es";

      src = writeShellScriptBin "bup" ''
        FULLFILE="$1"

        if [[ "$FULLFILE" =~ (reddit\.com|v\.redd\.it|youtu\.be|youtube\.com|t\.co|twitter\.com) ]]; then
          NEWFILE="$(${debianutils.out}/bin/tempfile --prefix="")"
          rm -f "$NEWFILE"

          youtube-dl \
            --output "$NEWFILE.%(ext)s" \
            -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio/bestvideo/bestaudio' \
            -- "$FULLFILE"

          # get the name
          FULLFILE="$(youtube-dl \
            --output "$NEWFILE.%(ext)s" \
            --get-filename \
            -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio/bestvideo/bestaudio' \
            -- "$FULLFILE")"

            trap "rm -f "$FULLFILE"" EXIT ERR
        fi

        ${awscli.out}/bin/aws s3 cp --acl public-read "$FULLFILE" s3://${bucketName}/ || exit $?

        FILENAME="$(basename "$FULLFILE")"
        URI="https://${bucketName}/$FILENAME"
        echo -n "$URI" | ${wl-clipboard}/bin/wl-copy
        ${wl-clipboard}/bin/wl-paste
      '';

      installPhase = ''
        mkdir -p "$out/bin"
        cp "${src}/bin/bup" "$out/bin"
      '';

      meta = {
        description =
          "bup uploads a file to an s3 bucket and prints out the url";
        homepage = "https://brod.es";
        license = licenses.mit;
      };
    };
in { home.packages = [ bup ]; }
