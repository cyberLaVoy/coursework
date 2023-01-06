#include <ctime>
#include <cstdlib>
#include <iostream>
#include <fstream>
#include <string>
#include "PriorityQueue.h"
#include "Graph.h"


Node* createDataSet(size_t dataSize) {
	Node* S = new Node[dataSize+1];
	S[0].weight = dataSize;
	for ( size_t i = 1; i <= dataSize; i++ ) {
		S[i].label = i;
		S[i].weight = ( std::rand( ) % 100 ) + 1;
	}
	return S;
}

void testMakeHeap() {
	std::cout << "testMakeHeap data" << std::endl;
	std::cout << "size, " << "time" << std::endl;
	int minSize = 5000;
	int maxSize = 9800;
	size_t reps = 10000;
	for (int i = minSize; i <= maxSize; i += 100) {

		PriorityQueue Q;
		Node* S = createDataSet(i);

		clock_t t0 = std::clock();
		for (size_t i = 0; i < reps; i++) {
			Q.makeHeap(S);
		}
		clock_t t1 = std::clock();

		double dt = ((double)(t1 - t0)) / (CLOCKS_PER_SEC*reps);
		std::cout << dt << std::endl;
		delete S;
	}
}

void testDecreaseKey() {
	std::cout << "testDecreaseKey data" << std::endl;
	std::cout << "size, " << "time" << std::endl;
	int minSize = 5000;
	int maxSize = 9800;
	size_t reps = 5000000;
	for (int i = minSize; i <= maxSize; i+=100) {

		PriorityQueue Q;
		Node* S = createDataSet(i);
		Q.makeHeap(S);

		double totalDeltaT = 0;
		for (size_t j = 1; j <= reps; j++) {
			size_t position = (std::rand() % i) + 1;
			Node* x = Q.getNode(position);
			x->weight = (std::rand() % 1000) + 1;

			clock_t t0 = std::clock();
			Q.decreaseKey(x);
			clock_t t1 = std::clock();

			double dt = ((double)(t1 - t0)) / CLOCKS_PER_SEC;
			totalDeltaT += dt;
		}

		double dt = totalDeltaT / (double)reps;
		std::cout << dt << std::endl;

		delete S;
	}
}

void testDeleteMin() {
	std::cout << "testDeleteMin data" << std::endl;
	std::cout << "size, " << "time" << std::endl;
	int minSize = 5000;
	int maxSize = 9800;
	size_t reps = 500;
	for (int i = minSize; i <= maxSize; i+=100) {

		PriorityQueue Q;
		Node* S = createDataSet(i);
		double totalDeltaT = 0;

		for (size_t i = 0; i < reps; i++) {
			Q.makeHeap(S);
			clock_t t0 = std::clock();
			while (!Q.isEmpty()) {
				Q.deleteMin();
			}
			clock_t t1 = std::clock();
			double dt = (double)(t1 - t0) / CLOCKS_PER_SEC;
			totalDeltaT += dt;
		}
		double dt = totalDeltaT / ( i*reps );
		std::cout << dt << std::endl;

		delete S;
	}
}

void testDeleteMinAccuracy() {
	PriorityQueue Q;
	Node* S = createDataSet(100);
	Q.makeHeap(S);
	while (!Q.isEmpty()) {
		Node* minNode = Q.deleteMin();
		std::cout << minNode->weight << std::endl;
	}
	delete S;
}
void testDecreaseKeyAccuracy() {
	PriorityQueue Q;
	Node* S = createDataSet(100);
	Q.makeHeap(S);
	for (int i = 1; i < 30; i++) {
		Node* x = Q.getNode(i);
		std::cout << x->label << std::endl;
		x->weight = 0;
		Q.decreaseKey(x);
		Node* minNode = Q.deleteMin();

		std::cout << "Weight: " << minNode->weight << " Label: " << minNode->label << std::endl;
	}

	delete S;
}

void singleCaseTest() {
	PriorityQueue Q;
	Node* S = new Node[9];
	int weights[9] = {8,5,8,5,18,18,17,19,21};
	for (size_t i = 0; i <= 9; i++) {
		Node x;
		std::cout << weights[i] << std::endl;
		x.weight = weights[i];
		x.label = i;
		S[i] = x;
	}
	Q.makeHeap(S);
	Q.printQueue();
	Q.deleteMin();
	Q.printQueue();
	delete S;
}

