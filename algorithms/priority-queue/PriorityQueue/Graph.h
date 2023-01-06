#pragma once
#include <iostream>
#include <vector>
#include "Node.h"

struct Edge {
	size_t to;
	size_t from;
	int weight;
};
class Graph
{
public:
	Graph();
	~Graph();
	void initV(size_t size);
	bool setNodeWeightInV(size_t label, int weight);
	void initE(size_t size);
	bool addEdge(Edge e, size_t vLabel);

	Node* getVerticies();
	std::vector< std::vector<Edge> > getEdges();
	std::vector<Edge> getEdgeList(size_t vLabel);
	size_t getNumberOfVerticies();
	int getMaxEdgeWeight();
	void setMaxEdgeWeight(int weight);
private:
	Node* mV = 0;
	std::vector< std::vector<Edge> > mE;
	size_t mNumberOfVerticies;
	int mMaxEdgeWeight;
};

std::istream& operator>>(std::istream& input_stream, Graph& G);

