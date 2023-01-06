import savings
import checking


def accountChoice():
	print("What type of account would you like to track?")
	print("[c] Checking account")
	print("[s] Savings account")
	a = 'placeholder'
	while a not in 'cs':
		a = input("Enter an option: ")
	return a

def createAccount(a):
	print("Okay, cool.")
	print("Please provide the following information...")
	user = input("Your name? ")
	accountnum = input("Account number? ")
	startbal = float(input("Starting balance? "))
	if a == 'c':
		overdraft = float(input("Overdraft limit? "))
		account = checking.Checking(user, accountnum, startbal, overdraft)
	if a == 's':
		interest = float(input("Interest rate? "))
		account = savings.Savings(user, accountnum, startbal, interest)	
	return account

def accountActions(account):
	account_type = account.getAccountType()
	action = 'placeholder'
	while action != 'q':
		action = 'placeholder'
		print("What would you like to do?")
		print("[d] Deposit money")
		print("[w] Withdraw money")
		if account_type == 's':
			print("[a] Add monthly interest")
		print("[q] Quit")
		while action not in 'dwaq':
			action = input("Enter an option: ")
		if action == 'd':
			amount = float(input("Amount to deposit? "))
			account.give(amount)
		if action == 'w':
			amount = float(input("Amount to withdraw? "))
			if account_type == 's':
				if not account.take(amount):
					print("Insufficient funds.")
			if account_type == 'c':
				if not account.cTake(amount):
					print("Insufficient funds.")
		if action == 'a' and account_type == 's':
			account.addInterest()
			print("Interest added.")
		print("Account balance: " + str(account.getBalance()))
		print()
	print("Bye, now.")
	print()


def main():
	a = accountChoice()
	account = createAccount(a)
	accountActions(account)
main()


