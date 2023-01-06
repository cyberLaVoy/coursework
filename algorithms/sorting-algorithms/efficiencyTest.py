import randlistgen as generator
import annotatedSortingAlgorithms as al
import math
import sys

sys.setrecursionlimit(10000)

sorting_algorithms = [["Bubble", al.bubbleSort],["Shaker", al.shakerSort],
                      ["Selection", al.selectionSort], ["Quick", al.quickSort], 
                      ["mQuick", al.mquickSort],
                      ["Merge", al.mergeSort], ["Hash", al.hashSort]]


def compareLists(list_A, list_B):
    result = False
    if list_A == list_B:
        result = True
    return result

def printResult(list_A, list_B, event_counter):
    if compareLists(list_A, list_B):
        print(round(math.log(event_counter[chart_type], 2), 2) , end=", ")
    else:
        print("Sorting Failure")
    return

def sortingTest(sorting_method, event_counter, list_A, list_B):
    sorting_method(list_A, event_counter)
    printResult(list_A, list_B, event_counter)
    return

def createChart(mostly_sorted):
    print("", end=", ")
    for i in range(len(sorting_algorithms)):
        print(sorting_algorithms[i][0], end=", ")
    print()

    for exp in range(3, 13):
        print(exp, end=", ")
        A = generator.randomList(2**exp,0,8) 
        A_sorted = A[:]
        A_sorted.sort()
        for i in range(len(sorting_algorithms)):
            event_counter = {"compare" : 0, "swap" : 0}
            A_copy = A[:]

            if mostly_sorted:
                A_copy.sort()
                al.swapListValues(A_copy, 0, len(A_copy)-1)

            sortingTest(sorting_algorithms[i][1], event_counter, A_copy, A_sorted)
        print()
    return

def main():
    global chart_type
    print("Number of Value Comparisons on Randomly Generated List")
    chart_type = "compare"
    createChart(False)
    for i in range(17):
        print()

    print("Number of Value Swaps on Randomly Generated List")
    chart_type = "swap"
    createChart(False)
    for i in range(17):
        print()

    print("Number of Value Comparisons on Mostly Sorted List")
    chart_type = "compare"
    createChart(True)
    for i in range(17):
        print()

    print("Number of Value Swaps on Mostly Sorted List")
    chart_type = "swap"
    createChart(True)
    for i in range(17):
        print()
    return
main()

