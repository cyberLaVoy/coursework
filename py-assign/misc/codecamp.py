#enjoy

def welcomepage():
    print("""
Welcome to Code Camp Team Manager

This program will add teams to the team
database file.  You can run the program
again to add more teams to the file.

Use the other program to display a list
of teams.
""")
    
welcomepage()

def writefile():
    file = input("File name?: ")
    return file

def gatherteam():
    team = input("What is the name of your team?: ")
    return team

def gatherplayers():
    players = []
    num = input("How many team members(between 1 and 4, inclusive)?: ")
    while num != "1" and num != "2" and num != "3" and num != "4":
        print("Not a valid team number")
        num = input("How many team members?: ")
    num = int(num)
    for i in range(num):
        play = input("team member #" + str(i+1) + ": ")
        players.append(play)
    return players

def appendfile(file, team, players):
    fout = open(file, "a")
    fout.write("Team" + "\n" + team + "\n")
    for i in range(len(players)):
        fout.write("Member" + "\n" + players[i] + "\n")
    fout.close()
    print("Team has been created")

def repeat():
    re = input("Would you like to create another team? (y or n): ")
    while re != "y" and re != "n":
        print("Not a valid entry.")
        re = input("Would you like to create another team? (y or n): ")
    if re == "y":
        main()
    else:
        print("Okay, bye now")
        
    

def main():
    file = writefile()
    team = gatherteam()
    players = gatherplayers()
    appendfile(file, team, players)
    repeat()
main()

#code by LaVoy
