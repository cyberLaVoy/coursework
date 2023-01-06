import random

def randomList(size, s, e):
    random_list = []
    for i in range(size):
        random_list.append(random.randrange(s, e+1))
    return random_list

