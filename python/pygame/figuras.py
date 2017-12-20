import pygame,sys
from pygame.locals import *

pygame.init()
ventana = pygame.display.set_mode((400,300))
pygame.display.set_caption("Figuras")

pygame.draw.circle(ventana,(80,70,120),(80,90),20)
pygame.draw.rect(ventana,(10,80,60),(240,240,100,50))
pygame.draw.polygon(ventana,(100,40,70),((140,0),(291,106),(237,277),(56,277),(0,106)))

while True:
    for evento in pygame.event.get():
        if evento.type == QUIT:
            pygame.quit()
            sys.exit()
    pygame.display.update()
