import pygame
import random

class Coin:
	def __init__(self, color, w, h):
		self.mX = w
		self.mY = random.randrange(h-50, h)
		self.mDx = -1
		self.mDy = 1
		self.mRadius = 20
		self.mColor = color
		self.mScreenW = w
		self.mScreenH = h


	def getX(self):
		return self.mX
	def getY(self):
		return self.mY

	def getR(self):
		return self.mRadius
	def getColor(self):
		return self.mColor[0]

	def move(self):
		self.mX += self.mDx
		self.mY += self.mDy
		if self.mY >= self.mScreenH:
			self.mDy = -self.mDy
		if self.mY <= self.mScreenH-300:
			self.mDy = -self.mDy

	def draw(self, surface):
		pygame.draw.circle(surface, self.mColor, 
				  (self.mX, self.mY), 
				   self.mRadius, 0)
