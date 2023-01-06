baseCal = 0

class Person:
	def __init__(self, gender, height, weight, age, BMR):
		self.mGender = gender
		self.mHeight = height
		self.mWeight = weight
		self.mAge = age
		self.mCalories = baseCal - BMR
		return
	
	def consume(self, intake):
		self.mCalories += intake
		return True

	def exersise(self, activity, duration):
		calinit = self.mCalories
		if activity == 'w':
			self.mCalories -= .039*duration*self.mWeight
		elif activity == 's':
			self.mCalories -= .071*duration*self.mWeight
		elif activity == 'r':
			self.mCalories -= .095*duration*self.mWeight
		elif activity == 'd':
			self.mCalories -= .046*duration*self.mWeight
		elif activity == 'b':
			self.mCalories -= .045*duration*self.mWeight
		if calinit != self.mCalories:
			return True

	def getCalories(self):
		return self.mCalories
