import urllib.request, json 

url ="https://servicios.labrujula24.com/cotizaciones/dolar-libre-riesgo.json"
response = urllib.request.urlopen(url)
data = json.loads(response.read())

print ("BANCO NACION $",data["items"][4]["unico"], "| BLUE $",data["items"][1]["unico"], "| RIESGO PAIS",data["items"][5]["unico"])