int Prim(Graph& G) {
	size_t numberOfVerticies = G.getNumberOfVerticies();
	bool* setS = new bool[numberOfVerticies + 1];
	int* prev = new int[numberOfVerticies + 1];
	int* cost = new int[numberOfVerticies + 1];
	for (size_t i = 0; i <= numberOfVerticies; i++) {
		prev[i] = -1;
		setS[i] = false;
		cost[i] = G.getMaxEdgeWeight() + 1;
	}
	for (size_t i = 1; i <= numberOfVerticies; i++) {
		G.setNodeWeightInV(i, G.getMaxEdgeWeight() + 1);
	}
	G.setNodeWeightInV(1, 0);
	cost[1] = 0;
	Node* S = G.getVerticies();
	PriorityQueue Q;
	Q.makeHeap(S);
	while (!Q.isEmpty()) {
		Node* u = Q.deleteMin();
		size_t uLabel = u->label;
		setS[uLabel] = true;
		std::vector<Edge> edgeList = G.getEdgeList(uLabel);
		for (size_t i = 0; i < edgeList.size(); i++) {
			size_t vLabel = edgeList[i].to;
			int vWeight = Q.getNodeWeight(vLabel);
			int edgeWeight = edgeList[i].weight;
			bool inSet = setS[vLabel];
			if (!inSet && vWeight > edgeWeight) {
				Q.setNodeWeight(vLabel, edgeWeight);
				cost[vLabel] = edgeWeight;
				prev[vLabel] = uLabel;
			}
		}
	}
	// final weight output
	int MSTcost = 0;
	for (size_t i = 1; i <= numberOfVerticies; i++) {
		MSTcost += cost[i];
	}
	return MSTcost;
}

void testPrim() {
	std::string graphSizes[11] = {"10", "100", "1000", "10000", "20000", "40000", "80000", "100000", "200000", "400000", "800000"};
	std::string graphNum[4] = {"1", "2", "3", "4"};
	size_t repsArray[11] = {10000, 1000, 100, 10, 5, 2, 1, 1, 1, 1, 1};
	Graph G;
	std::ifstream fin;
	size_t numGraphs = 4;
	
	std::string fileName;
	for (size_t i = 0; i < 11; i++) {
		double totalDeltaT = 0;
		size_t reps = repsArray[i];
		for (size_t j = 0; j < numGraphs; j++) {
			fileName = "C:\\graphs\\graph-" + graphSizes[i] + "-" + graphNum[j] + ".txt";
			fin.open(fileName);
			fin >> G;
			fin.close();

			clock_t t0 = std::clock();
			for (size_t i = 0; i < reps; i++) {
				Prim(G);
			}
			clock_t t1 = std::clock();
			double dt = ((double)(t1 - t0)) / (CLOCKS_PER_SEC);
			totalDeltaT += dt;
		}
		double dt = totalDeltaT / ((double)numGraphs*(double)reps);
		std::cout << dt << std::endl;
	}
}

void printMSTcosts() {
	std::string graphSizes[11] = {"10", "100", "1000", "10000", "20000", "40000", "80000", "100000", "200000", "400000", "800000"};
	std::string graphNum[4] = {"1", "2", "3", "4"};
	std::ifstream fin;
	size_t numGraphs = 4;
	std::string fileName;
	std::string path;
	int cost = 0;
	for (size_t i = 0; i < 11; i++) {
		for (size_t j = 0; j < numGraphs; j++) {
			Graph G;
			fileName = "graph-" + graphSizes[i] + "-" + graphNum[j] + ".txt";
			path = "C:\\graphs\\" + fileName;
			fin.open(path);
			fin >> G;
			fin.close();
			cost = Prim(G);
			std::cout << "File name: " << fileName << " Cost: " << cost << std::endl;
		}
	}
}
	
int main() {
	int seed = std::time( 0 );
	std::srand( seed );
	
	//singleCaseTest();
	//testDecreaseKeyAccuracy();
	//testDeleteMinAccuracy();
	//testDecreaseKey();
	//testMakeHeap();
	//testDeleteMin();
	//testPrim();
	printMSTcosts();

	return 0;
}