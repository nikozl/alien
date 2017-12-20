import pygame,sys
from pygame.locals import *

pygame.init()
ventana = pygame.display.set_mode((400,300))
pygame.display.set_caption("Lineas")

color = pygame.Color(70,80,150)
pygame.draw.line(ventana,color,(60,80),(160,100),8)
# PARA VER EL COLOR QUE LE HEMOS PUESTO
print (color.r)
print (color.g)
print (color.b)

while True:
    for evento in pygame.event.get():
        if evento.type == QUIT:
            pygame.quit()
            sys.exit()
    pygame.display.update()
