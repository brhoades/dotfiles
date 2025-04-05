#!/usr/bin/env bash
#
# Opening mostly sourced from schway.sh
shopt -s extglob
[[ -z "$HOME" ]] && export HOME="$(pwd)"
BASEPATH="$HOME/Pictures/Screenshots"
MONTHPATH="$BASEPATH/$(date "+%Y")/$(date "+%m")"

[[ ! -d "$MONTHPATH" ]] && mkdir -p "$MONTHPATH"

FILENAME="$MONTHPATH/$(date +"%Y%m%d_%H%M%S_%Z")-$(hostname)-ss.png"

launchctl asuser $(id -u) bash -c "screencapture -S -o -W -s -i "$FILENAME""
launchctl asuser $(id -u) bash -c "osascript -e 'on run args' -e 'set the clipboard to POSIX file (first item of args)' -e end '$FILENAME'"

echo "Wrote screenshot to $FILENAME and copied to clipboard for user $(id -u)."
