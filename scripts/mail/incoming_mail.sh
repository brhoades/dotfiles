#!/usr/bin/env sh

# exists or new
ACTION=$1
ACCOUNT=$2
FOLDER=$3

CLEAN_ACCT=$(echo $ACCOUNT | sed -E "s/(@|\.)//g")

offlineimap -a "$CLEAN_ACCT" -f "$FOLDER"
if [[ $? == 0 ]]; then
    if [[ "$ACTION" -ne "FLAGS" ]]; then
        notify-send "New mail for '$ACCOUNT' in '$FOLDER'"
    fi
else
  notify-send --urgency critical "New mail for '$ACCOUNT' in '$FOLDER' but an error occurred on sync"
fi
