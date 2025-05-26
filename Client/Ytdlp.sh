#!/bin/bash

# This script reads URLs from list.txt, downloads them with yt-dlp,
# and appends a UUID to each filename after downloading.

set -e

if [[ ! -f list.txt ]]; then
  echo "🚫 list.txt not found!"
  exit 1
fi

if ! command -v uuidgen >/dev/null 2>&1; then
  echo "🚫 uuidgen not found! Install it first (e.g., sudo apt install uuid-runtime)"
  exit 1
fi

yt-dlp -a list.txt \
  --no-overwrites \
  --merge-output-format mp4 \
  --hls-prefer-ffmpeg \
  --restrict-filenames \
