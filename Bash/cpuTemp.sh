#!/bin/bash

temp=$(sensors -j | jq '."k10temp-pci-00c3" ."Tdie" ."temp1_input"')

echo "$temp ºC"

