import rock,random,math
from config import *

def generateRocks(num):
	rocks = []

	for i in range(num):

		size = random.randrange(2,4+1)
		if size == 2:
			size = 2.5
		x_point1 = random.randrange(6,10+1)*size
		x_point2 = random.randrange(-10,-6+1)*size
		y_point1 = random.randrange(-10,-6+1)*size
		y_point2 = random.randrange(6,10+1)*size
		points = [(x_point1,0),(0, y_point1),(x_point2, 0),(0, y_point2)]

		x_location = random.randrange(0, ScrW)
		y_location = random.randrange(0, ScrH)

		x_list = []
		y_list = []
		for r in rocks:
			x_list.append(r.mX)
			y_list.append(r.mY)

		while not checkValues(x_list, x_location, 'x'):
			x_location = random.randrange(0, ScrW)

		while not checkValues(y_list, y_location, 'y'):
			y_location = random.randrange(0, ScrW)
					
		direction = random.randrange(0, 6+1)

		rocks.append(rock.Rock(x_location, y_location, points, direction))

	return rocks
		

def checkValues(value_list, location, xORy):
	if xORy == 'y':
		if location <= ScrH/2+100 and location >= ScrH/2-100:
			return False
	if xORy == 'x':
		if location <= ScrW/2+100 and location >= ScrW/2-100:
			return  False
	for value in value_list:
		if value <= location+30 and value >= location-30:
			return  False
	return True
