#!bin/bash
#Version 202001250900h

JSON="https://ws.smn.gob.ar/map_items/weather"
JSONCOVID=$(curl -s -X "GET" "https://gobiernoabierto.bahia.gob.ar/covid-19/data/getCasosDiariosB.php")

INFECTADOS=$(echo $JSONCOVID | jq '.[0] .values[0] .y')
ACTIVOS=$(echo $JSONCOVID | jq '.[1] .values[0] .y')
FALLECIDOS=$(echo $JSONCOVID | jq '.[3] .values[0] .y')

URLAlerta='https://freemeteo.com.ar/eltiempo/bahia-blanca/tiempo-actual/localidad/?gid=3865086&language=spanishar&country=argentina'
#Obtengo JSON
EJECUTA="curl  -s -X \"GET\" \"$JSON\" -H \"Accept: application/json\" -H \"Content-Type: application/json\""
BD=$(eval $EJECUTA)
#189= Bahia Blanca?

#Obtengo datos de la ciudad
X="echo '$BD' | jq --raw-output -c '.[] | select(.name | contains(\"Bahía Blanca\"))'"
BAHIA=$(eval "$X")
    
X="echo '$BAHIA' | jq --raw-output '.\"weather\".\"temp\"'"
Temperatura=$(eval "$X")
X="echo '$BAHIA' | jq --raw-output '.\"weather\".\"wing_deg\"'"
DireccionViento=$(eval "$X")
DireccionViento=${DireccionViento//\"}
X="echo '$BAHIA' | jq --raw-output '.\"weather\".\"wind_speed\"'"
VelViento=$(eval "$X")
X="echo '$BAHIA' | jq --raw-output '.\"weather\".\"description\"'"
Estado=$(eval "$X")
Estado=${Estado//\"}
X="echo '$BAHIA' | jq --raw-output '.\"weather\".\"humidity\"'"
Humedad=$(eval "$X")        
X="echo '$BAHIA' | jq --raw-output '.\"weather\".\"pressure\"'"
Presion=$(eval "$X")        
X="echo '$BAHIA' | jq --raw-output '.\"weather\".\"visibility\"'"
Visibilidad=$(eval "$X")        
X="echo '$BAHIA' | jq --raw-output '.\"weather\".\"st\"'"
ST=$(eval "$X")        

#Defino alertas
ALERTA=$(wget -q -O- "$URLAlerta" | awk -F\' '/<em>Alerta/{print $1}' | head -1)
ALERTA=${ALERTA//"<div class=\"top\"><span class=\"h2\">Bahia Blanca: <em>"/}
ALERTA=${ALERTA//"</em></span></div>"/}

if [ "$ALERTA" != "" ]; then
    if [ $ST == "null" ]; then
        echo " $Temperatura ºC | Viento $DireccionViento a $VelViento km/h > $Estado | Humedad: $Humedad % - Presion: $Presion hPa | Visibilidad: $Visibilidad km"
    else
        echo " $Temperatura ºC - ST: $ST ºC | Viento $DireccionViento a $VelViento km/h > $Estado | Humedad: $Humedad % - Presion: $Presion hPa | Visibilidad: $Visibilidad km"
    fi
    if [ ! -f /tmp/alerta.avisada ]; then
        echo "" > /tmp/alerta.avisada
        TEXT="To: alejandro.baldres@gmail.com,rakelgaitan@gmail.com\nSubject: ❗❗❗ ALERTA | Condiciones alarmantes\nFrom: sistemaautorizador@gmail.com\n\nSistema de alerta climatica\n_________________________\nDescripción de la Alerta:$ALERTA\n______________________"
        echo -e "$TEXT" | sendmail -vt
    fi
    if [ ! -f /tmp/saludo.clima ]; then
        echo "" > /tmp/saludo.clima
        echo "¡Hola Alejandro! Hoy esta $Estado, con una temperatura de $Temperatura grados centigrados y una humedad de $Humedad %. El estado actual de COVID19 en Bahía Blanca es de $INFECTADOS infectados, de los cuales hay $ACTIVOS activos y fallecieron $FALLECIDOS personas. ¡Que tengas un Buen dia!" | espeak -v es-la
    fi
else
    if [ $ST == "null" ]; then
        echo "$Temperatura ºC | Viento $DireccionViento a $VelViento km/h > $Estado | Humedad: $Humedad % - Presion: $Presion hPa | Visibilidad: $Visibilidad km"
    else
        echo "$Temperatura ºC - ST: $ST ºC | Viento $DireccionViento a $VelViento km/h > $Estado | Humedad: $Humedad % - Presion: $Presion hPa | Visibilidad: $Visibilidad km"
    fi
    if [ -f /tmp/alerta.avisada ]; then
        rm /tmp/alerta.avisada
    fi
    if [ ! -f /tmp/saludo.clima ]; then
        echo "" > /tmp/saludo.clima
        echo "¡Hola Alejandro! Hoy esta $Estado, con una temperatura de $Temperatura grados centigrados y una humedad de $Humedad %.  El estado actual de COVID19 en Bahía Blanca es de $INFECTADOS infectados, de los cuales hay $ACTIVOS activos y fallecieron $FALLECIDOS personas. ¡Que tengas un Buen dia!" | espeak -v es-la
    fi
fi
    
