import account

class Checking(account.Account):
	def __init__(self, user, accountnum, startbal, overdraft):
		account.Account.__init__(self, user, accountnum, startbal)
		self.mOverdraft = overdraft
		self.mAccountType = 'c'

	def cTake(self, amount):
		value = self.mBalance + self.mOverdraft
		if amount > 0 and value >= amount:
			self.mBalance -= amount
			return True
		return False

	def getAccountType(self):
		return self.mAccountType

	def getBalance(self):
		return self.mBalance
