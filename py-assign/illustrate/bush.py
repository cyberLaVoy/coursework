import pygame
from math import *

class Bush:
	def __init__(self, x, y, radius):
		self.mColor = (24,43,20)
		self.mX = x
		self.mY = y
		self.mCenter = (x, y)
		self.mRadius = radius

	def draw(self, surface):
		pygame.draw.circle(surface, self.mColor, self.mCenter,
					self.mRadius, 0)
		c1 = (self.mX + self.mRadius, self.mY)
		pygame.draw.circle(surface, self.mColor, c1,
					int(self.mRadius/2), 0)
		c2 = (self.mX-self.mRadius, self.mY)
		pygame.draw.circle(surface, self.mColor, c2,
					int(self.mRadius/2), 0)
		rect = pygame.Rect(self.mX, self.mY, 
					self.mRadius*2, self.mRadius*2) 
		pygame.draw.arc(surface, self.mColor, rect, 0, pi, 3) 


