#!/usr/bin/env bash
#Run ./wallpaper.sh "Search Term"
#================================

#Path to store wallpaper image, images deleted each refresh to avoid clutter
path=~/Pictures/WP/script/
#Remove the below line if you wish to not delete downloaded wallpapers
rm -rf $path*
#Screen Resolution
resolution='1920x1080'

urla='https://wallhaven.cc/search?q='
urlb='&categories=110&purity=100&resolutions='
urlc='&sorting=random&order=desc'
url=''

html=$( curl -# -L "${urla}$1${urlb}${resolution}${urlc}" 2> '/dev/null' )
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

#Set Pywal Colours to match wallpaper, with alpha 85% and terminal background of black.
wal -i $path$filename -a 85 -b "#000000" --saturate 0.4

feh --bg-fill $path$filename
#Colour Spotify (Update spicetify colours)
spicetify update


