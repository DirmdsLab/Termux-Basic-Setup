#!/usr/bin/env bash

pkg install python
python3 -m pip install -U "yt-dlp[default]"

git clone https://github.com/DirmdsLab/yt-dlp-script.git "external/DirmdsLab/yt-dlp-script"

YTSCRIPT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/external/DirmdsLab/yt-dlp-script/yt-download.sh"
PWDYT="$HOME/Downloads"

sed -i "s|outdir=\"HereChange\"|outdir=\"$PWDYT\"|" "$YTSCRIPT"

echo "[*] Confirming changes:"
grep -A 10 Port "$YTSCRIPT"

chmod +x "$YTSCRIPT"

sed -i "/# Triger-Add/a\    alias yt-download='$YTSCRIPT'" ~/.config/fish/config.fish

pkg install ffmpeg