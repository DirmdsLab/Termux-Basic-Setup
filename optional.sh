#!/usr/bin/env bash

pkg install python

python3 -m pip install -U "yt-dlp[default]"

YTSCRIPT="$HOME/File/Script/random/yt-download.sh"
PWDYT="$HOME/Downloads"

sed -i "s|outdir=\"HereChange\"|outdir=\"$PWDYT\"|" "$YTSCRIPT"

echo "[*] Confirming changes:"
grep -A 10 Port "$YTSCRIPT"

chmod +x "$YTSCRIPT"

sed -i "/# Triger-Add/a\    alias yt-download='$HOME/File/Script/random/yt-download.sh'" ~/.config/fish/config.fish

pkg install ffmpeg
