#ifndef GRAPH_H
#define GRAPH_H

#include <iostream>
#include <vector>

class Graph {
public:
	/*Constructor and Destructor*/
	Graph();
	~Graph();

	/*Get Methods*/
	std::vector< std::vector<double> > getGraph() const;
	double getMinPossibleWeight() const;
	double getMaxPossibleWeight() const;
	int getTotalVertices() const;

	std::vector<int> getTrivialCycle();
	std::vector<int> getRandomCycle();
	std::vector<int> getRandomNeighborCycle(std::vector<int> cycle);
	std::vector<int> getQualityCycle();
	std::vector<int> getBadCycle();

	double getEdgeWeight(int first_vertex, int second_vertex); 
	double getCycleWeight(const std::vector<int> cycle);
	double getCycleQuality(const std::vector<int> cycle);
	
	/*Set Methods*/
	void setGraphSize(const int graph_size);
	void setWeight(int first_vertex, int second_vertex, const double weight);
	void setMinPossibleWeight(const double weight);
	void setMaxPossibleWeight(const double weight);
	void setTotalVertices(const int total_vertices);
	
	/*Other Methods*/
	void printCycleInfo(std::ostream& output_stream, const std::vector<int> cycle);

protected:
	/*data members*/
	std::vector< std::vector<double> > mGraph;	
	double mMinPossibleWeight;
	double mMaxPossibleWeight;
	int mTotalVertices;
};

std::istream& operator>>(std::istream& input_stream, Graph& graph_object);

#endif

