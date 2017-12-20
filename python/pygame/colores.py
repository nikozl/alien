import pygame,sys
from pygame.locals import *
# COLORES SON COMBINACION DE RED, GREEN, BLUE
color= (0,140,60)
color2 = pygame.Color(255,120,9)

pygame.init()
ventana = pygame.display.set_mode((400,300))
pygame.display.set_caption("Colores")

while True:
    ventana.fill(color2)
    for evento in pygame.event.get():
        if evento.type == QUIT:
            pygame.quit()
            sys.exit()
    pygame.display.update()
