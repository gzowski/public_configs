#!/usr/bin/env bash
 
if [ "$(playerctl --player=spotify metadata --format "{{ artist }} - {{ title }}" >>/dev/null 2>&1; echo $?)" == "1" ]; then
    echo ""
else
    playerctl --player=spotify metadata --format "{{ artist }} - {{ title }}"
fi
