{ pkgs }:
with pkgs;
stdenv.mkDerivation rec {
  name = "schway-${version}";
  version = "0.2";

  src = writeShellScriptBin "schway" ''
    shopt -s extglob
    BASEPATH="$HOME/Pictures/screenshots"
    MONTHPATH="$BASEPATH/$(date "+%Y")/$(date "+%m")"

    [[ ! -d "$MONTHPATH" ]] && mkdir -p "$MONTHPATH"

    FILENAME="$MONTHPATH/$(date +"%Y%m%d_%H%M%S_%Z")-$(hostname)-ss.png"

    CLIPBOARD=false
    FILE=true
    DELAY=0

    for ARG in "$@"; do
      case "$ARG" in
        clip | copy | clipboard | c)
          CLIPBOARD=true
        ;;
      
        delay* | d*)
          DELAY=5
        ;;
      esac
    done

    REGION=$(slurp)
    if [[ ! -z $DELAY ]]; then
      sleep $DELAY
    fi

    if [[ $FILE ]]; then
      # default to select and save
      ${pkgs.grim}/bin/grim -g "$REGION" "$FILENAME"

      if [[ $CLIPBOARD ]]; then
        cat "$FILENAME" | ${pkgs.wl-clipboard}/bin/wl-copy
        notify-send "Screenshot to file and copied to clipboard."
        exit 0
      fi

        notify-send "Screenshot to $FILENAME."
      exit 0
    fi

    if [[ $CLIPBOARD ]]; then
      ${pkgs.grim}/bin/grim -g "$REGION" - | ${pkgs.wl-clipboard}/bin/wl-copy
    fi
  '';

  buildInputs = [
    grim
    slurp
    wl-clipboard
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
