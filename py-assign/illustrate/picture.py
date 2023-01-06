
from environment import Sky
from environment import Ground
from moon import Moon
from mountain import Mountain
from road import Road
from line import Line
from bush import Bush


m1 = [(0,200),(140,100),(240,200)]
s1 = [(120,115),(140,100),(150,110),(140,120)]
class Picture:
	def __init__(self):
		self.mSky = Sky((25,18,51),600,200)
		self.mGround = Ground((51,38,25),600,300)
		self.mMoon = Moon((232,232,205), 220, 160, 20)
		self.mMountain1 = Mountain(m1, s1)
		#self.mMountain2 = Mountain()
		#self.mMountain3 = Mountain()
		#self.mMountain4 = Mountain()
		self.mRoad = Road()
		self.mLine1 = Line([(300,400), (300,460)], 7)
		self.mLine2 = Line([(300,320), (300,360)], 5)
		self.mLine3 = Line([(300,260), (300,280)], 3)
		self.mLine4 = Line([(300,220), (300,230)], 2)
		self.mBush1 = Bush(80, 360, 25)
		self.mBush2 = Bush(160, 300, 15)	
		self.mBush3 = Bush(240,240, 7)
		#self.mBush4 = Bush()
		#self.mBush5 = Bush()
		#self.mBush6 = Bush()

	def draw(self, surface):
		self.mSky.draw(surface)
		self.mMoon.draw(surface)
		self.mGround.draw(surface)
		self.mMountain1.draw(surface)
		#self.mMountain2.draw(surface)
		#self.mMountain3.draw(surface)
		#self.mMountain4.draw(surface)
		self.mRoad.draw(surface)
		self.mLine1.draw(surface)
		self.mLine2.draw(surface)
		self.mLine3.draw(surface)
		self.mLine4.draw(surface)
		self.mBush1.draw(surface)
		self.mBush2.draw(surface)
		self.mBush3.draw(surface)
		#self.mBush4.draw(surface)
		#self.mBush5.draw(surface)
		#self.mBush6.draw(surface)





