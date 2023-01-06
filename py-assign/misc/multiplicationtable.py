#this program will allow a user to practce their multiplication

import time

def welcomePage():
    print("Time to practice your multipication.")
    print("Can be used for any possitive integer, testing multipication with 0-12 inclusive.")
    print("Note that all numbers entered will be converted to integers. \n")
    
def uservalue():
    value = input("What number would you like to practice?: ")
    
    while value.isdigit() != True:
        print("Not a valid entry... try again.")
        value = input("What number would you like to practice?: ")
       
    value = int(value)
    return value

def timestabletest(value):
    startTime = time.time()
    for i in range(13):
        answer = value * i
        useranswer = input(str(value) + "*" + str(i) + "=")

        while useranswer.isdigit() != True:
            print("Not a valid entry... try again.")
            useranswer = input(str(value) + "*" + str(i) + "=")
        useranswer = int(useranswer)
            
        while useranswer != answer:
            print("Incorrect. Try Again.")
            useranswer = input(str(value) + "*" + str(i) + "=")

            while useranswer.isdigit() != True:
                print("Not a valid entry... try again.")
                useranswer = input(str(value) + "*" + str(i) + "=")
            useranswer = int(useranswer)
            
    stopTime = time.time()
    timeElapsed = stopTime - startTime
    if timeElapsed < 25:
        print("Wow! Time elapsed: " + str(timeElapsed) + "s" + "\n")
    elif timeElapsed >= 25 and timeElapsed <= 40:
        print("Not bad... but could improve. Time elapsed: " + str(timeElapsed) + "s" + "\n")
    elif timeElapsed > 60:
        print("That was terrible. Wake up! Time elapsed: " + str(timeElapsed) + "s" + "\n")
        
def repeatProg():
    repeat = input("Would you like to run this program again? y or n: ")
    while repeat != "y" and repeat != "n":
        print("Not a valid entry.")
        repeat = input("Would you like to run this program again? y or n: ")
    if repeat == "y":
        return True
    elif repeat == "n":
        return False
    
def main():
    welcomePage()
    value = uservalue()
    timestabletest(value)
    if repeatProg():
        value = uservalue()
        timestabletest(value)
    else:
        print("Okay, bye now.")
main()

#code by LaVoy
