
#include "graph.h"
#include <ctime>
#include <cstdlib>

std::istream& operator>>(std::istream& input_stream, Graph& graph_object) {

	int first_vertex;
	int second_vertex;
	double weight;
	double min_weight;
	double max_weight;
	int total_vertices;

	input_stream >> total_vertices;
	graph_object.setGraphSize(total_vertices);

	input_stream >> first_vertex;
	input_stream >> second_vertex;
	input_stream >> weight;
	graph_object.setWeight(first_vertex, second_vertex, weight);

	min_weight = weight;
	max_weight = weight;

	while (input_stream) {
		input_stream >> first_vertex;
		input_stream >> second_vertex;
		input_stream >> weight;
		graph_object.setWeight(first_vertex, second_vertex, weight);
		
		if (weight < min_weight) {
			min_weight = weight;
			graph_object.setMinPossibleWeight(min_weight);
		}
		if (weight > max_weight) {
			max_weight = weight;
			graph_object.setMaxPossibleWeight(max_weight);
		}
	}
	return input_stream;
}

/*Constructor and Destructor*/
Graph::Graph() : mMinPossibleWeight(0), mMaxPossibleWeight(0), mTotalVertices(0) {
	int seed = std::time( 0 );
	std::srand( seed );
}
Graph::~Graph() {
}

/*Get Methods*/
std::vector< std::vector<double> > Graph::getGraph() const {
	return mGraph;
}
double Graph::getMinPossibleWeight() const {
	return mMinPossibleWeight;
}
double Graph::getMaxPossibleWeight() const {
	return mMaxPossibleWeight;
}
int Graph::getTotalVertices() const {
	return mTotalVertices;
}

std::vector<int> Graph::getTrivialCycle() {
	std::vector<int> trivial_cycle;
	for (int i = 1; i <= getTotalVertices(); i++) {
		trivial_cycle.push_back(i);
	}
	return trivial_cycle;
}

std::vector<int> Graph::getRandomCycle() {
	std::vector<int> random_cycle = getTrivialCycle();
	int vector_size = random_cycle.size();

	for (int i = 0; i < 3; i ++) {
		for (int i = 1; i < vector_size; i++) {
			int r = std::rand( );
			r = r % (vector_size-1);
			r = r + 1;
			int temp = random_cycle[i];
			random_cycle[i] = random_cycle[r];
			random_cycle[r] = temp;
		}
	}
	return random_cycle;
}

std::vector<int> Graph::getRandomNeighborCycle(std::vector<int> cycle) {
	int r1 = 0;	
	int r2 = 0;
	while ( r1 == r2 ) {
		r1 = std::rand( );
		r1 = r1 % (cycle.size()-1);
		r1 = r1 + 1;

		r2 = std::rand( );
		r2 = r2 % (cycle.size()-1);
		r2 = r2 + 1;
	}

	int temp = cycle[r1];
	cycle[r1] = cycle[r2];
	cycle[r2] = temp;

	return cycle;
}
			
std::vector<int> Graph::getQualityCycle() {
	// hill climbing
	std::vector<int> best_cycle;
	double best_quality = 0;

	std::vector<int> current_cycle = getRandomCycle();
	double current_quality = getCycleQuality( current_cycle );

	while (current_quality > best_quality ) {
		best_cycle = current_cycle;
		best_quality = current_quality;

		int neighbor_attempts = 0;
		while ( neighbor_attempts < getTotalVertices()) {
			std::vector<int> temporary_cycle = getRandomNeighborCycle( best_cycle );
			double temporary_quality = getCycleQuality( temporary_cycle );

			if ( temporary_quality > current_quality ) {
				current_cycle = temporary_cycle;
				current_quality = temporary_quality;
				neighbor_attempts = getTotalVertices();
			}
			neighbor_attempts++;
		}
	}
	return best_cycle;	
}

std::vector<int> Graph::getBadCycle() {
	// hill sliding
	std::vector<int> best_cycle;
	double best_quality = 10;

	std::vector<int> current_cycle = getRandomCycle();
	double current_quality = getCycleQuality( current_cycle );

	while (current_quality < best_quality ) {
		best_cycle = current_cycle;
		best_quality = current_quality;

		int neighbor_attempts = 0;
		while ( neighbor_attempts < getTotalVertices()) {
			std::vector<int> temporary_cycle = getRandomNeighborCycle( best_cycle );
			double temporary_quality = getCycleQuality( temporary_cycle );

			if ( temporary_quality < current_quality ) {
				current_cycle = temporary_cycle;
				current_quality = temporary_quality;
				neighbor_attempts = getTotalVertices();
			}
			neighbor_attempts++;
		}
	}
	return best_cycle;	
}

double Graph::getEdgeWeight(int first_vertex, int second_vertex) {
	double edge_weight;
	edge_weight = mGraph[first_vertex - 1][second_vertex - 1];
	return edge_weight;
}
double Graph::getCycleWeight(const std::vector<int> cycle) {
	double edge_weight;
	double cycle_weight = 0;
	for (size_t i = 0; i < cycle.size() - 1; i++) {
		edge_weight = getEdgeWeight(cycle[i], cycle[i+1]);
		cycle_weight += edge_weight;
	}
	double return_weight = getEdgeWeight(cycle[cycle.size() -1], cycle[0]);
	cycle_weight += return_weight;	
	return cycle_weight;
}
double Graph::getCycleQuality(const std::vector<int> cycle) {
	double cycle_quality;
	cycle_quality = 1 - (getCycleWeight(cycle) - getMinPossibleWeight()) / (getMaxPossibleWeight() - getMinPossibleWeight());
	return cycle_quality;
}

/*Set Methods*/
void Graph::setGraphSize(const int graph_size) {
	setTotalVertices(graph_size);
	for (int i = 0; i < graph_size; i++) {
		std::vector<double> empty_vector;
		for (int i = 0; i < graph_size; i++) {
			empty_vector.push_back(0);
		}
		mGraph.push_back(empty_vector);
	}
}
void Graph::setWeight(int first_vertex, int second_vertex, const double weight) {
	mGraph[first_vertex - 1][second_vertex - 1] = weight;
}
void Graph::setMinPossibleWeight(const double weight) {
	mMinPossibleWeight = weight * getTotalVertices();
}
void Graph::setMaxPossibleWeight(const double weight) {
	mMaxPossibleWeight = weight * getTotalVertices();
}
void Graph::setTotalVertices(const int total_vertices) {
	mTotalVertices = total_vertices;
}

/*Other Methods*/
void Graph::printCycleInfo(std::ostream& output_stream, const std::vector<int> cycle) {
	for (size_t i = 0; i < cycle.size(); i++) {
		output_stream << cycle[i];
		output_stream << " ";
	}	
	output_stream << getCycleWeight(cycle);
	output_stream << " ";
	output_stream << getCycleQuality(cycle);
	output_stream << "\n";
}


/*data members
std::vector< std::vector<double> > mGraph;	
double mMinPossibleWeight;
double mMaxPossibleWeight;
int mTotalVertices;
*/

