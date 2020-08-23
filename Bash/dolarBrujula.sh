#!/bin/bash
#Version 0.1.6

if [ $(bash /home/alejandro/bin/hayinternet) == "Offline" ]; then
	echo ""
else
    #Obtengo JSON
    EJECUTA="curl  -s -X \"GET\" \"https://servicios.labrujula24.com/cotizaciones/dolar-libre-riesgo.json\" -H \"Accept: application/json\" -H \"Content-Type: application/json\""
    BD=$(eval $EJECUTA)
    echo $BD > /tmp/p
    EJECUTA="echo '$BD' | jq --raw-output '.items[4].\"unico\"'"
    DOLAROFICIAL=$(eval $EJECUTA)
    DOLAROFICIAL=${DOLAROFICIAL//./,}
    EJECUTA="echo '$BD' | jq --raw-output '.items[0].\"unico\"'"
    SOLIDARIO=$(eval $EJECUTA)
    SOLIDARIO=${SOLIDARIO//./,}
    EJECUTA="echo '$BD' | jq --raw-output '.items[5].\"unico\"'"
    RIESGO=$(eval $EJECUTA)
    echo "BANCO NACION: $DOLAROFICIAL | SOLIDARIO: $(printf "%0.2f" "$SOLIDARIO") | RIESGO PAIS: $RIESGO"
fi
