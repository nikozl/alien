import pygame,sys
from pygame.locals import *
from random import randint

pygame.init()
ventana = pygame.display.set_mode((600,300))
pygame.display.set_caption("Animaciones")

mi_imagen = pygame.image.load("/home/niko/Desktop/Ovni.png")
posX=200
posY=100

velocidad=1
blanco=(255,255,255)
derecha=True

while True:
    ventana.fill(blanco)
    ventana.blit(mi_imagen,(posX,posY))
    for evento in pygame.event.get():
        if evento.type == QUIT:
            pygame.quit()
            sys.exit()
    
    if derecha==True:
        if posX<400:
            posX+=velocidad
        else:
            derecha=False
    else:
        if posX>1:
            posX-=velocidad
        else:
            derecha=True

    pygame.display.update()
