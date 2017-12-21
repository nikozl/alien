import pygame,sys
from pygame.locals import *

pygame.init()
ventana = pygame.display.set_mode((400,300))
pygame.display.set_caption("Load and blit")

mi_imagen = pygame.image.load("/home/niko/Desktop/Ovni.png")
posX,posY= 130,70

ventana.blit(mi_imagen,(posX,posY))

while True:
    for evento in pygame.event.get():
        if evento.type == QUIT:
            pygame.quit()
            sys.exit()
    pygame.display.update()
