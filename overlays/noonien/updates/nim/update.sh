#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl -p jq -p nix-prefetch
set -e

REPO="nim-lang/nightlies"
RELEASES_URL="https://api.github.com/repos/$REPO/releases/latest"
DOWNLOAD_URL=`curl -s $RELEASES_URL | jq -r '.assets[].browser_download_url' | grep osx`

echo $DOWNLOAD_URL
