#this program will implement a game called Ricerca Binaria


#this function is just a welcome page to the program
def welcomepage():
    print("""Greatings human.
I am going to pick a number between 17 and 666, inclusive.
It is up to you to figure out what number I have chosen.""")
    
#this function will generate a random number between 1 and 100
import random
def randomnum():
    randnum = random.randrange(17, 666+1)
    return randnum

#this function will prompt the user to guess the generated number
def guessgame(num):
    print ("I have picked a number, and you have 17 guesses... good luck guessing...")
    guess = 0
    i = 1
    while guess != num and i < 18:
        if i == 17:
            print("This is your last guess.")
        guess = int(input("Enter guess #" + str(i) + ": "))
        i += 1
        if guess > num:
            print("Too high, human.")
        elif guess < num:
            print("Too low, human.")
        elif guess == num:
            print ("Congratulations, you guessed correctly!")
            print ("I guess I'll spare your life.")
        if i == 18:
            print ("You are now going to die now, sorry.")
            
def main():
    welcomepage()
    startup = input("Are you ready? y or n: ")
    if startup == "y":
        print("Wise choice.")
        guessgame(randomnum())
    if startup == "n":
        print("Too bad.")
        guessgame(randomnum())
main()
    
    
