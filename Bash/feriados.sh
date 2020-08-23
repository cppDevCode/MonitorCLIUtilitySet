#!bin/bash
#Version 202002071916h
HOY=`date -d $(date +%Y%m%d) +%s`
MES=$(date +%m)
DIA=$(date +%d)
ANO=$(date +%Y)
BREAK=0
BD="{
    \"01\":{
                \"1\": \"Año Nuevo\"
            },  
    \"02\":{
            \"5\": \"Feriado UTEDYC\",
            \"24\": \"Carnaval\",
            \"25\": \"Carnaval\"
            },
    \"03\":{
            \"23\": \"Puente Turistico\",
            \"24\": \"Día de la Memoria Verdad y Justicia\"
            },
    \"04\":{   
            \"2\": \"Dia del Veterano de Malvinas\",
            \"9\": \"Jueves Santo\",
            \"10\": \"Viernes Santo\",          
            \"24\": \"Día de Acción por la Tolerancia y el Respeto entre los Pueblos\"
            },
    \"05\":{
            \"1\": \"Dia del Trabajador\",
            \"25\": \"Dia de la Revolucion de Mayo\"
           },
    \"06\":{
            \"15\": \"Martin Güemes\",
            \"20\": \"Dia de la Bandera\"
            },
    \"07\":{
            \"9\": \"Dia de la Independencia\",
            \"10\": \"Puente turistico Yupi :)!\"
            },
    \"08\":{
            \"17\": \"Conmemoracion Gral San Martin\"
            },
    \"10\":{
            \"12\": \"Dia de la Diversidad Cultural\"
            },
    \"11\":{
            \"23\": \"Dia de la Soberania Nacional\"
            },
    \"12\":{
            \"7\": \"Puente turistico Yupi :)!\",
            \"8\": \"Dia de la Inmaculada\",
            \"24\": \"Feriado Medife\",
            \"25\": \"Navidad\",
            \"30\": \"Feriado Medife\"
            }
}"

BREAK=0
if [ $MES -eq 12 ] && [ $DIA -gt 30 ]; then
        ANO=$((ANO + 1))"0101"
        FECHA_FERIADO=`date -d $ANO +%s`
else
        for a in $(eval echo {$MES..12})
        do
                if [ $MES -eq $a ]; then
                        INIT=`echo $((10#$DIA))`
                else INIT=1
                fi
                for i in $(eval echo {$INIT..31})
                do
                        EJECUTA="echo '$BD' | jq --raw-output '.\"$a\".\"$i\"'"
                        DIA1=$(eval "$EJECUTA")
                        if [ "$DIA1" != "null" ]; then
                                if [ $i -lt 10 ]; then
                                        d="0$i"
                                else
                                        d=$i
                                fi
                                ANO1=$ANO$a$d
                                FECHA_FERIADO=`date -d $ANO1 +%s`
                                BREAK=1
                                break
                        fi
                done
         if [ $BREAK -eq 1 ]; then
                break
         fi
        done
fi


FALTAN_DIAS=$(((FECHA_FERIADO-HOY)/86400))

if [ $FALTAN_DIAS -eq 0 ]; then
        if [ ! -f /tmp/.avisado ]; then
    	      zenity --window-icon=/home/alejandro/bin/sources/happy.png --notification --text="Hoy Es $DIA1"
    	      touch /tmp/.avisado
    	fi
        echo "Hoy es el $DIA1!!!"
else
        echo "Faltan $FALTAN_DIAS días para $DIA1"
fi