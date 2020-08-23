import os,json

stream = os.popen("sensors -j").read()
Temperatura = json.loads(stream)
print (Temperatura["k10temp-pci-00c3"]["Tdie"]['temp1_input'])