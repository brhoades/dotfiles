#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "$SCRIPT_DIR/.."

TARGET=${TARGET:-".#$(hostname | sed 's/.local$//')"}
echo "Executing against flake output $TARGET"
nix run home-manager/release-23.11 -- switch --flake "$TARGET"
