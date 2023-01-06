import pygame

class Line:
	def __init__(self, points, thickness):
		self.mPoints = points[:]
		self.mThick = thickness
	
	def draw(self, surface):
		pygame.draw.lines(surface, (240,230,19), True,
				  self.mPoints, self.mThick)
