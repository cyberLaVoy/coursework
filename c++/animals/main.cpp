
#include"simulation.h"
#include<iostream>
#include <ctime>

int main() {

	int seed = std::time( 0 );
	std::srand( seed );

	Simulation S(25, 25);

	char input_value;
	std::cin >> input_value;	
	while (input_value != 'x') {
		S.step();	
		std::cout << S.textDisplay();
		std::cin >> input_value;	
	}

	return 0;
}
