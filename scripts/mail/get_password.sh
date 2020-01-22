#!/usr/bin/env sh
gpg --use-agent -dq "$HOME/.password-store/misc/mail/$1.gpg" | head -n1
