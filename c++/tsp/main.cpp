
#include <iostream>
#include "graph.h"

int main() {

	Graph city_graph;
	std::cin >> city_graph;

	double cycle_quality = 1;	
	std::vector<int> quality_cycle;
	while (cycle_quality > .45) {
		quality_cycle = city_graph.getBadCycle();
		cycle_quality = city_graph.getCycleQuality(quality_cycle);
	}

	city_graph.printCycleInfo(std::cout, quality_cycle);

	return 0;
}
