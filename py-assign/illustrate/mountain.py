import pygame

class Mountain:
	def __init__(self, mountainP, snowP):
		self.mMountainP = mountainP[:]
		self.mSnowP = snowP[:]

	def draw(self, surface):
		pygame.draw.polygon(surface, (40, 38, 25), self.mMountainP, 0) 
		pygame.draw.polygon(surface, (255, 250, 226), self.mSnowP, 0)
