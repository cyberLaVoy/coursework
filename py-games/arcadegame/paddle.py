import pygame

class Paddle:
	def __init__(self, color, x, y, w, h, screenW, screenH):
		self.mColor = color
		self.mX = x
		self.mY = y
		self.mWidth = w
		self.mHeight = h
		self.mScreenW = screenW
		self.mScreenH = screenH
	
	def up(self):
		for i in range(10):
			if self.mY != 0:
				self.mY -= 1
	def down(self):
		for i in range(10):
			if self.mY != self.mScreenH - self.mHeight:
				self.mY += 1
	def left(self):
		for i in range(10):
			if self.mX != 0:
				self.mX -= 1
	def right(self):
		for i in range(10):
			if self.mX != self.mScreenW - 200:
				self.mX += 1

	def getX(self):
		return self.mX
	def getY(self):
		return self.mY
	def getWidth(self):
		return self.mWidth
	def getHeight(self):
		return self.mHeight

	def draw(self, surface):
		rect = pygame.Rect(self.mX, self.mY, self.mWidth, self.mHeight)
		pygame.draw.rect(surface, self.mColor, rect, 0)

