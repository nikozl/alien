import random
import os

os.system('clear')

saldo = int(input("Introduzca su saldo: "))
apuesta = int(input("Haga su apuesta: "))
while apuesta > saldo:
	print("Error, no puedes apostar mas de lo que tienes, tu saldo es:",saldo)
	apuesta = int(input("Haga su apuesta: "))
	
saldo = saldo-apuesta

numero = int(input("ELija un numero del 1 al 6 \n"))

aleatorio = random.randint(1, 6)

print("Tiramos el dado y sale el -------->" , aleatorio) 

if numero==aleatorio:
	print("¡¡¡Has ganado!!!")
	saldo = saldo+apuesta+apuesta
	print("Tu saldo actual es ",saldo)
else:
	print("Mala suerte")
	print("Te quedan: ",saldo)


while saldo > 0:
	opcion = input("Quiere seguir jugando? Responda si o no \n")

	if opcion.lower() == 'SI' or opcion.lower() == 'si':
		print("Recuerda que tu saldo es",saldo)
		apuesta = int(input("Haga su apuesta: "))
		while apuesta > saldo:
			print("Error, no puedes apostar mas de lo que tienes, tu saldo es:",saldo)
			apuesta = int(input("Haga su apuesta: "))
		saldo = saldo-apuesta
		numero = int(input("ELija un numero del 1 al 6 \n"))

		aleatorio = random.randint(1, 6)

		print("Tiramos el dado y sale el -------->" , aleatorio)

		if numero==aleatorio:
        		print("¡¡¡Has ganado!!!")
        		saldo = saldo+apuesta+apuesta
        		print("Tu saldo actual es ",saldo)
		else:
        		print("Mala suerte")
        		print("Te quedan: ",saldo)


	else:
		print("Enhorabuena, te vas con",saldo)
		print("Cerrando el juego...")
		exit()

else:
	print("Se acabo")
