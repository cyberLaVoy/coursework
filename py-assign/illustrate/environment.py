import pygame

class Sky:
	def __init__(self, color, width, height):
		self.mColor = color
		self.mWidth = width
		self.mHeight = height

	def draw(self, surface):
		rect = pygame.Rect(0, 0, self.mWidth, self.mHeight)
		pygame.draw.rect(surface, self.mColor, rect, 0)

class Ground:
	def __init__(self, color, width, height):
		self.mColor = color
		self.mWidth = width
		self.mHeight = height

	def draw(self, surface):
		rect = pygame.Rect(0, 200, self.mWidth, self.mHeight)
		pygame.draw.rect(surface, self.mColor, rect, 0)


