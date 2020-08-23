#!/bin/bash

xsel -o | dmenu -fn 'Ubuntu-18' -p Reproducir: | xargs -I '$' bash /home/alejandro/bin/playYT.sh $


