def maxSequence(A):
    current, s, start, end = 0,0,0,0
    maximum = A[0]
    for i in range(len(A)):
        current += A[i]
        if current < 0:
            s = i+1
            current = 0
        if current > maximum:
            start = s
            end = i
            maximum = current
    return start, end, maximum
