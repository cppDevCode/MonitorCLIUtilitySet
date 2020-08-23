import urllib.request, json 

url ="https://gobiernoabierto.bahia.gob.ar/covid-19/data/getCasosDiariosB.php"
response = urllib.request.urlopen(url)
data = json.loads(response.read())

print ("I=",data[0]["values"][0]["y"],"| Act=",data[1]["values"][0]["y"],"| F=",data[3]["values"][0]["y"])