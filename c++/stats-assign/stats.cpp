#include <iostream>
#include <vector>
#include <cstring>
#include <algorithm>
#include "stats.h"

std::vector< double > getInput( std::istream& input_stream ) 
{
	std::vector< double > numbers;
	double value;
	input_stream >> value;
	while(input_stream) {
		numbers.push_back(value);
		input_stream >> value;
	}
	return numbers;
}
size_t calculateCount( const std::vector< double >& numbers )
{
	size_t count = numbers.size();
	return count;
}
double calculateProduct( const std::vector< double >& numbers ) {
	double product = 1;
	for (size_t i = 0; i < numbers.size(); i++) {
		product *= numbers[i];	
	}
	return product;
}
double calculateSum( const std::vector< double >& numbers ) 
{
	double sum = 0;
	size_t vector_size = calculateCount(numbers);
	for (size_t i = 0; i < vector_size; i++) {
		sum += numbers[i];
	}
	return sum;
}
double calculateAverage( const std::vector< double >& numbers )
{
	size_t vector_size = calculateCount(numbers);
	if (vector_size == 0) {
		return 0;
	}
	double average = calculateSum(numbers)/vector_size;
	return average;
}
double calculateMedian( const std::vector< double >& numbers )
{
	size_t vector_size = calculateCount(numbers);
	if (vector_size == 0) {
		return 0;
	}

	double median;
	std::vector< double > sorted_numbers = numbers;
	std::sort(sorted_numbers.begin(), sorted_numbers.end());
	if (vector_size % 2 == 1) {
		median = sorted_numbers[(vector_size-1)/2]; 	
	}
	else {
		double total_mid = 0;
		total_mid += sorted_numbers[vector_size/2];
		total_mid += sorted_numbers[(vector_size/2) - 1];
		median = total_mid/2;
	}
	return median;
}
double calculateMinimum( const std::vector< double >& numbers )
{
	size_t vector_size = calculateCount(numbers);
	if (vector_size == 0) {
		return 0;
	}
	double min_value = numbers[0];
	for (size_t i = 0; i < vector_size; i++) {
		if (numbers[i] < min_value) {
			min_value = numbers[i];
		}
	}
	return min_value;
}
double calculateMaximum( const std::vector< double >& numbers )
{
	size_t vector_size = calculateCount(numbers);
	if (vector_size == 0) {
		return 0;
	}
	double max_value = numbers[0];
	for (size_t i = 0; i < vector_size; i++) {
		if (numbers[i] > max_value) {
			max_value = numbers[i];
		}
	}
	return max_value;
}

