import pygame,sys
from pygame.locals import *
from random import randint

pygame.init()
ventana = pygame.display.set_mode((400,300))
pygame.display.set_caption("Random")

mi_imagen = pygame.image.load("/home/niko/Desktop/Ovni.png")
posX= randint(10,300)
posY= randint(10,200)

print (posX,posY)
ventana.blit(mi_imagen,(posX,posY))

while True:
    for evento in pygame.event.get():
        if evento.type == QUIT:
            pygame.quit()
            sys.exit()
    pygame.display.update()
