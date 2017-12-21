import pygame,sys
from pygame.locals import *
from random import randint

pygame.init()
ventana = pygame.display.set_mode((600,300))
pygame.display.set_caption("Movimiento por teclado")

mi_imagen = pygame.image.load("/home/niko/Desktop/Ovni.png")
posX=200
posY=100

velocidad=5
blanco=(255,255,255)
derecha=True

while True:
    ventana.fill(blanco)
    ventana.blit(mi_imagen,(posX,posY))

    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == pygame.KEYDOWN:
            if event.key==K_LEFT:
                posX-=velocidad
            elif event.key==K_RIGHT:
                posX+=velocidad

    pygame.display.update()
