#include "Graph.h"

Graph::Graph()
{
}

Graph::~Graph()
{
	if (mV != 0) {
		delete mV;
	}
}

void Graph::initV(size_t size)
{
	mNumberOfVerticies = size;
	if (mV == 0) {
		delete mV;
	}
	mV = new Node[size + 1];
	mV[0].weight = size;
	mV[0].label = 0;
	for (size_t i = 1; i <= size; i++) {
		mV[i].label = i;
		mV[i].weight = 0;
	}
}

bool Graph::setNodeWeightInV(size_t label, int weight)
{
	if (label <= (size_t)mV[0].weight) {
		mV[label].weight = weight;
		return true;
	}
	return false;
}

void Graph::initE(size_t size)
{
	if (mE.size() > 0) {
		mE.clear();
	}
	for (size_t i = 0; i < size; i++) {
		std::vector<Edge> edgeList;
		mE.push_back(edgeList);
	}
}

bool Graph::addEdge(Edge e, size_t vLabel)
{
	vLabel--;
	if (vLabel < mE.size()) {
		mE[vLabel].push_back(e);
	}
	return false;
}

Node* Graph::getVerticies()
{
	return mV;
}

std::vector<std::vector<Edge>> Graph::getEdges()
{
	return mE;
}

std::vector<Edge> Graph::getEdgeList(size_t vLabel)
{
	vLabel--;
	return mE[vLabel];
}

size_t Graph::getNumberOfVerticies()
{
	return mNumberOfVerticies;
}

int Graph::getMaxEdgeWeight()
{
	return mMaxEdgeWeight;
}

void Graph::setMaxEdgeWeight(int weight)
{
	mMaxEdgeWeight = weight;
}

std::istream & operator>>(std::istream & inputStream, Graph& G)
{
	size_t size;
	inputStream >> size;
	int maxWeight = -1;
	size_t from;
	size_t to;
	int weight;
	G.initE(size);
	while (inputStream) {
		inputStream >> from;
		inputStream >> to;
		inputStream >> weight;
		if (weight > maxWeight) {
			maxWeight = weight;
		}
		Edge e;
		e.from = from;
		e.to = to;
		e.weight = weight;
		G.addEdge(e, from);
		e.from = to;
		e.to = from;
		e.weight = weight;
		G.addEdge(e, to);
	}
	G.initV(size);
	G.setMaxEdgeWeight(maxWeight);

	return inputStream;
}
