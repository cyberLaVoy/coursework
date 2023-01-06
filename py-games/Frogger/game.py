import froggerlib
import pygame, random

class Game:
	def __init__(self, w, h):
		self.mScreenW = w
		self.mScreenH = h

		self.mStage1 = froggerlib.Stage(0, h-50, w, 50)
		self.mRoad1 = froggerlib.Road(0, h-100, w, 50)
		self.mRoad2 = froggerlib.Road(0, h-150, w, 50)
		self.mRoad3 = froggerlib.Road(0, h-200, w, 50)
		self.mRoad4 = froggerlib.Road(0, h-250, w, 50)
		self.mStage2 = froggerlib.Stage(0, h-300, w, 50)
		self.mWater1 = froggerlib.Water(0, h-350, w, 50)
		self.mWater2 = froggerlib.Water(0, h-400, w, 50)
		self.mWater3 = froggerlib.Water(0, h-450, w, 50)
		self.mWater4 = froggerlib.Water(0, h-500, w, 50)
		self.mHome = froggerlib.Home(0, h-550, w, 50)
		self.mDeath = [froggerlib.Grass(0, h-550, 50, 50),froggerlib.Grass(150, h-550, 50, 50),
				froggerlib.Grass(300, h-550, 50, 50),froggerlib.Grass(450, h-550, 50, 50)]

		#left moving
		self.mVehicles1 = [froggerlib.Car(w, self.mRoad1.getY()+5, 40, 40, 0-40, self.mRoad1.getY()+5, 2)]
		self.mVehicles3 = [froggerlib.Car(w, self.mRoad3.getY()+5, 40, 40, 0-40, self.mRoad3.getY()+5, 5)]
		#right moving
		self.mVehicles2 = [froggerlib.Car(-100, self.mRoad2.getY()+5, 40, 40, w, self.mRoad2.getY()+5, 2)]
		self.mVehicles4 = [froggerlib.Car(-100, self.mRoad4.getY()+5, 90, 40, w, self.mRoad4.getY()+5, 5)]

		#left moving
		self.mTurtles1 = [[froggerlib.Turtle(w, self.mWater1.getY()+5, 40, 40, -40, self.mWater1.getY()+5, 2)
				,froggerlib.Turtle(w+50, self.mWater1.getY()+5, 40, 40, -40, self.mWater1.getY()+5, 2)
				,froggerlib.Turtle(w+100, self.mWater1.getY()+5, 40, 40, -40, self.mWater1.getY()+5, 2)]]

		self.mTurtles2 = [[froggerlib.Turtle(w, self.mWater3.getY()+5, 40, 40, -40, self.mWater3.getY()+5, 5)
				,froggerlib.Turtle(w+50, self.mWater3.getY()+5, 40, 40, -40, self.mWater3.getY()+5, 5)
				,froggerlib.Turtle(w+100, self.mWater3.getY()+5, 40, 40, -40, self.mWater3.getY()+5, 5)]]
		#right moving
		self.mLogs1 = [froggerlib.Log(-100, self.mWater2.getY()+5, 100, 40, w, self.mWater2.getY()+5, 2)]
		self.mLogs2 = [froggerlib.Log(-150, self.mWater4.getY()+5, 150, 40, w, self.mWater4.getY()+5, 5)]

		self.mFrog = froggerlib.Frog(w-4*45, h-45, 40, 40, w-4*45, h-45, 10, 50, 50)	

	def up(self):
		self.mFrog.up()
	def down(self):
		self.mFrog.down()
	def left(self):
		self.mFrog.left()
	def right(self):
		self.mFrog.right()
	
	def turtleLists(self):
		for i in range(len(self.mTurtles1)):
			if self.mTurtles1[i][0].getX() == 250:
				w = self.mScreenW
				turtles = [froggerlib.Turtle(w, self.mWater1.getY()+5, 40, 40, -40, self.mWater1.getY()+5, 2)
				,froggerlib.Turtle(w+50, self.mWater1.getY()+5, 40, 40, -40, self.mWater1.getY()+5, 2)
				,froggerlib.Turtle(w+100, self.mWater1.getY()+5, 40, 40, -40, self.mWater1.getY()+5, 2)]	
				self.mTurtles1.append(turtles)
		for i in range(len(self.mTurtles2)):
			if self.mTurtles2[i][0].getX() == 150:
				w = self.mScreenW
				turtles = [froggerlib.Turtle(w, self.mWater3.getY()+5, 40, 40, -40, self.mWater3.getY()+5, 5)
				,froggerlib.Turtle(w+50, self.mWater3.getY()+5, 40, 40, -40, self.mWater3.getY()+5, 5)
				,froggerlib.Turtle(w+100, self.mWater3.getY()+5, 40, 40, -40, self.mWater3.getY()+5, 5)]
				self.mTurtles2.append(turtles)
	def logLists(self):
		w = self.mScreenW
		for i in range(len(self.mLogs1)):
			if self.mLogs1[i].getX() == 150:
				log = froggerlib.Log(-100, self.mWater2.getY()+5, 100, 40, w, self.mWater2.getY()+5, 2)	
				self.mLogs1.append(log)
		for i in range(len(self.mLogs2)):
			if self.mLogs2[i].getX() == 250:
				log = froggerlib.Log(-150, self.mWater4.getY()+5, 150, 40, w, self.mWater4.getY()+5, 5)	
				self.mLogs2.append(log)

	def vehicleLists(self):
		#left moving
		for i in range(len(self.mVehicles1)):
			if self.mVehicles1[i].getX() == 300:
				c = froggerlib.Car(self.mScreenW, self.mRoad1.getY()+5, 40, 40, 0-40, self.mRoad1.getY()+5, 2)
				self.mVehicles1.append(c)
			if self.mVehicles1[i].getX() < -50:
				del self.mVehicles1[i]
		for i in range(len(self.mVehicles3)):
			if self.mVehicles3[i].getX() == 300:
				c = froggerlib.Car(self.mScreenW, self.mRoad3.getY()+5, 40, 40, 0-40, self.mRoad3.getY()+5, 5)
				self.mVehicles3.append(c)
			if self.mVehicles3[i].getX() < -50:
				del self.mVehicles3[i]
		#right moving
		for i in range(len(self.mVehicles2)):
			if self.mVehicles2[i].getX() == 100:
				c = froggerlib.Car(-100, self.mRoad2.getY()+5, 40, 40, self.mScreenW, self.mRoad2.getY()+5, 2)
				self.mVehicles2.append(c)
			if self.mVehicles2[i].getX() > self.mScreenW:
				del self.mVehicles2[i]
		for i in range(len(self.mVehicles4)):
			if self.mVehicles4[i].getX() == 200:
				c = froggerlib.Car(-100, self.mRoad4.getY()+5, 90, 40, self.mScreenW, self.mRoad4.getY()+5, 5)
				self.mVehicles4.append(c)
			if self.mVehicles4[i].getX() > self.mScreenW:
				del self.mVehicles4[i]

	def reset(self):
		self.mFrog.setX(self.mScreenW-4*45)
		self.mFrog.setY(self.mScreenH-45)
		self.mFrog.setDesiredX(self.mScreenW-4*45)
		self.mFrog.setDesiredY(self.mScreenH-45)


	def collisions(self):
		if self.mFrog.outOfBounds(self.mScreenW, self.mScreenH):
			self.reset()

		water = [self.mWater1, self.mWater2, self.mWater3, self.mWater4]
		for i in range(len(water)):
			if water[i].hits(self.mFrog):
				self.reset()

		for i in range(len(self.mVehicles1)):
			if self.mVehicles1[i].hits(self.mFrog):
				self.reset()
		for i in range(len(self.mVehicles2)):
			if self.mVehicles2[i].hits(self.mFrog):
				self.reset()
		for i in range(len(self.mVehicles3)):
			if self.mVehicles3[i].hits(self.mFrog):
				self.reset()
		for i in range(len(self.mVehicles4)):
			if self.mVehicles4[i].hits(self.mFrog):
				self.reset()

		for i in range(len(self.mDeath)):
			if self.mDeath[i].hits(self.mFrog):
				self.reset()

	def draw(self, surface):
		stage1 = pygame.Rect(self.mStage1.getX(), self.mStage1.getY(), self.mStage1.getWidth(), self.mStage1.getHeight())
		pygame.draw.rect(surface, (200,0,200), stage1, 0)

		road1 = pygame.Rect(self.mRoad1.getX(), self.mRoad1.getY(), self.mRoad1.getWidth(), self.mRoad1.getHeight())
		pygame.draw.rect(surface, (0,0,0), road1, 0)
		road2 = pygame.Rect(self.mRoad2.getX(), self.mRoad2.getY(), self.mRoad2.getWidth(), self.mRoad2.getHeight())
		pygame.draw.rect(surface, (0,0,0), road2, 0)
		road3 = pygame.Rect(self.mRoad3.getX(), self.mRoad3.getY(), self.mRoad3.getWidth(), self.mRoad3.getHeight())
		pygame.draw.rect(surface, (0,0,0), road3, 0)
		road4 = pygame.Rect(self.mRoad4.getX(), self.mRoad4.getY(), self.mRoad4.getWidth(), self.mRoad4.getHeight())
		pygame.draw.rect(surface, (0,0,0), road4, 0)

		stage2 = pygame.Rect(self.mStage2.getX(), self.mStage2.getY(), self.mStage2.getWidth(), self.mStage2.getHeight())
		pygame.draw.rect(surface, (200,0,200), stage2, 0)

		water1 = pygame.Rect(self.mWater1.getX(), self.mWater1.getY(), self.mWater1.getWidth(), self.mWater1.getHeight())
		pygame.draw.rect(surface, (0,0,200), water1, 0)
		water2 = pygame.Rect(self.mWater2.getX(), self.mWater2.getY(), self.mWater2.getWidth(), self.mWater2.getHeight())
		pygame.draw.rect(surface, (0,0,200), water2, 0)
		water3 = pygame.Rect(self.mWater3.getX(), self.mWater3.getY(), self.mWater3.getWidth(), self.mWater3.getHeight())
		pygame.draw.rect(surface, (0,0,200), water3, 0)
		water4 = pygame.Rect(self.mWater4.getX(), self.mWater4.getY(), self.mWater4.getWidth(), self.mWater4.getHeight())
		pygame.draw.rect(surface, (0,0,200), water4, 0)
		
		home = pygame.Rect(self.mHome.getX(), self.mHome.getY(), self.mHome.getWidth(), self.mHome.getHeight())
		pygame.draw.rect(surface, (255,255,255), home, 0)
		
		for i in range(len(self.mDeath)):
			d = self.mDeath[i]
			death = pygame.Rect(d.getX(), d.getY(), d.getWidth(), d.getHeight())
			pygame.draw.rect(surface, (150,0,0), death, 0)

		for i in range(len(self.mVehicles1)):
			v = self.mVehicles1[i]
			rect = pygame.Rect(v.getX(), v.getY(), v.getWidth(), v.getHeight())
			pygame.draw.rect(surface, (200, 200, 200), rect, 0)
		for i in range(len(self.mVehicles3)):
			v = self.mVehicles3[i]
			rect = pygame.Rect(v.getX(), v.getY(), v.getWidth(), v.getHeight())
			pygame.draw.rect(surface, (200, 200, 200), rect, 0)
		for i in range(len(self.mVehicles2)):
			v = self.mVehicles2[i]
			rect = pygame.Rect(v.getX(), v.getY(), v.getWidth(), v.getHeight())
			pygame.draw.rect(surface, (200, 200, 200), rect, 0)
		for i in range(len(self.mVehicles4)):
			v = self.mVehicles4[i]
			rect = pygame.Rect(v.getX(), v.getY(), v.getWidth(), v.getHeight())
			pygame.draw.rect(surface, (200, 200, 200), rect, 0)

		for i in range(len(self.mTurtles1)):
			for j in range(len(self.mTurtles1[i])):
				v = self.mTurtles1[i][j]
				rect = pygame.Rect(v.getX(), v.getY(), v.getWidth(), v.getHeight())
				pygame.draw.rect(surface, (0, 0, 0), rect, 0)
		for i in range(len(self.mTurtles2)):
			for j in range(len(self.mTurtles2[i])):
				v = self.mTurtles2[i][j]
				rect = pygame.Rect(v.getX(), v.getY(), v.getWidth(), v.getHeight())
				pygame.draw.rect(surface, (0, 0, 0), rect, 0)

		for i in range(len(self.mLogs1)):
			v = self.mLogs1[i]
			rect = pygame.Rect(v.getX(), v.getY(), v.getWidth(), v.getHeight())
			pygame.draw.rect(surface, (0, 0, 0), rect, 0)
		for i in range(len(self.mLogs2)):
			v = self.mLogs2[i]
			rect = pygame.Rect(v.getX(), v.getY(), v.getWidth(), v.getHeight())
			pygame.draw.rect(surface, (0, 0, 0), rect, 0)

		frog = pygame.Rect(self.mFrog.getX(), self.mFrog.getY(), self.mFrog.getWidth(), self.mFrog.getHeight())
		pygame.draw.rect(surface, (0,200,50), frog, 0)


	def animate(self):
		for i in range(len(self.mVehicles1)):
			self.mVehicles1[i].move()
		for i in range(len(self.mVehicles3)):
			self.mVehicles3[i].move()
		for i in range(len(self.mVehicles2)):
			self.mVehicles2[i].move()
		for i in range(len(self.mVehicles4)):
			self.mVehicles4[i].move()
		for i in range(len(self.mTurtles1)):
			for j in range(len(self.mTurtles1[i])):
				self.mTurtles1[i][j].move()
				self.mTurtles1[i][j].supports(self.mFrog)
		for i in range(len(self.mTurtles2)):
			for j in range(len(self.mTurtles2[i])):
				self.mTurtles2[i][j].move()
				self.mTurtles2[i][j].supports(self.mFrog)
		for i in range(len(self.mLogs1)):
			self.mLogs1[i].supports(self.mFrog)
			self.mLogs1[i].move()
		for i in range(len(self.mLogs2)):
			self.mLogs2[i].supports(self.mFrog)
			self.mLogs2[i].move()
		self.mFrog.move()



