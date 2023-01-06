#include <vector>
#include <iostream>
#include <cmath>
#include <cstdlib>
#include <ctime>

//find the index of value in data
size_t binary_searchR( const std::vector< int >& data, size_t left_index, size_t right_index, int value) {
	size_t middle = left_index + (size_t)((right_index - left_index)/2);
	int check_value = data[middle];	
	if (check_value == value) {
		return middle;
	}
	else if (value < check_value) {
		return binary_searchR(data, left_index, middle-1, value);
	}
	else if (value > check_value) {
		return binary_searchR(data, middle+1, right_index, value);
	}
	else {
		return -1;
	}
}
size_t binary_search( const std::vector< int >& data, int value) {
	return binary_searchR(data, 0, data.size()-1, value);
}

//find the index of value in data
size_t trinary_searchR( const std::vector< int >& data, size_t left_index, size_t right_index, int value ) {
	size_t left_middle = left_index + (size_t)((right_index - left_index)*1/3);
	size_t right_middle = left_index + (size_t)((right_index - left_index)*2/3);
	if (value == data[left_middle]) {
		return left_middle;
	}
	else if (value == data[right_middle]) {
		return right_middle;
	}

	else if (value < data[left_middle] ) {
		return trinary_searchR(data, left_index, left_middle-1, value);
	}
	else if (value > data[left_middle] && value < data[right_middle]) {
		return trinary_searchR(data, left_middle+1, right_middle-1, value);
	}
	else if (value > data[right_middle] ) {
		return trinary_searchR(data, right_middle+1, right_index, value);
	}
	else {
		return -1;
	}
}
size_t trinary_search( const std::vector< int >& data, int value ) {

	return trinary_searchR(data, 0, data.size()-1, value);
}

std::vector<int> generateAscList(int start, int end) {
	std::vector<int> ascList;
	for (int i = start; i <= end; i++) {
		ascList.push_back(i);	
	}	
	return ascList;
}

void checkCorrectness() {
	std::vector<int> ascList = generateAscList(-127, 321);
	for ( size_t i = 0; i < ascList.size(); i++ ) {
		if ( binary_search(ascList, ascList[i]) != i ) {
			std::cout <<  binary_search(ascList, ascList[i])<< " should equal " << i << std::endl;
		}
		if ( trinary_search(ascList, ascList[i]) != i ) {
			std::cout << trinary_search(ascList, ascList[i]) << " should equal " << i << std::endl;
		}
	}
	std::cout << "Complete." << std::endl;
}

void runTime() {
        std::cout << "Trinary Search" << std::endl;
        std::cout << "# bits, " << "time" << std::endl;
        for (int i = 0; i <= 30; i++) {
                int size = pow(2, i);
		std::vector<int> data = generateAscList(0, size);
		int r_value = std::rand( );	
		r_value = r_value % (size+1);
		int reps = 10;	
		if (i <= 20) {
			reps = 100;
		}
		if ( i <= 25 && i > 20 ) {
			reps = 50;
		}
                clock_t t0 = std::clock();
		for (int i = 0; i < reps; i++) {
			trinary_search(data, r_value);
		}
                clock_t t1 = std::clock();


                double dt = ((double)(t1 - t0)) / (reps*CLOCKS_PER_SEC);
                //std::cout << i << ", " << dt << std::endl;
                std::cout << dt << std::endl;
        }
}


int main() {
	int seed = std::time( 0 );
	std::srand( seed );

	runTime();
	return 0;
}
