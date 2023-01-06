import numpy as np
import matplotlib.pyplot as plt

def dadt(a, alpha, p):
    return p - alpha*a

def main():
    A0 = 10000
    R0 = 500

    t = np.arange(0, 10*365, 100)

    a = np.arange(0, A0, 200)
    r = np.arange(0, R0, 10)
    a = r*a

    T, A = np.meshgrid(t, a)
    U = np.ones(A.shape)

    p = 50
    alpha = 500/A0 * 1/25 * 1/R0
    V = dadt(p, alpha, A)

    plt.style.use("dark_background")
    plt.title("Forest Phase Portrait")
    plt.quiver(T, A, U, V, abs(V))
    plt.grid()
    plt.xlabel("Time (Days)")
    plt.ylabel("Population Count")
    plt.show()

main()