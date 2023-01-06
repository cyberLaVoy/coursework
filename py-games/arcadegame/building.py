import pygame

class Building:
	def __init__(self, color, x, y, w, h):
		self.mColor = color
		self.mX = x
		self.mY = y
		self.mWidth = w
		self.mHeight = h

	def getX(self):
		return self.mX
	def getY(self):
		return self.mY
	def getWidth(self):
		return self.mWidth
	def getHeight(self):
		return self.mHeight

	def move(self):
		self.mX -= 1
	
	def draw(self, surface):
		rect = pygame.Rect(self.mX, self.mY, self.mWidth, self.mHeight)
		pygame.draw.rect(surface, self.mColor, rect, 0)

