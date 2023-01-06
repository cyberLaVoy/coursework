#include "DIP.h"
#include<iostream>

int main() {
	std::cout << "Conversions available." << std::endl;
	std::cout << "C) Copy directly." << std::endl;
	std::cout << "r) Grayscale from red." << std::endl;
	std::cout << "g) Grayscale from green." << std::endl;
	std::cout << "b) Grayscale from blue." << std::endl;
	std::cout << "l) Grayscale from linear colorimetric." << std::endl;
	std::cout << "Choice? ";

	char user_choice;
	std::cin >> user_choice;

	std::cout << "Input filename? ";
	std::string ifilename;
	std::cin >> ifilename;

	std::cout << "output filename? ";
	std::string ofilename;
	std::cin >> ofilename;

	PPM ppm_object;

	if (user_choice == 'C') {
		directCopy(ppm_object, ifilename, ofilename);
	}
	if (user_choice == 'r') {
		grayscaleRed(ppm_object, ifilename, ofilename);
	}
	if (user_choice == 'g') {
		grayscaleGreen(ppm_object, ifilename, ofilename);
	}
	if (user_choice == 'b') {
		grayscaleBlue(ppm_object, ifilename, ofilename);
	}
	if (user_choice == 'l') {
		linearColor(ppm_object, ifilename, ofilename);
	}
	return 0;
}
