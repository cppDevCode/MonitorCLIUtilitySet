#!bin/bash
sleep 10
JSON=$(curl -s -X "GET" "https://gobiernoabierto.bahia.gob.ar/covid-19/data/getCasosDiariosB.php")

INFECTADOS=$(echo $JSON | jq '.[0] .values[0] .y')
ACTIVOS=$(echo $JSON | jq '.[1] .values[0] .y')
FALLECIDOS=$(echo $JSON | jq '.[3] .values[0] .y')

echo "I= $INFECTADOS | Act= $ACTIVOS | F= $FALLECIDOS"