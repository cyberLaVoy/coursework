
#include <iostream>
#include <algorithm>
#include "PriorityQueue.h"

PriorityQueue::PriorityQueue()
{
}

PriorityQueue::~PriorityQueue()
{
	delete mH;
}

void PriorityQueue::insert(Node x)
{
	size_t queueSize = mH[0].weight;
	bubbleUp(x, queueSize + 1);
}

void PriorityQueue::decreaseKey(Node* x)
{
	bubbleUp(*x, mLocations[x->label]);
}

Node* PriorityQueue::deleteMin()
{
	size_t queueSize = mH[0].weight;
	if (queueSize == 0) {
		return 0;
	}
	else {
		Node x = mH[1];
		siftDown(mH[queueSize], 1);
		mH[0].weight -= 1;
		return &x;
	}
}

Node* PriorityQueue::makeHeap(Node* S)
{
	size_t size = S[0].weight;
	if (mH != 0) {
		delete mH;
	}
	mH = new Node[size+1];
	mH[0].weight = size;

	if (mLocations != 0) {
		delete mLocations;
	}
	mLocations = new size_t[size+1];
	mLocations[0] = 0;

	for (size_t i = 1; i <= size; i++) {
		mH[i] = S[i];
	}
	for (size_t i = size; i > 0; i--) {
		siftDown(mH[i], i);
	}
	return mH;
}

void PriorityQueue::siftDown(Node x, size_t i)
{
	size_t c = minChild(i);
	while (c != 0 && mH[c].weight < x.weight) {
		Node temp = mH[i];
		mH[i] = mH[c]; 
		mLocations[mH[i].label] = i;
		mH[c] = temp;
		mLocations[mH[c].label] = c;
		i = c;
		c = minChild(i);
	}
	mH[i] = x;
	mLocations[mH[i].label] = i;
}

void PriorityQueue::bubbleUp(Node x, size_t i)
{
	size_t p = i >> 1; //index of parent node
	while (i != 1 && mH[p].weight > x.weight) {
		Node temp = mH[i];
		mH[i] = mH[p];
		mLocations[mH[i].label] = i;
		mH[p] = temp;
		mLocations[mH[p].label] = p;
		i = p;
		p = i >> 1; //index of parent node
	}
	mH[i] = x;
	mLocations[mH[i].label] = i;
}

size_t PriorityQueue::minChild(size_t i)
{
	size_t queueSize = mH[0].weight;
	if (2*i > queueSize) {
		return 0;
	}
	else {
		size_t firstIndex = 2*i;
		Node firstChild = mH[firstIndex];
		size_t a = 2 * i + 1;
		size_t secondIndex = ( queueSize < a ? queueSize : a );
		Node secondChild = mH[secondIndex];
		return firstChild.weight < secondChild.weight ? firstIndex : secondIndex;
	}
}

bool PriorityQueue::isEmpty()
{
	if (mH[0].weight != 0) {
		return false;
	}
	return true;
}

void PriorityQueue::printQueue()
{
	for (size_t i = 0; i <= mH[0].weight; i++) {
		std::cout << "Label " << mH[i].label << " Position " << mLocations[mH[i].label] << " Weight "<< mH[i].weight << std::endl;
	}
}

Node * PriorityQueue::getNode(size_t i)
{
	return &mH[i];
}

int PriorityQueue::getNodeWeight(size_t nodeLabel)
{
	return mH[ mLocations[nodeLabel] ].weight;
}

void PriorityQueue::setNodeWeight(size_t nodeLabel, int weight)
{
	Node* n = &mH[mLocations[nodeLabel]];
	n->weight = weight;
	decreaseKey(n);
}
