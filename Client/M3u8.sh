#!/bin/bash

# 📂 Ensure list.txt exists
if [[ ! -f list.txt ]]; then
    echo "🔥 list.txt not found. Drop some URLs in there, friend." >&2
    exit 1
fi

counter=1

# 📥 Loop through each line of the file
while IFS= read -r url || [[ -n "$url" ]]; do
    # Skip empty lines and comments
    [[ -z "$url" || "$url" =~ ^# ]] && continue

    echo -e "\n🚀 Downloading stream #$counter:"
    echo "$url"
    echo "-----------------------------------------"

    yt-dlp \
        --downloader ffmpeg \
        --hls-prefer-ffmpeg \
        --no-part \
        --restrict-filenames \
        --merge-output-format mp4 \
        --progress \
        --output "video_$counter.%(ext)s" \
        "$url"

    if [[ $? -eq 0 ]]; then
        echo "✅ Successfully saved as: video_$counter.mp4"
    else
        echo "💀 Failed to download: $url"
    fi

    ((counter++))
done < list.txt
