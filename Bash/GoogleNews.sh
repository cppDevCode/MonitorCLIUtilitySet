#!bin/bash
#Version 202001250900h
APIKEY="XXXXX"
JSON="https://newsapi.org/v2/top-headlines?sources=google-news-ar&apiKey=$APIKEY"

#Obtengo JSON
EJECUTA="curl  -s -X \"GET\" \"$JSON\" -H \"Accept: application/json\" -H \"Content-Type: application/json\""
BD=$(eval $EJECUTA)

EJECUTA="echo "'$BD'" | jq '.\"totalResults\"'"
TOPE=$(eval $EJECUTA)

for ((i=1; i <= $TOPE; i++))
do
    EJECUTA="echo "'$BD'" | jq '.\"articles\"[$i].\"description\"'"
    NOTICIA=$(eval $EJECUTA)
    if [ "$NOTICIA" != "null" ]; then
        EJECUTA="echo "'$BD'" | jq '.\"articles\"[$i].\"author\"'"
        AUTOR=$(eval $EJECUTA)
        AUTOR=${AUTOR//"\""}
        if [ $AUTOR == "null" ]; then
            AUTOR="N/A"
        fi
        case $AUTOR in
            "Clarín.com")
                        AUTOR="Clarin"
                        ;;
            "Lisandro Guzmán")
                        AUTOR="La Voz"
                        ;;
            "Ismael Bermúdez")
                        AUTOR="Clarin"
                        ;;
            "Ramiro León")
                        AUTOR="Perfil"
                        ;;
            "MinutoUno")
                        AUTOR="M1"
                        ;;   
            "Redacción LA NACION")
                        AUTOR="LNA"
                        ;;
            "Analia Argento")
                        AUTOR="InfoBae"
                        ;;
            "Mariano Casal")
                        AUTOR="Ambito"
                        ;;
            "Ricardo Carpena")
                        AUTOR="Infobae"
                        ;;
            "Fabiola Czubaj")
                        AUTOR="LNA"
                        ;;
            "Jose Edgar Reyna")
                        AUTOR="La Voz"
                        ;;
            "Annabella Quiroga")
                        AUTOR="Clarin"
                        ;;
            "MDZ Dinero")
                        AUTOR="MDZ"
                        ;;
            "Federico Giammaría")
                        AUTOR="La Voz"
                        ;;
            "Santiago Dapelo")
                        AUTOR="LNA"
                        ;;
            "Carlos Pagni")
                        AUTOR="LNA"
                        ;;
            "Anabella Gonzalez")
                        AUTOR="Perfil"
                        ;;
            "María Clara Ferrer")
                        AUTOR="La Voz"
                        ;;
            "Ayelén Bonino")
                        AUTOR="Perfil"
                        ;;
            "Joaquín Morales Solá")
                        AUTOR="LNA"
                        ;;
            "Miguel Jorquera")
                        AUTOR="P12"
                        ;;
            "Adriana Santagati")
                        AUTOR="Clarin"
                        ;;
            "Hernán Cappiello")
                        AUTOR="LNA"
                        ;;
            "Ricardo Braginski")
                        AUTOR="Clarin"
                        ;;
            "Diario El Dia de La Plata www.eldia.com")
                        AUTOR="El Dia"
                        ;;
            "Eduardo Aulicino")
                        AUTOR="Infobae"
                        ;;
            "José María Costa")
                        AUTOR="LNA"
                        ;;
            "Patricia Valli")
                        AUTOR="Perfil"
                        ;;
            "Mariano Beldyk")
                        AUTOR="Perfil"
                        ;;
            "Cadena 3 Argentina")
                        AUTOR="Cadena3"
                        ;;
            "ámbito.com")
                        AUTOR="Ambito"
                        ;;
        esac
        ITOPE=1
        TTOPE=1
        MAXTOPE=33
        SCROLL=0
        NOTICIA=${NOTICIA//"<ol>"/}
        NOTICIA=${NOTICIA//"<li>"/}
        NOTICIA=${NOTICIA//"\\r"/}
        NOTICIA=${NOTICIA//"\\n"/" - "}
        NOTICIA=${NOTICIA//"</li>"/}
        NOTICIA=${NOTICIA^^}
        echo "largo ES: ${#NOTICIA}"
        for ((a=0;a<=${#NOTICIA};a++))
        do 
            clear
            echo "${NOTICIA:$TTOPE:$ITOPE}"
            sleep 0.2
            if [ $ITOPE == $MAXTOPE ] && [ $SCROLL -eq 0 ]; then
                TTOPE=2
                ITOPE=35
                SCROLL=1
            fi
            if [ $SCROLL -eq 1 ]; then
                TTOPE=$((TTOPE + 1))
            else
                ITOPE=$((ITOPE + 1))
            fi
        done
        sleep 1
    fi
done

 