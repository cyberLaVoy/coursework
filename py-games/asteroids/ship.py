import polygon, math, bullet
from config import *

class Ship(polygon.Polygon):
	def __init__(self,x, y, points):
		polygon.Polygon.__init__(self,x,y, points)
		self.mAcceleration = .54
		self.mDecceleration = .89
		self.mColor = (0,200,200)
	
	def accelerate(self):
		self.mDx += self.mAcceleration*math.cos(self.mDirection)
		self.mDy += self.mAcceleration*math.sin(self.mDirection)

		self.mX += self.mDx
		self.mY += self.mDy

	def deccelerate(self):
		self.mDx *= self.mDecceleration
		self.mDy *= self.mDecceleration

		self.mX += self.mDx
		self.mY += self.mDy
	
	def fire(self):
		x = self.mDeltaPoints[0][0]
		y = self.mDeltaPoints[0][1]
		dx = math.cos(self.mDirection)
		dy = math.sin(self.mDirection)
		b = bullet.Bullet(x,y,dx,dy)
		return b
