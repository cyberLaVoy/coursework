
from cb import *

def welcome():
	print()
	print("----------------------------------------------------------")
	print("I am here to help you keep track of you caloric balence.")
	print("Please, provide me with some information about you bellow.")
	print()
	return

def createObject():
	g = input("Gender (m or f): ")
	a = int(input("Age (in years): "))
	h = int(input("Height (in inches): "))
	w = int(input("Weight (in pounds): "))
	if g == 'm':
		BMR = 66 + (12.7 * h) + (6.23 * w) - (6.8 * a)
	elif g == 'f':
		BMR = 655 + (4.7 * h) + (4.35 * w) - (4.7 * a)
	p = Person(g, h, w, a, BMR) 
	print("Information stored.")
	return p

def userInput():
	print("""What would you like to do?
	[c] Record Consumption
	[a] Record Physical Activity
	[q] Quit""")
	option = input("Enter option here: ")
	return option

def consume(p):
	intake = int(input("# of calories consumed: "))
	p.consume(intake)
	return

def activity(p):
	print("""Choose from the available activities below...
	[w] Weight Training
	[s] Swimming
	[r] Running
	[d] Dancing
	[b] Bicycling""")
	activity = input("Enter option here: ")
	duration = float(input("For how long (in minutes): "))
	p.exersise(activity, duration)
	return

def info(p):
	print()
	print("-----------------------------------------------------")
	c = p.getCalories()
	c = round(c, 2)
	print("Current expected calories for the day is... " + str(c))

def main():
	welcome()
	p = createObject()
	info(p)
	while True:
		char = userInput()
		if char == 'c':
			consume(p)
			info(p)
		elif char == 'a':
			activity(p)
			info(p)
		elif char == 'q':
			info(p)
			print("Goodbye, now.")
			break
main()
	
		
