#!/bin/bash

xsel -o | dmenu -fn 'Ubuntu-18' -p Buscar: | xargs -I '$' urxvt -g 190x110 -e googler -w youtube.com --url-handler mpv $