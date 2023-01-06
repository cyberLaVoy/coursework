import polygon, math

class Rock(polygon.Polygon):
	def __init__(self, x, y, points,direction):
		polygon.Polygon.__init__(self,x,y,points)			
		self.mDirection = direction
		self.mSetDirection = direction
		self.mDx = math.cos(self.mSetDirection)
		self.mDy = math.sin(self.mSetDirection)

	def wander(self):
		self.transform()
		self.rotate(math.pi/24)
		for i in range(5):
			self.move()
		self.wrap()

