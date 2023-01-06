
def legalMove(list_a, list_b):
    move_made = False

    if len(list_a) == 0:
        list_a.append(list_b.pop())
        move_made = True
    if len(list_b) == 0:
        list_b.append(list_a.pop())
        move_made = True

    if not move_made:
        if list_a[-1] < list_b[-1]:
            list_b.append(list_a.pop())
            move_made = True
        else:
            list_a.append(list_b.pop())
            move_made = True

    return move_made

def makeMove(s_pole, a_pole, d_pole, switch, i):
    if i%3 == 0:
        if switch:
            legalMove(s_pole, a_pole)
        else:
            legalMove(s_pole, d_pole)
    if i%3 == 1:
        if switch:
            legalMove(s_pole, d_pole)
        else:
            legalMove(s_pole, a_pole)
    if i%3 == 2:
        legalMove(d_pole, a_pole)


def solveTowers(n):
    switch = False
    if n%2 == 0:
        switch = True
    total_moves = 2**n-1
    s_pole = []
    a_pole = []
    d_pole = []
    for i in range(n, 0, -1):
        s_pole.append(i)

    for i in range(total_moves):
        makeMove(s_pole, a_pole, d_pole, switch, i)
        print("move #" + str(i+1))
        print("source pole: " + str(s_pole))
        print("auxilary pole: " + str(a_pole))
        print("destination pole: " + str(d_pole))
        

def main():
    n = input("How many blocks? ")
    solveTowers(int(n))
main()

