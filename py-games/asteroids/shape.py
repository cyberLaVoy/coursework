import pygame, math
from config import *

class Shape:
	def __init__(self,x,y):
		self.mX = x
		self.mY = y
		self.mDx = 0
		self.mDy = 0
		self.mDirection = 0
		self.mRed = 255
		self.mBlue = 255
		self.mGreen = 255
		self.mColor = (self.mRed,self.mGreen,self.mBlue)
		self.mBorder = 0
		self.mIsAlive = True
		self.mRadius = 0
		
	
	def move(self):
		self.mX += self.mDx
		self.mY += self.mDy

	def rotate(self, delta_direction):
		self.mDirection = (self.mDirection + delta_direction)%(math.pi*2) 


	def hits(self,other):
		if not self.mIsAlive or not other.mIsAlive:
			return False

		distance = math.sqrt((self.mX-other.mX)**2 + (self.mY-other.mY)**2)
		if distance <= self.mRadius+other.mRadius:
			return True

	def danger(self):
		self.mRed += 1
		self.mRed %= 255
		if self.mRed == 0:
			self.mRed = 50
		self.mColor = (self.mRed,0,0)

	def wrap(self):
		if self.mY > ScrH:
			self.mY -= ScrH
		if self.mX > ScrW:
			self.mX -= ScrW
		if self.mY < 0:
			self.mY += ScrH
		if self.mX < 0:
			self.mX += ScrW
