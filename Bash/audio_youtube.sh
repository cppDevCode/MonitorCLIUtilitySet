#!/bin/bash
YLINK=$(zenity --entry --text="Ingrese Video de Youtube:")
if [ ! -d "/home/alejandro/Vídeos/YT_Audios" ]; then
	mkdir /home/alejandro/Vídeos/YT_Audios
fi
cd /home/alejandro/Vídeos/YT_Audios
zenity --info --text="Bajando: "
bash /home/alejandro/.conky/black_2.0/scripts/youtube.sh $YLINK a
zenity --info --text=" Descargado"
