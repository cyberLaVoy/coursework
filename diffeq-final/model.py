from matplotlib import pyplot as plt
import math, random
import numpy as np

def model(delta_t, alpha, beta, delta, gamma, lamb,  A0, R0, S0, steps, masting=False):
    A, R, S = [A0], [R0], [S0]
    day = 0
    for i in range(steps):
        dayNew = int(delta_t*i)
        if i == 0 or dayNew > day:
            if day % 14 == 0:
                p = random.randrange(50, 100)
            if masting and day % 14 == 0 and day >= 365*10 and day <= 365*10+90:
                p = random.randrange(800, 1000)
            if day % (365//2) == 0:
                r = random.randrange(2, 10)
            if day % (365*3) == 0:
                s = random.randrange(2, 14)
            day = dayNew

        A.append( A[i] + delta_t * ( p - alpha*R[i]*A[i] ) )
        R.append( R[i] + delta_t * ( beta*R[i]*A[i]*r - delta*R[i]*S[i] ) )
        S.append( S[i] + delta_t * ( gamma*R[i]*S[i]*s - lamb*S[i] ) )

    print(A[-1], R[-1], S[-1])
    print(A[:12], R[:12], S[:12])
    return A, R, S

def displayModel(X, Y, names, title):
    Y = np.array(Y)
    X = np.array(X)
    Y = np.log(Y)
    #X = np.log(X)
    plt.style.use("dark_background")
    plt.figure( figsize=(6.4*2, 4.8*2) )
    plt.suptitle(title)
    plt.xlabel("Time (days)")
    plt.ylabel("Population Counts (Log Scale)")
    plt.grid(linewidth=.25)

    ax = plt.twinx()
    step = 50
    maxTick = int(np.max(Y))
    yticks = [v for v in range(0, maxTick, step)]
    ax.set_yticks(yticks)

    for y in Y:
        plt.plot(X, y)
    plt.legend( names )

    #plt.show()
    plt.savefig("model-visuals/" + title.replace(" ", "-") + ".png", bbox_inches="tight")


def main():
    A0 = 1000
    R0 = 500
    S0 = 250

    ### equalibrium values
    """
    p = 50
    alpha = 1250/A0 * 1/25 * 1/R0 
    beta = alpha * (2*5)/365
    delta = 25/365 * 20/R0 * 1/S0
    gamma = delta * 27.375/(3*365)
    lamb = 1/(20*365)
    """

    alpha = 1250/A0 * 1/25 * 1/R0 
    beta = alpha * 2/365
    delta = 24/365 * 20/R0 * 1/S0
    gamma = delta * 1/(3*365)
    lamb = 1/(38*365)
    print(alpha, beta, delta, gamma, lamb)

    # start time
    a = 0
    # end time (in days)
    years = 30
    b = 365*years
    # divisions of change 
    N = 25000
    steps = N
    delta_t = (b-a)/N

    X = [ i*delta_t for i in range(N+1) ]
    A, R, S = model(delta_t, alpha, beta, delta, gamma, lamb,  A0, R0, S0, steps, masting=True)
    #displayModel(X, [R], ["Rodents"], "Forest Life")
    #displayModel(X, [A, R, S], ["Acorns", "Rodents", "Snakes"], "Forest Life (All Interactions)")
    #displayModel(X, [R, S], ["Rodents", "Snakes"], "Forest Life (Preditor-Prey Interaction)")
    displayModel(X, [A, R, S], ["Acorns", "Rodents", "Snakes"], "Forest Life (All Interactions With Masting)")
    displayModel(X, [S], ["Snakes"], "Forest Life (Snake Variation With Masting)")

main()