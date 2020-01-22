#!/usr/bin/env sh

export PATH="$HOME/.cargo/bin:$PATH"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
CLEAN_USER=$(echo "$IMAP_NOTIFY_USER" | sed -E "s/(@|\.)//g")
echo $CLEAN_USER

export PASS=$(gpg --use-agent -dq "$HOME/.password-store/misc/mail/$IMAP_NOTIFY_USER.gpg" | head -n1 | sed -e "s/\n//")
export HOST=$(cat $HOME/.offlineimaprc | grep -A 4 "$CLEAN_USER" | grep remotehost | sed 's/remotehost = //')

if [[ -z "$HOST" ]]; then 
  echo "Failed to parse host from offlineimaprc with '$CLEAN_USER' as the account"
  exit 1
fi
export DISPLAY=:0
export XAUTHORITY=$HOME/.Xauthority

echo "host: $HOST"

if [[ $? != 0 ]]; then
  notify-send "IMAP: error getting email password for $USER"
fi

exec imap-notifier "$HOST" "$IMAP_NOTIFY_USER" "$PASS" INBOX "$SCRIPTPATH/incoming_mail.sh"
