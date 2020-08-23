import time, datetime

Ano = time.strftime("%Y",time.localtime())
Dia = time.strftime("%d",time.localtime())
Mes = time.strftime("%m",time.localtime())

#Diccionarios
#Mes:Dia_FEriado
Feriados ={1:1, 2:[5,24,25], 3:[23,24],4:[2,9,10,24],5:[1,25],6:[15,20], 7:[9,10],8:17,10:12, 11:23,12:[7,8,24,25,31]}
MotivosFeriados = {"2020101":"Ano Nuevo", "2020205":"Feriado UTEDYC","2020224":"Carnaval","2020225":"Carnaval","2020323":"Puente Turistico","2020324":"Dia de la Memoria Verdad y Justicia","2020402":"Dia del Veterano de Malvinas","2020409":"Jueves Santo","2020410":"Viernes Santo","2020424":"Dia de Accion por la Tolerancia y el Respeto entre los Pueblos","2020501":"Dia del Trabajador","2020525":"Dia de la Revolucion de Mayo","2020615":"Martin Guemes","2020620":"Dia de la Bandera","2020709":"Dia de la Independencia","2020710":"Puente Turistico","2020817":"Conmemoracion Gral San Martin","20201012":"Dia de la Diversidad Cultural","20201123":"Dia de la Soberania Nacional","20201207":"Puente turistico Yupi :)!","20201208":"Dia de la Inmaculada","20201224":"Feriado Medife","20201225":"Navidad","20201231":"Feriado Medife"}

def EncuentroFecha (MesInicio):
   d0 = datetime.date(int(Ano), int(Mes), int(Dia)) 
   for vMes in range(MesInicio,12):
       if vMes != 9:
        if vMes == MesInicio:
            if (type(Feriados[vMes])==list):
                if int(Dia) in Feriados[vMes]:
                         DiaFeriado=str(Ano) + str(vMes) + str(Dia) 
                         print ("Hoy es el dia de",MotivosFeriados[DiaFeriado])
                         break
                else:
                    for vDia in range(0,len(Feriados[vMes])):
                        if int(Dia) < Feriados[vMes][vDia]:
                            DiaFeriado=str(Ano) + str(vMes) + str(Feriados[vMes][vDia]) 
                            d1 = datetime.date(int(Ano), vMes, Feriados[vMes][vDia])
                            delta = d1 - d0
                            print ("Faltan",delta.days,"dias para",MotivosFeriados[DiaFeriado])
                            break
            else:
                if int(Dia) == Feriados[vMes]:
                    DiaFeriado=str(Ano) + str(vMes) + str(Dia) 
                    print ("Hoy es el dia de",MotivosFeriados[DiaFeriado])
                    break
                else:
                    if int(Dia) < Feriados[vMes]:
                        DiaFeriado=str(Ano) + str(vMes) + str(Feriados[vMes]) 
                        d1 = datetime.date(int(Ano), vMes, Feriados[vMes])
                        delta = d1 - d0
                        print ("Faltan",delta.days,"dias para",MotivosFeriados[DiaFeriado])
                        break
        else:
            if (type(Feriados[vMes])==list):
                DiaFeriado=str(Ano) + str(vMes) + str(Feriados[vMes][0]) 
                d1 = datetime.date(int(Ano),vMes,Feriados[vMes][0])
                delta = d1 - d0
                print ("Faltan",delta.days,"dias para",MotivosFeriados[DiaFeriado])
                break
            else:
                DiaFeriado=str(Ano) + str(vMes) + str(Feriados[vMes]) 
                d1 = datetime.date(int(Ano),vMes,Feriados[vMes])
                delta = d1 - d0
                print ("Faltan",delta.days,"dias para",MotivosFeriados[DiaFeriado])
                break
   return

MesActual = time.strftime("%m",time.localtime())
EncuentroFecha(int(MesActual))


