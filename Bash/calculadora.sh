#!/bin/bash
xsel -o | dmenu -fn 'Ubuntu-18' -p Calcular: | xargs echo | bc 2>&1 | dmenu -fn 'Ubuntu-18' -p Resultado: | xsel -i
