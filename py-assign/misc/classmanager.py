#class participation manager

def welcomepage():
    print("""Welcome.
Here is how this works...
You type in the name of a text file, with a list of names,
and I will return a random name form that list.
Ready?
Go.
""")

def grabtext():
    textfile = input("What is the name of the roll file?: ")
    while textfile[-4:] != ".txt":
        textfile = input("What is the name of the roll file?: ")
    return textfile
    

def createlist(textfile):
    somelist = []
    fin = open(textfile, "r")
    for line in fin:
        line = line.strip()
        somelist.append(line)
    fin.close()
    return somelist


import random
def genran(somelist):
    num = random.randrange(len(somelist))
    chosen = somelist[num]
    return chosen
    


def main():
    welcomepage()
    textfile = grabtext()
    somelist = createlist(textfile)
    chosen = genran(somelist)
    print("Student: " + str(chosen))
    another = input("Pick anoher student? (y or n): ")
    while another != "n":
        chosen = genran(somelist)
        print("Student: " + str(chosen))
        another = input("Pick anoher student? (y or n): ")

    print("Thank you for using this program.")
main()

#code by LaVoy
