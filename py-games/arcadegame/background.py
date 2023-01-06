import pygame

class Background:
	def __init__(self, color, x, y, w, h):
		self.mColor = color
		self.mX = x
		self.mY = y
		self.mWidth = w
		self.mHeight = h
	
	def draw(self, surface):
		rect = pygame.Rect(self.mX, self.mY, self.mWidth, self.mHeight)
		pygame.draw.rect(surface, self.mColor, rect, 0)

