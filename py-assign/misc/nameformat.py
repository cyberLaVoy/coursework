#this program takes an input as a name in order "first last"
#then converts the name into the form "last, first"

def name_format(name_input):

    #this grabs the space and defines it as a variable called space
    for i in range(len(name_input)):
        if name_input[i] == " ":
            space = i
            
    #this grabs the last name of the user
    last_name = ""
    for i in range(len(name_input)):
        if i > space:
            last_name = last_name + name_input[i]
            
    #this grabs the first name of the user
    first_name = ""
    for i in range(len(name_input)):
        if i < space:
            first_name = first_name + name_input[i]

    #this creates the formated name
    formated_name = last_name + ", " + first_name

    #this prints and returns the formatted name
    print (formated_name)
    return (formated_name)


def test_of_code():
    
    if name_format("Bill Salter") == "Salter, Bill":
        print ("Bill Salter: passed")
    else:
        print ("Bill Salter: failed")
        
    if name_format("Michael Green") == "Green, Michael":
        print ("Michael Green: passed")
    else:
        print ("Michael Green: failed")

    if name_format("J Graff") == "Graff, J":
        print ("J Graff: passed")
    else:
        print ("J Graff: failed")
        

def main():
    name_format(input("Type your first and last name, seperated by a space: "))
    if_test = input("Enter 'yes' if you would like to test your code: ")
    if if_test == "yes":
        test_of_code()
main()
    
