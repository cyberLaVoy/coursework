def swapListValues(A, first_index, second_index):
    temp = A[first_index]
    A[first_index] = A[second_index]
    A[second_index] = temp
    return

#QUICK SORT
def quickSort(A, event_counter, low_index=0, high_index=-1, first_round=True):
    if first_round:
        high_index = len(A)-1
    
    if high_index <= low_index:
        return

    lmgt = low_index+1
    for i in range(low_index+1, high_index+1):
        event_counter['compare'] += 1
        if A[i] < A[low_index]:
            event_counter['swap'] += 1
            swapListValues(A, lmgt, i)
            lmgt += 1
    rmlt = lmgt - 1
    event_counter['swap'] += 1
    swapListValues(A, low_index, rmlt)

    quickSort(A, event_counter, low_index, rmlt-1, False)
    quickSort(A, event_counter, rmlt+1, high_index, False)
    return

#MODIFIED QUICK SORT
def mquickSort(A, event_counter, low_index=0, high_index=-1, first_round=True):
    if first_round:
        high_index = len(A)-1

    if high_index <= low_index:
        return

    mid_index = (low_index+high_index)//2
    event_counter['swap'] += 1
    swapListValues(A, low_index, mid_index)

    lmgt = low_index+1
    for i in range(low_index+1, high_index+1):
        event_counter['compare'] += 1
        if A[i] < A[low_index]:
            event_counter['swap'] += 1
            swapListValues(A, lmgt, i)
            lmgt += 1
    rmlt = lmgt - 1
    event_counter['swap'] += 1
    swapListValues(A, low_index, rmlt)

    mquickSort(A, event_counter, low_index, rmlt-1, False)
    mquickSort(A, event_counter, rmlt+1, high_index, False)
    return


#MERGE SORT
def mergeSort(A, event_counter):

    if len(A) <= 1:
        return
    middle_index = len(A)//2
    left_half = A[0:middle_index]
    right_half = A[middle_index:]
    event_counter['swap'] += (len(left_half) + len(right_half))

    mergeSort(left_half, event_counter)
    mergeSort(right_half, event_counter)
    i = 0
    j = 0
    k = 0
    while i < len(left_half) and j < len(right_half):
        event_counter['compare'] += 1
        if left_half[i] <= right_half[j]:
            event_counter['swap'] += 1
            A[k] = left_half[i]
            i += 1
            k += 1
        else:
            event_counter['swap'] += 1
            A[k] = right_half[j]
            j += 1
            k += 1
    if i < len(left_half):
        event_counter['swap'] += (len(left_half[i:]))
        A[k:] = left_half[i:] 
    if j < len(right_half):
        event_counter['swap'] += (len(right_half[j:]))
        A[k:] = right_half[j:] 
    return

#HASH SORT
def hashSort(A, event_counter):
    track_list = []
    j = 0
    for i in range(max(A)+1):
        track_list.append(0)
    for i in range(len(A)):
        track_list[A[i]] += 1
    for i in range(len(track_list)):
        event_counter['compare'] += 1
        while track_list[i] > 0:
            event_counter['compare'] += 1
            event_counter['swap'] += 1
            A[j] = i
            j += 1
            track_list[i] -= 1
    return

#BUBBLE SORT
def bubbleSort(A, event_counter):
    change_made = True
    while change_made:
        change_made = False
        for i in range(len(A)-1):
            x = A[i]
            y = A[i+1]
            event_counter['compare'] += 1
            if x > y:
                event_counter['swap'] += 1
                swapListValues(A, i, i+1)
                change_made = True
    return

#SHAKER SORT
def shakeForward(A, event_counter):
    change_made = False
    max_index = len(A)-1
    for i in range(max_index):
        first_index = i
        second_index = i+1
        x = A[first_index]
        y = A[second_index]
        event_counter['compare'] += 1
        if x > y:
            event_counter['swap'] += 1
            swapListValues(A, first_index, second_index)
            change_made = True
    return change_made
def shakeBackward(A, event_counter):
    change_made = False
    max_index = len(A)-1
    for i in range(max_index):
        first_index = max_index-(i+1)
        second_index = max_index-i
        x = A[first_index]
        y = A[second_index]
        event_counter['compare'] += 1
        if x > y:
            event_counter['swap'] += 1
            swapListValues(A, first_index, second_index)
            change_made = True
    return change_made
def shakerSort(A, event_counter):
    change_made = True
    while change_made:
        change_made = shakeForward(A, event_counter)
        if not change_made:
            return
        change_made = shakeBackward(A, event_counter)
    return


#SELECTION SORT
def indexOfSmallest(A, event_counter, start_index):
    s_value = A[start_index]
    s_index = start_index
    for i in range(start_index,len(A)):
        event_counter['compare'] += 1
        if A[i] < s_value:
            s_value = A[i]
            s_index = i
    return s_index
def selectionSort(A, event_counter):
    for i in range(len(A)):
        s_index = indexOfSmallest(A, event_counter, i)
        event_counter['swap'] += 1
        swapListValues(A, i, s_index)
    return


