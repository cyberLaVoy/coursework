from graph import Graph


def getFileLines(file_name):
    file_lines = []
    fin = open(file_name, "r")
    for line in fin:
        file_lines.append(line.strip())
    return file_lines


def createGraph(num_vertices, edges):
    g = Graph(num_vertices)
    
    for edge in edges:
        edge = edge.split()
        v1 = int(edge[0])
        v2 = int(edge[1])
        g.addEdge(v1, v2)

    return g

def runTests(graph, tests):
    for test in tests:
        print("***************************")

        print("Test:", test)
        test = test.split()
        v1 = int(test[0])
        v2 = int(test[1])
        depth_path = graph.findPathDepth(v1, v2)
        print("Depth path:", depth_path)
        breadth_path = graph.findPathBreadth(v1, v2)
        print("Breadth path:", breadth_path)


def main():
    file_lines = getFileLines("graph.txt")

    num_vertices = int(file_lines[0])
    num_edges = int(file_lines[1])
    edges = file_lines[2:2+num_edges]
    g = createGraph(num_vertices, edges)
    
    num_tests = int(file_lines[2+num_edges])
    tests_start = 2+num_edges +1
    tests = file_lines[tests_start: tests_start + num_tests] 
    runTests(g,tests) 

main()
