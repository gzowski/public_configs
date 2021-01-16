#!/usr/bin/env bash

path=~/Pictures/WP/script/
rm -rf $path*
url='https://wallhaven.cc/search?categories=010&purity=100&resolutions=1920x1080&sorting=random&order=desc'
html=$( curl -# -L "${url}" 2> '/dev/null' )
latest=$(
        <<< "${html}" \
        grep -P -o -e '(?<=wallhaven.cc\/w\/)(.*?)(?=")' |
        head -n 1
)
url=https://wallhaven.cc/w/$latest
html=$( curl -# -L "${url}" 2> '/dev/null' )
latest=$(
        <<< "${html}" \
        grep -P -o -e '(?<=\/\/w.wallhaven.cc\/full\/)(.*?)(?=")' |
        head -n 1
)
url=https://w.wallhaven.cc/full/$latest
filename=$(echo $url | rev | cut -d"/" -f1 | rev)
wget -O $path$filename $url

#Setting wallpaper, comment out either feh or pywal
feh --bg-scale $path$filename
wal -i $path$filename --saturate 0.4 -a 90






