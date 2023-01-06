#this program will allow a user to input and view their class schedule
#a list of possible time slots will be provided

def greatingPage():
    print("==================================================")
    print("Welcome to the class schedule planner.")
    
    print("")
    
    print("This application will prompt you to enter in your class times,")
    print("and display for you.")
    
    print("")
    
    print("At Dixie State, there are 13 normal class start times.")
    print("Time slots are as follows:")
    print("a - 8:00am MWF") #a
    print("b - 9:00am MWF") #b
    print("c - 10:00am MWF") #c
    print("d - 11:00am MWF") #d
    print("e - 12:00pm MWF") #e
    print("f - 1:00pm MWF") #f
    print("g - 2:00pm MWF") #g
    print("h - 3:00pm MWF") #h
    print("i - 7:30am TR") #i
    print("j - 9:00am TR") #j
    print("k - 10:30am TR") #k
    print("l - 1:00pm TR") #l
    print("m - 2:30pm TR") #m

#provides a list to place class times in 
list_of_classes = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m"]
constant_list = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m"]
    
def userInput():
    
    print("")
    timeslot_promt = input("Time Slot? (a letter from a - m): ")
    total = 0
    i = 0
    while total < 13 and timeslot_promt != constant_list[i]:
        total += 1
        i += 1
    if total == 13:
        print("Not a valid time slot; please try again...")
        userInput()
        
    mod_string = input("Course name?: ")

    for i in range(len(constant_list)):
        if timeslot_promt == constant_list[i]:
            
            del list_of_classes[i];
            
            if len(mod_string) > 0:
                list_of_classes.insert(i, ("Slot " + constant_list[i] + "; " + mod_string))
            else:
                list_of_classes.insert(i, constant_list[i])
                
    print("Here is your current list of class:")
    for i in range(len(list_of_classes)):
        if len(list_of_classes[i]) > 1:
            print(list_of_classes[i])

    print("")                     
    again_promt = input("Any more classes to enter? enter 'yes' or 'no': ")
    if again_promt == "yes":
        userInput()
    elif again_promt == "no":
        closingStatement()
    
    
def startupPromt():
    print("")
    startup = input("Ready to begin? Enter 'yes' or 'no': ")
    if startup == "yes":
        userInput()
    if startup == "no":
        print("")
        print("Okay, bye now!")
        
def closingStatement():
    print("")
    print("Thank you for using this program!")
    print("Here is a list of all your classes:")
    for i in range(len(list_of_classes)):
        if len(list_of_classes[i]) > 1:
            print(list_of_classes[i])
       
def main():
    greatingPage()
    startupPromt()
main()

#end of program here; by LaVoy
#thank you for checking out my code
    
