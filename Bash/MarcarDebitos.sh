#!/bin/bash

TEXTO="$1"
cd "/home/alejandro/Documentos/working/Recepciones/TMP/debitos"
for dir in /home/alejandro/Documentos/working/Recepciones/TMP/debitos/*
do 
dir=${dir%*/} 
dir=${dir##*/}
if [ ! -d "$dir" ]; then
    NOMBRE=`echo "$dir" | cut -d'.' -f1`
    EXTENSION=`echo "$dir" | cut -d'.' -f2`
    DESTINO="${NOMBRE}"_mark."${EXTENSION}"
    cp "$dir" "$DESTINO"
    mogrify -resize "1200>" -quality 90 "$DESTINO"
    cupon=${dir:0:3}
    REFACTURABLE=${NOMBRE:6:2}
    longitud=${#NOMBRE}
    motivo=${NOMBRE:11:$longitud}
    echo "P$REFACTURABLE P"
    case $REFACTURABLE in
        "RF")
            REFACTURABLE="REFACTURABLE"
            ;;
        "NF")
            REFACTURABLE="NO REFACTURABLE"
            ;;
        "AF")
            REFACTURABLE=""
            ;;
    esac

    fondo="white"
    letra="black"

#echo -e "$motivo"
    clear
    echo "Procesando Lote $1"
    echo "-----------------------------------"
    echo " Cupon: $cupon"
    echo " Tipo de debito: $REFACTURABLE"
    echo " Motivo de debito: $motivo"
    convert "$DESTINO" -gravity SouthEast -pointsize 19 \
           -fill $fondo -draw "text 13,1 \"$cupon\"" \
            -fill $letra -draw "text 14,2 \"$cupon\"" \
            -fill $fondo -draw "text 4,40 \"$motivo\"" \
            -fill $letra -draw "text 5,42 \"$motivo\"" \
            -fill $fondo -draw "text 205,70 \"$REFACTURABLE\"" \
            -fill $letra -draw "text 205,72 \"$REFACTURABLE\"" \
            -fill $fondo -draw "text 205,101 \"Lote $1\"" \
            -fill $letra -draw "text 205,102 \"Lote $1\"" \
            "$DESTINO"
    fi
done

