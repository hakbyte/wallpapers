#!/bin/bash

# Rename image file. New name is the 20 first characters fo the file's SHA-1 sum
# plus the image pixel size (e.g. 1920x1080). File extension is preserved
# FIXME: implement error checking
function rename {
    local filename=$*
    local dimensions=$(identify -format '%wx%h' "$filename" 2>/dev/null)
    local sha1sum=$(sha1sum "$filename" | cut -c 1-20)
    local new_filename=$(dirname "$filename")/${sha1sum}_${dimensions}.${filename##*.}

    echo "Renamed '$filename' to '$new_filename'"
    mv "$filename" $new_filename 2>/dev/null
}

rename $1
