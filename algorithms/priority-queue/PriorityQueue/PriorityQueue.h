#pragma once
#include "Node.h"
class PriorityQueue
{
public:
	PriorityQueue();
	~PriorityQueue();

	void insert(Node x);
	void decreaseKey(Node* x);
	Node* deleteMin();
	Node* makeHeap(Node* S);
	void siftDown(Node x, size_t i);
	void bubbleUp(Node x, size_t i);
	size_t minChild(size_t i);
	bool isEmpty();
	void printQueue();
	Node* getNode(size_t i);
	int getNodeWeight(size_t nodeLabel);
	void setNodeWeight(size_t nodeLabel, int weight);

private:
	Node* mH = 0;
	size_t* mLocations = 0;
};

