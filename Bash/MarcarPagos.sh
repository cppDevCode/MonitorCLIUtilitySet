#!/bin/bash

TEXTO="$1"
DIR_PAGOS="/home/alejandro/Documentos/working/Recepciones/TMP/pagos"
cd "/home/alejandro/Documentos/working/Recepciones/TMP/pagos"
PDF_DIR="${DIR_PAGOS}"/PDF_DIR
#Convierto PDF en Imagenes
for dir in $DIR_PAGOS/*
do
dir=${dir%*/} 
dir=${dir##*/}
if [ ! -d "$dir" ]; then
    NOMBRE=`echo "$dir" | cut -d'.' -f1`
    DESTINO="${NOMBRE}".png
    echo "Convirtiendo a \"$DESTINO\""
    pdftocairo -png "$dir" "$DESTINO"
    echo "Moviendo a $PDF_DIR"
    mv "$dir" "$PDF_DIR"
fi

done

for dir in $DIR_PAGOS/*
do 
dir=${dir%*/} 
dir=${dir##*/}
if [ ! -d "$dir" ]; then
    NOMBRE=`echo "$dir" | cut -d'.' -f1`
    EXTENSION=`echo "$dir" | cut -d'.' -f2`
    DESTINO="${NOMBRE}"_mark."${EXTENSION}"
    cp "$dir" "$DESTINO"
    rm "$dir"
    mogrify -resize "1200>" -quality 90 "$DESTINO"


fondo="white"
letra="black"

#echo -e "$motivo"
#clear
echo "Procesando $NOMBRE"
echo "-----------------------------------"
DIA=$(date +%d/%m/%Y)
convert "$DESTINO" -gravity NorthWest -pointsize 12 \
           -fill $letra -draw "text 13,18 \"Detalle de Pago: $NOMBRE   | CERRADO:$DIA\"" \
            "$DESTINO"
if [ "$1" == "np" ]; then
    echo "No se imprime..."
else lp -o media=A4 -o MediaType=PLAIN_NORMAL -o print_quality=1 "$DESTINO"
fi
fi
done

