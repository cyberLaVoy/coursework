        
def isPrime(value):
    is_prime = True
    if value > 1:
        for i in range(2, value):
            if value % i == 0:
                is_prime = False
                break
    return is_prime

class HashTable:
    def __init__(self, expected_size):
        size = expected_size*2 + 1
        while not isPrime(size):
            size += 2
        self.mTable = [None]*size

    def trueCount(self):
        count = 0
        for i in range(len(self.mTable)):
            if self.mTable[i]:
                count += 1
        return count

    def exists(self, item):
        index = int(item) % len(self.mTable)
        while True:
            if self.mTable[index] is None:
                return False
            if self.mTable[index]:
                if self.mTable[index] == item:
                    return True
            index += 1
            if index >= len(self.mTable):
                index=0

    def traverse(self, callback):
        for i in range(len(self.mTable)):
            if self.mTable[i]:
                callback(self.mTable[i])

    def insert(self, item):
        if self.exists(item):
            return False
        key = int(item)
        index = key%len(self.mTable)
        while self.mTable[index] is not None:
            index += 1
            if index >= len(self.mTable):
                index = 0
        self.mTable[index] = item
        return True

    def retrieve(self, item):
        if not self.exists(item):
            return None
        key = int(item)
        index = key%len(self.mTable)

        retrieved_item = None
        while True:
            if self.mTable[index]:
                if self.mTable[index] == item:
                    retrieved_item = self.mTable[index]
                    break
            index += 1
            if index >= len(self.mTable):
                index = 0
        return retrieved_item

    def delete(self, item):
        if not self.exists(item):
            return False
        key = int(item)
        index = key%len(self.mTable)
        while True:
            if self.mTable[index]:
                if self.mTable[index] == item:
                    self.mTable[index] = False
                    break
            index += 1
            if index >= len(self.mTable):
                index = 0

        return True




