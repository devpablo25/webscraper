#!/bin/bash

# Check if list.txt exists
if [[ ! -f list.txt ]]; then
    echo "🔥 list.txt not found. Feed me some m3u8 links, matey." >&2
    exit 1
fi

counter=1

while IFS= read -r url || [[ -n "$url" ]]; do
    # Skip empty lines or comment lines
    [[ -z "$url" || "$url" =~ ^# ]] && continue

    echo "🎥 Downloading stream $counter from: $url"

    output_file="video_$counter.mp4"

    ffmpeg -y -loglevel info \
        -i "$url" \
        -c copy \
        -bsf:a aac_adtstoasc \
        "$output_file"

    if [[ $? -eq 0 ]]; then
        echo "✅ Saved as $output_file"
    else
        echo "💀 Failed to download $url"
    fi

    ((counter++))

done < list.txt
