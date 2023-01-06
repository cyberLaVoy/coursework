

class Account():
	def __init__(self, user, accountnum, startbal):
		self.mUser = user
		self.mAccountnum = accountnum
		self.mBalance = startbal
		
	def give(self, amount):
		if amount > 0:
			self.mBalance += amount
			return True
		return False
	
	def take(self, amount):
		if amount > 0 and self.mBalance >= amount:
			self.mBalance -= amount
			return True
		return False

