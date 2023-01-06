#include "PPM.h"
#include<fstream>

int main() {

	PPM Aerial;
	std::string file_name = "ppm-images/Aerial.ppm";
	std::ifstream fin(file_name, std::ios::binary);
	fin >> Aerial;
	fin.close();

	std::cout << Aerial;

	return 0;
}
