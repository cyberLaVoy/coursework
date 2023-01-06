import background, building, paddle, score, coin
import pygame, random

class Pong:
	def __init__(self, w, h):
		self.mScreenW = w
		self.mScreenH = h
		#self.mBackground = background.Background(color, x, y, w, h)
		self.mBackground = background.Background((255,255,255), 0, 0, 900, 700)
		#self.mPaddle = Paddle(color, x, y, w, h, screenW, screenH))
		self.mPaddle = paddle.Paddle((0,0,0), 150, 100, 40, 40, w, h)	
		#self.mScore = score.Score(color, string, x, y)
		self.mScore1 = score.Score((0, 200, 200), '0', 100, 50)
		self.mScore2 = score.Score((200, 0, 200), '0', 200, 50)

		#self.mBuilding = building.Building(color, x, y, w, h)
		self.mBuildings = [building.Building((0,0,0), w, h/2, 100, h/2)]

		self.mCoins = [coin.Coin((0, 200, 200), w, h)]
		

	def up(self):
		self.mPaddle.up()
	def down(self):
		self.mPaddle.down()
	def left(self):
		self.mPaddle.left()
	def right(self):
		self.mPaddle.right()


	def coinCollision(self):
		for i in range(len(self.mCoins)):
			coinX = self.mCoins[i].getX()
			coinY = self.mCoins[i].getY()
			coinR = self.mCoins[i].getR()
			coinColor = self.mCoins[i].getColor()
			paddleX = self.mPaddle.getX() + self.mPaddle.getWidth()/2
			paddleY = self.mPaddle.getY() + self.mPaddle.getHeight()/2


			if paddleX <= coinX+coinR and paddleX >= coinX-coinR:
				if paddleY <= coinY+coinR and paddleY >= coinY-coinR:
					if coinColor == 0:
						self.mScore1.plus()
						self.mScore1.plus()
					else:
						self.mScore2.plus()
						self.mScore2.plus()
					del self.mCoins[i]
					return True
		return False

	def coinCheck(self):
		coin_start = self.mScreenW - (2*self.mCoins[-1].getR()+10)
		if self.mCoins[-1].getX() == coin_start:
			r_num = random.randrange(0,3)
			if r_num == 0 or r_num == 1:
				color = (0, 200, 200)
			else:
				color = (200, 0, 200)
			c = coin.Coin(color, self.mScreenW, self.mScreenH)
			self.mCoins.append(c)
		if self.mCoins[0].getX() == 0:
			if self.mCoins[0].getColor() == 200:
				self.mScore1.sub()
			del self.mCoins[0]
		return True

	def buildingCheck(self):
		building_start = self.mScreenW - (self.mBuildings[-1].getX()+self.mBuildings[-1].getWidth())
		if self.mBuildings[-1].getX() == building_start:
			b = building.Building((0,0,0), self.mScreenW, self.mScreenH/2, 100, self.mScreenH/2)
			self.mBuildings.append(b)
		if self.mBuildings[0].getX() == -200:
			del self.mBuildings[0]
		return True

	def scoreCheck(self):
		if int(self.mScore1.getScore()) >= 300:
			print('You win.')
			quit()
		if int(self.mScore2.getScore()) >= 50:
			print('You lose.')
			quit()

	def animate(self):
		self.scoreCheck()
		for b in self.mBuildings:
			for i in range(7):
				self.buildingCheck()
				b.move()
		for c in self.mCoins:
			for i in range(5):
				self.coinCheck()
				self.coinCollision()
				c.move()

	def draw(self, surface):
		self.mBackground.draw(surface)
		self.mPaddle.draw(surface)
		self.mScore1.draw(surface)
		self.mScore2.draw(surface)
		for c in self.mCoins:
			c.draw(surface)
		for b in self.mBuildings:
			b.draw(surface)

