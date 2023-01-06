import pygame

class Moon:
	def __init__(self, color, x, y, r):
		self.mX = x
		self.mY = y
		self.mRadius = r
		self.mColor = color
	
	def draw(self, surface):
		pygame.draw.circle(surface, self.mColor, 
				  (self.mX, self.mY), 
				   self.mRadius, 0)
