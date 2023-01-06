import account

class Savings(account.Account):
	def __init__(self, user, accountnum, startbal, interest):
		account.Account.__init__(self, user, accountnum, startbal)
		self.mInterest = interest
		self.mAccountType = 's'

	def addInterest(self):
		value = 1 + self.mInterest/(12*100)
		self.mBalance = round(self.mBalance*value, 2)
	
	def getAccountType(self):
		return self.mAccountType

	def getBalance(self):
		return self.mBalance

	
