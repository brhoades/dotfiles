#!/usr/bin/env bash
shopt -s extglob
BASEPATH="$HOME/Pictures/screenshots"
MONTHPATH="$BASEPATH/$(date "+%Y")/$(date "+%m")"

[[ ! -d "$MONTHPATH" ]] && mkdir -p "$MONTHPATH"

FILENAME="$MONTHPATH/$(date +"%Y%m%d_%H%M%S_%Z")-ikaia-ss.png"

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
  grim -g "$REGION" "$FILENAME"

  if [[ $CLIPBOARD ]]; then
    cat "$FILENAME" | wl-copy
    notify-send "Screenshot to file and copied to clipboard."
    exit 0
  fi

    notify-send "Screenshot to $FILENAME."
  exit 0
fi

if [[ $CLIPBOARD ]]; then
  grim -g "$REGION" - | wl-copy
fi
