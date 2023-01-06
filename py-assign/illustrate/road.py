import pygame

class Road:
	def __init__(self):
		self.mPoints = [(0,500), (300,200), (600,500)]

	def draw(self, surface):
		pygame.draw.polygon(surface, (10,10,10), self.mPoints, 0)
