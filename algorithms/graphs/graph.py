from collections import deque
#q = deque()
#enque... q.append(item)
#deque... item = q.popleft()

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

# Adjacency List
class Graph:
    def __init__(self, num_vertices):
        self.mNumVertices = num_vertices
        self.mEdges = []
        for i in range(num_vertices):
            self.mEdges.append( [] )

    def edgeExists(self, v1, v2):
        exists = False
        if v2 in self.mEdges[v1]:
            exists = True
        return exists

    def addEdge(self, v1, v2):
        self.mEdges[v1].append(v2)

    def findNeighbors(self, vertex):
        return self.mEdges[vertex]


    def findPathDepth(self, v1, v2):
        path = None
        stack = Stack()
        visited = [False] * self.mNumVertices

        stack.push(v1)
        visited[v1] = True

        while not stack.isEmpty():
            current = stack.top()
            if current == v2:
                path = []
                while not stack.isEmpty():
                    path.append(stack.pop())
                path.reverse()
                break

            neighbors = self.findNeighbors(current)
            neighbor = -1
            for i in range(len(neighbors)):
                if not visited[neighbors[i]]:
                    neighbor = neighbors[i]
                    break

            if neighbor == -1:
                stack.pop()
            else:
                stack.push(neighbor)
                visited[neighbor] = True

        return path


    def findPathBreadth(self, v1, v2):
        path = None
        from_field = [-1] * self.mNumVertices
        queue = deque()

        queue.append(v1)
        from_field[v1] = v1

        while len(queue) != 0:
            current = queue.popleft()

            if current == v2:
                path = []
                path.append(v2)

                current_vertex = v2
                next_vertex = from_field[v2]
                while current_vertex != next_vertex:
                    next_vertex = from_field[current_vertex]
                    path.append(next_vertex)

                    current_vertex = next_vertex
                    next_vertex = from_field[current_vertex]

                path.reverse()
                break

            #enque all unvisted neghbors of current, indicating they came from current
            neighbors = self.findNeighbors(current)
            for i in range(len(neighbors)):
                if from_field[neighbors[i]] == -1:
                    queue.append(neighbors[i])
                    from_field[neighbors[i]] = current
        return path

# possible graph implementations:
# matix, adjacency list, or edge list

