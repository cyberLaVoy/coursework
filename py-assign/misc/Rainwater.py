#this is the indroduction to the program
print ("Want to know how big your rainwater tank needs to be?")
print ("Well, assuming your catchment area is rectangular, this program will be able to tell you!\r\n")

#this will store values and return the size the tank needs to be in gallons
def rainwater():
    
    rainfall = float(input("During a large storm, what will the typical rainfall in inches be?\t"))
    width = float(input("How wide is your catchment area, in feet?\t"))
    length = float(input("How long is your catchment area, in feet?\t"))

    sizeoftank = ((rainfall/12)*(width)*(length)*(7.48))

    print ("\r\nYour tank will require a capacity of about " + str(int(sizeoftank)) + " gallons, in order for you to capture that much rain.\r\n")

#this will allow for the rainwater() function to be called infinite times
    repeat = input("To test different numbers, by running the program again, type: rainwater() and press enter.\r\n\t")
    if repeat == "rainwater()":
        print (rainwater())
    
print (rainwater())


    
