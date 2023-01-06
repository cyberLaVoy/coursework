
def welcome():
	print("Welcome human, I've chosen not to destroy you")
	return True

def userinput(listofdict):
	print("""Here are your options:
	[r] Record Gas Consumption
	[l] List Mileage History
	[c] Calculate Gas Mileage
	[q] Quit""")
	choice = input("Choose an option: ")
	while choice != "r" and choice != "l" and choice != "c" and choice != "q":
		print("Not a valid input, try again...")
		choice = input("choose an option: ")
	while len(listofdict) == 0 and (choice == "l" or choice == "c"):
		print("Record an entry first...")
		choice = input("choose an option: ")
	return choice

def record():
	date = input("Today's date?: ")
	traveled = float(input("Miles traveled?: "))
	gallons = float(input("Gallons burned?: "))
	entry = {"date" : date , 
		 "traveled" : traveled ,
		 "gallons" : gallons}
	return entry

def history(listofdict):
	for i in range(len(listofdict)):
		date = listofdict[i]["date"]
		traveled = listofdict[i]["traveled"]
		gallons = listofdict[i]["gallons"]
		print("On " + date + ": " + str(traveled) + " miles traveled, using " + str(gallons) + " gallons")
		mpg = traveled/gallons
		print("Miles per gallon: " + str(mpg))
	return True

def calmpg(listofdict):
	total = 0
	for i in range(len(listofdict)):
		traveled = listofdict[i]["traveled"]
		gallons = listofdict[i]["gallons"]
		total += traveled/gallons
	mpg = total/len(listofdict)
	print("Average miles per gallon: " + str(mpg))
	return True

def main():
	listofdict = []
	welcome()
	while True:
		print()
		print("------------------------------")
		choice = userinput(listofdict)
		if choice == "r":
			listofdict.append(record())
		elif choice == "l":
			history(listofdict)
		elif choice == "c":
			calmpg(listofdict)
		else:
			break
main()

