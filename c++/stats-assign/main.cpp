#include <iostream>
#include <vector>
#include "stats.h"

int main() 
{
	std::vector< double > numbers = getInput(std::cin);
	size_t count = calculateCount(numbers);
	double sum = calculateSum(numbers);
	double average = calculateAverage(numbers);
	double median = calculateMedian(numbers);
	double min = calculateMinimum(numbers);
	double max = calculateMaximum(numbers);
	double product = calculateProduct(numbers);
	std::cout << "Count: " << count << std::endl;
	std::cout << "Summation: " << sum << std::endl;
	std::cout << "Product: " << product << std::endl;
	std::cout << "Average: " << average << std::endl;
	std::cout << "Median: " << median << std::endl;
	std::cout << "Minimum: " << min << std::endl;
	std::cout << "Maximum: " << max << std::endl;
	return 0;
}
