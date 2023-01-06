class Stack:
    def __init__(self):
        self.A = []
    def push(self, item):
        self.A.append(item)
    def pop(self):
        return self.A.pop()
    def top(self):
        return self.A[-1]
    def isEmpty(self):
        return len(self.A) == 0

class Queue:
    def __init(self):
        #link list
        pass
    def enqueue():
        pass
    def dequeue():
        pass
    def front():
        pass
    def isEmpty():
        pass


class unsortedUniqueContainer:
    def size(self):
    def insert(self, item):
    #return bool
    def delete(self, dummyItem):
    #return bool
    def retrieve(self, dummyItem):
    #return item or void
    def traverse(self):
    def exists(self, dummyItem):
    #return bool



class Node:
    def __init__(self, item, nxt):
        self.mItem = item
        self.mNext = nxt
class LinkedList:
    def __init__(self):
        self.mFirst = None
        self.mSize = 0
    def size(self):
        return self.mSize
    def exists(self, dummyItem):
        exists = False
        current = self.mFirst
        while current is not None:
            if current.mItem == dummyItem:
                exists = True
                break
            current = current.mNext
        return exists

    def insert(self, item):
        inserted = False
        if not self.exists(item):
            n = Node(item, self.mFirst)
            self.mFirst = n
            self.mSize += 1
            inserted = True
        return inserted
    def retrieve(self, dummyItem):
        retrieved_item = None
        current = self.mFirst
        while current is not None:
            if current.mItem == dummyItem:
                retrieved_item = current.mItem
                break
            current = current.mNext
        return retrieved_item



class Node:
    def __init__(self, item):
        self.mItem = item
        self.mLeft = None
        self.mRight = None
class BST:
    def Insert(self, item):
        if self.Exists(item):
            return False
        self.mRoot = self.InsertR(item, self.mRoot)
        return True
    def InsertR(self, item, current):
        if current is None:
            current = Node(item)
        elif item < current.item:
            current.mLeft = self.InsertR(item, current.mLeft)
        else:
            current.mRight = self.InsertR(item, current.mRight)
        return current


    def Delete(self, item):
        if not self.Exists(item):
            return False
        self.mRoot = self.DeleteR(item, self.mRoot)
        return True
    def DeleteR(self, item, current):
        if item < current.item:
            current.mLeft = self.DeleteR(item, current.mLeft)
        elif item > current.item:
            current.mRight = self.DeleteR(item, currnet.mRight)
        else:
            #item found (delete node current points to)
            if current.mLeft is None and current.mRight is None:
                #no child case
                current = None
            elif current.mLeft is None and current.mRight is not None:
                #one child case
                current = current.mRight
            elif current.mRight is None and current.mLeft is not None:
                #one child case
                current = current.mLeft
            else:
                #two child case
                successor = current.mRight
                while successor.mLeft is not None:
                    successor = successor.mLeft
                current.mItem = successor.mItem
                current.mRight = self.DeleteR(successor.mItem, current.mRight)
        return current

"""
Delete:

3 cases
1. no children
2. 1 child
3. 2 child (find in-order successor: one to the right, as far left as possible)
"""
         



#Hash table
class HashTable:
    def __init__(self, expected_size):
        size = expected_size*2 + 1
        while not IsPrime(size):
            size += 2
        self.mTable = [None]*size

    def exists(self, item):
        index = int(item) % len(self.mTable)
        while True:
            if self.mTable[index] is None:
                return False
            if self.mTable[index] and self.mTable[index] == item:
                return True
            index += 1
            if index >= len(self.mTable):
                index=0

    def insert(self, item):
        #make sure handels False slot case
        pass
    def retrieve(self, item):
        #make sure handels False slot case
        pass
