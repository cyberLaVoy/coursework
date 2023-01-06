
class Node:
    def __init__(self, item):
        self.mItem = item
        self.mLeft = None
        self.mRight = None
class BST:
    def __init__(self):
        self.mRoot = None

    def trueCount(self):
        return self.trueCountR(self.mRoot)
    def trueCountR(self, current):
        if current is None:
            return 0
        count = 1
        count += self.trueCountR(current.mRight)
        count += self.trueCountR(current.mLeft)
        return count

    def exists(self, dummyItem):
        return self.existsR(dummyItem, self.mRoot)
    def existsR(self, dummyItem, current):
        if current is None:
            return False
        if current.mItem == dummyItem:
            return True
        if dummyItem < current.mItem:
            return self.existsR(dummyItem, current.mLeft)
        else:
            return self.existsR(dummyItem, current.mRight)

    def retrieve(self, item):
        return self.retrieveR(item, self.mRoot)
    def retrieveR(self, item, current):
        if not self.exists(item):
            return None
        if current.mItem == item:
            return current.mItem
        elif item < current.mItem:
            return self.retrieveR(item, current.mLeft)
        else:
            return self.retrieveR(item, current.mRight)

    def traverse(self, callback):
        self.traverseR(self.mRoot, callback)
    def traverseR(self, current, callback):
        if current:
            self.traverseR(current.mLeft, callback)
            callback(current.mItem)
            self.traverseR(current.mRight, callback)


    def insert(self, item):
        if self.exists(item):
            return False
        self.mRoot = self.insertR(item, self.mRoot)
        return True
    def insertR(self, item, current):
        if current is None:
            current = Node(item)
        elif item < current.mItem:
            current.mLeft = self.insertR(item, current.mLeft)
        else:
            current.mRight = self.insertR(item, current.mRight)
        return current


    def delete(self, item):
        if not self.exists(item):
            return False
        self.mRoot = self.deleteR(item, self.mRoot)
        return True
    def deleteR(self, item, current):
        if item < current.mItem:
            current.mLeft = self.deleteR(item, current.mLeft)
        elif item > current.mItem:
            current.mRight = self.deleteR(item, current.mRight)
        else:
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
                current.mRight = self.deleteR(successor.mItem, current.mRight)
        return current

