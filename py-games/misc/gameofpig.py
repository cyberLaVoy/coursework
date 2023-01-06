

def instructions():
    print("""Welcome to the Game of Pig.  To win, be the
player with the most points at the end of the
game.  The game ends at the end of a round where
at least one player has 100 or more points.

On each turn, you may roll the die as many times
as you like to obtain more points.  However, if
you roll a 1, your turn is over, and you do not
obtain any points that turn.

Let's begin!
""")


import random
def rolldie():
    roll = random.randrange(1, 7)
    print("Number rolled: " + str(roll))
    if roll != 1:
        return roll
    else:
        print("Turn over")
        print("---------------------------")
        return 1

def rollagain():
    again = input("Would you like to roll again1? (n/y): ")
    while again != "n" and again != "y":
        print("Not a valid input")
        again = input("Would you like to roll again2? (n/y): ")
    if again == "y":
        return True
    else:
        print("---------------------------")
        return False
    


def roundscore():
    total = 0
    roll = rolldie()
    if roll != 1:
        total += roll
        print("Round points: " + str(total))
        while rollagain():
            roll = rolldie()
            if roll != 1:
                total += roll
                print("Round points: " + str(total))
            else:
                return 0
    else:
        return 0
    return total


def playgame():
    p1 = 0
    p2 = 0
    while True:
        print("player 1 points:" + str(p1))
        print("player 2 points:" + str(p2))
        print("---------------------------")
        p1start = input("Player 1 hit enter to begin your turn. ")
        p1 += roundscore()

        print("player 1 points:" + str(p1))
        print("player 2 points:" + str(p2))
        print("---------------------------")
        p1start = input("Player 2 hit enter to begin your turn. ")
        p2 += roundscore()
        
        if p2 >= 100 or p1 >= 100:
            break

    print("---------------------------")
    print("The game is over")
    if p1 == p2:
        print("players have tied")
    elif p1 > p2:
        print("Congratulations, player 1 wins!")
    else:
        print("Congratulations, player 2 wins!")
            

def main():
    instructions()
    playgame()
main()
    
