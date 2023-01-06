import background
import paddle
import ball
import score

class Pong:
	def __init__(self, screenW, screenH):
		self.mScreenW = screenW
		self.mScreenH = screenH
		#self.mBackground = background.Background(color, x, y, w, h)
		self.mBackground = background.Background((255,255,255), 0, 0, 900, 700)
		#self.mPaddle = Paddle(color, x, y, w, h))
		self.mPaddle = paddle.Paddle((0,0,0), 100, 80, 20, 100)	
		#self.mScore = score.Score(color, string, x, y)
		self.mScore1 = score.Score((0, 200, 0), '0', 50, 50)
		self.mScore2 = score.Score((200, 0, 0), '0', 850, 50)
		#self.mBall = Ball(color, x, y, w, h, screenW, screenH, paddleobj, scoreobj, scoreobj))
		self.mBall = ball.Ball((0,0,0), 300, 120, 20, 20, self.mScreenW, self.mScreenH, self.mPaddle, self.mScore1, self.mScore2)

	def draw(self, surface):
		self.mBackground.draw(surface)
		self.mPaddle.draw(surface)
		self.mBall.draw(surface)

	def up(self):
		self.mPaddle.up()
	def down(self):
		self.mPaddle.down()
	
	def move(self):
		self.mBall.move()

