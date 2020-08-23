#!bin/bash
#Version 202001250906h

JSON="https://ws.smn.gob.ar/map_items/weather"

EJECUTA="curl  -s -X \"GET\" \"$JSON\" -H \"Accept: application/json\" -H \"Content-Type: application/json\""
BD=$(eval $EJECUTA)
#189= Bahia Blanca?

#Obtengo datos de la ciudad
X="echo '$BD' | jq --raw-output -c '.[] | select(.name | contains(\"Bahía Blanca\"))'"
BAHIA=$(eval "$X")

#Defino Icono de CLima
X="echo '$BAHIA' | jq --raw-output '.\"weather\".\"id\"'"

case $(eval "$X") in
            0) echo ""
                ;;
            1) echo ""
                ;;
            2) echo ""
                ;;
            3) echo ""
                ;;
            4) echo ""
                ;;
            10) echo ""
                ;;
esac