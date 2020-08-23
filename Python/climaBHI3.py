# -*- coding: utf-8 -*-
import urllib.request, json, smtplib, ssl
from pathlib import Path

#Obtencion de datos de clima
urlClima = "http://api.weatherapi.com/v1/forecast.json?key=534ca06763a94119868155611200108&lang=es&q=Bahia\%20Blanca&days=2"
respuesta = urllib.request.urlopen(urlClima)
jsonClima = json.loads(respuesta.read())

vTempC = jsonClima["current"]["temp_c"]
vCondicion = jsonClima["current"]["condition"]["text"]
vViento = jsonClima["current"]["wind_kph"]    
vDirViento = jsonClima["current"]["wind_dir"]
vHumedad = jsonClima["current"]["humidity"]
vPresion = jsonClima["current"]["pressure_mb"]
vPrecipitaciones = jsonClima["current"]["pressure_in"]
vSensacionTermica = jsonClima["current"]["feelslike_c"]
vNubosidad = jsonClima["current"]["cloud"]
vIndiceUV = jsonClima["current"]["uv"]
vVisibilidad = jsonClima["current"]["vis_km"]

#Para Manana
vTempMin = jsonClima["forecast"]["forecastday"][1]["day"]["mintemp_c"]
vTempMax = jsonClima["forecast"]["forecastday"][1]["day"]["maxtemp_c"]
vLluvias = jsonClima["forecast"]["forecastday"][1]["day"]["daily_chance_of_rain"]
vClima = vTempC,"ºC ST:",vSensacionTermica,"| Nubosidad:",vNubosidad,"% Viento",vDirViento,"a",vViento,"km/h >",vCondicion,"| Hum.",vHumedad,"% - Pres:",vPresion,"mb | Visibilidad:",vVisibilidad,"UV:",vIndiceUV,"Mañana:",vTempMin,"/",vTempMax
print (vTempC,"ºC ST:",vSensacionTermica,"| Nubosidad:",vNubosidad,"% Viento",vDirViento,"a",vViento,"km/h >",vCondicion,"| Hum.",vHumedad,"% - Pres:",vPresion,"mb | Visibilidad:",vVisibilidad,"UV:",vIndiceUV,"Mañana:",vTempMin,"/",vTempMax,"Luvias:",vLluvias,"%")

if Path('/tmp/avisados.mail').is_file():
    exit
else:
    #Envio Mail
    gmail_user = 'sistemaautorizador@gmail.com'
    gmail_password = 'golpea123'
    sent_from = gmail_user
    to = ['alejandro.baldres@gmail.com', 'rakelgaitan@gmail.com']
    subject = 'Situacion Climatica'
    body = "Buen dia Alejandro/Raquel, hoy va a estar: \n",vTempC,"*C ST:",vSensacionTermica,"| Nubosidad:",vNubosidad,"% Viento",vDirViento,"a",vViento,"km/h >",vCondicion,"| Hum.",vHumedad,"% - Pres:",vPresion,"mb | Visibilidad:",vVisibilidad,"UV:",vIndiceUV,"Manana:",vTempMin,"/",vTempMax

    email_text = """\
    From: %s
    To: %s
    Subject: %s

    %s
    """ % (sent_from, ", ".join(to), subject, body)

    try:    
        server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
        server.ehlo()
        server.login(gmail_user, gmail_password)
        server.sendmail(sent_from, to, email_text)
        server.close()
        with open('/tmp/avisados.mail','w') as f:
            f.write("a")
    except:
        print ('Something went wrong...')
