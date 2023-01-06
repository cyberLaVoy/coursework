import random
import pygame
import paddle
import score

class Ball(paddle.Paddle):
	def __init__(self, color, x, y, w, h, screenW, screenH, paddle, score1, score2):
		self.mColor = color
		self.mX = x
		self.mXset = x
		self.mY = y
		self.mYset = y
		self.mWidth = w
		self.mHeight = h
		self.mDx = 10
		self.mDy = 10
		self.mScreenW = screenW
		self.mScreenH = screenH
		self.mPaddle = paddle
		self.mScore1 = score1
		self.mScore2 = score2
	
	def move(self):
		pX = self.mPaddle.getX()
		pY = self.mPaddle.getY()
		pW = self.mPaddle.getWidth()
		pH = self.mPaddle.getHeight()

		if self.mX+self.mWidth >= self.mScreenW:
			self.mDx = -self.mDx
		if self.mY <= 0 or self.mY+self.mHeight >= self.mScreenH:
			self.mDy = -self.mDy
		if self.mX <= pX+pW:
			if self.mY >= pY-self.mHeight and self.mY <= pY+pH:
				if self.mX < pX-self.mWidth:
					pass
				elif self.mX >= pX-self.mWidth and self.mX < pX+pW:
					pass
				else:
					self.mDx = -self.mDx
					self.mScore1.plus()
		if self.mX < 0-self.mWidth:
			values1 = [10, 20]
			values2 = [1, -1]
			value1 = random.randrange(0,2)
			value2= random.randrange(0,2)
			self.mX = self.mXset
			self.mY = self.mYset
			self.mDx = values1[value1]
			self.mDy = values1[value1]*values2[value2]
			self.mScore2.plus()

		self.mX += self.mDx
		self.mY += self.mDy

	def draw(self, surface):
		rect = pygame.Rect(self.mX, self.mY, self.mWidth, self.mHeight)
		pygame.draw.rect(surface, self.mColor, rect, 0)
		self.mScore1.draw(surface)
		self.mScore2.draw(surface)


