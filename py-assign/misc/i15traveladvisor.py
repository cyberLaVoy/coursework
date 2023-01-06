#this is a program to help with traveling on I-15 in Utah

def main():
    
    #an introduction for the user
    print ("Welcome to the highway travel advisor.")
    print ("This application has been configured to work with travel on I-15 within the state of Utah.")
    print ("We'll ask for a few pieces of information, then give you advice on your travel.")

    #this will promt the user to enter in the known data
    enternum = float(input("Enter I-15 at what mile marker? "))
    if enternum < 0:
        print ("That exit doesn't exist")
        main()
        
    exitnum = float(input("Exit I-15 at what mile marker? "))
    if exitnum > 400:
        print ("I have no idea where you even are")
        main()
        
    howfast = float(input("How fast (in miles per hour) do you expect to travel? "))
    if howfast > 80:
        print("Woah! Might want to slow down. You could end up getting pulled over.")
    elif howfast < 60:
        print("That is a bit too slow for a highway. I would speed up, if you can.")

    #this will determine the total travel distance
    if exitnum > enternum:
        traveldistance = exitnum - enternum
    else:
        traveldistance = enternum - exitnum

    #this determines the time it will take for their journey
    traveltime = traveldistance / howfast
    
    howsoon = float(input("How soon do you wish to arrive (in hours)? "))
    if howsoon < traveltime:
        print ("You will not arrive on time.")
        
    #this detimines how soon they need to leave, in order to arrive on time
    timetoleave = howsoon - traveltime

    #displays final calculations
    print ("Total travel distance: " + str(traveldistance) + " miles")
    print ("You must leave in the next " + str(timetoleave) + " hours to be on time.")
    print ("Thank you for using this program.")

    repeat = input("Enter 'again', if you wish to run this program again: ")
    if repeat == "again":
        main()
        
main()

