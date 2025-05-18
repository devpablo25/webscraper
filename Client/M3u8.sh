#!/bin/bash

# Check if list.txt exists
if [[ ! -f list.txt ]]; then
    echo "🔥 list.txt not found. Feed me some links first!" >&2
    exit 1
fi

# Loop through each line in list.txt
while IFS= read -r url || [[ -n "$url" ]]; do
    # Skip empty lines or lines starting with a #
    [[ -z "$url" || "$url" =~ ^# ]] && continue

    echo "🎯 Downloading from: $url"

    yt-dlp "$url" \
        --no-part \
        --restrict-filenames \
        --hls-use-mpegts \
        --continue \
        --no-check-certificate || echo "💥 Failed to download $url"
    
done < list.txt
