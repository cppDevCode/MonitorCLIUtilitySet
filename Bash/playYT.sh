#!/bin/bash
#echo $1 >> /tmp/argumento.txt
#googler --np -w youtube.com "$1" >> /tmp/music.yt
youtube-dl -j "ytsearch10:$1" >> /tmp/music.cache
cat /tmp/music.cache | jq '.fulltitle, .webpage_url' >> /tmp/music.yt

Contador=1;
while read -r line 
do 
case $Contador in
    1) Titulo=${line//\"}
       echo "$Titulo" > /tmp/actual.yt
       echo "Titulo: $Titulo"
       Contador=0
       ;;
    0) line=${line//\"}
        echo "Linea: $line"
        mpv --input-ipc-server=/tmp/mpv.socket --video=no $line 
        Contador=1
        ;;
esac
#if [[ $line == *"YouTube"* ]]; then
#    Titulo=${line//" - YouTube"}
#    echo "$Titulo" > /tmp/actual.yt
#fi
#if [[ $line == *" min. -"* ]]; then
#    Descripcion=$line
#fi
#line=${line// }
#b=${line:0:4}
#if [[ $b == "http" ]]; then
    #zenity --timeout=1 --window-icon=/home/alejandro/bin/sources/youtube.png --notification --text="$Titulo\n$Descripcion"
#    mpv --video=no $line 
#fi

done < /tmp/music.yt
rm /tmp/music.yt
rm /tmp/actual.yt
rm /tmp/music.cache