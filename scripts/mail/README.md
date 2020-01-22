Notes for future me:
yarn install then symlink the user service over for each full email. Configure offlineimap. Service calls daemonize.sh which setup up imap-notify.

get_password.py is used by offlineimap and is a wrapper for get_password.sh

imap-notify calls incoming_mail.sh on each new message.
