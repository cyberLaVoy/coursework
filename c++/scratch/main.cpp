
#include <iostream>
#include <cmath>
#include <map>
#include <string>
#include <vector>
#include <algorithm>

int main() {
	int a = 4;	
	int b = 5;	
	int c = sqrt(4);
	int d = sqrt(5);
	c *= c;
	d *= d;
	
	std::cout << sqrt(a) << std::endl;
	std::cout << (a == c) << std::endl;
	std::cout << sqrt(b) << std::endl;
	std::cout << (b == d) << std::endl;
	return 0;
}

