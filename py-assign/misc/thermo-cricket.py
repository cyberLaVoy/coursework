#Using Crickets as a Thermometer: this is an assignment for week 3 in CS 1400

print ("Hi Dipper, I am here to assist you in the search for the creature that you seek. Use your stop watch to count how many times the crickets around you chirp in 13 seconds.")

def creature():
    
    chirps = int(input("Enter how many chirps you counted here:"))
    temp = (chirps+40)
    
    if temp<55:
        print ("Current temperature is too cold for crickets.")
    if 75<=temp<=80:
        print ("The creature is out.")
    else:
        print ("According to my calculations, it is currently " + str(temp) + " degrees farenheit.")
        
    repeat = input("To run program again, type: creature() and press enter.\r\n\t")
    if repeat == "creature()":
        creature()
    
creature()

