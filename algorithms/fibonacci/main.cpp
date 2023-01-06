#include <ctime>
#include <iostream>
#include <cstdlib>
#include <map>



int fib1(int n) {
	if (n == 0) {
		return 0;
	}
	if (n == 1) {
		return 1;
	}
	return fib1(n - 1 ) + fib1(n - 2);
}

int fib2(int n, std::map<int, int> fib_nums) {
	if (n == 0) {
		return 0;
	}
	for ( size_t i = 2; i <=n; i++) {
		fib_nums[i] = fib_nums[i-1] + fib_nums[i-2];
	}
	return fib_nums[n];	
}

void testFib2() {
	
	int reps_large = 10;
	int reps_small = 10000;


	std::map<int, int> fib_nums;
	fib_nums[0] = 0;
	fib_nums[1] = 1;

	std::cout << "fibonacci number" << ", " << "n" << ", " << "time (milliseconds)" << std::endl;
	for ( int i = 1; i <= 40; i++ ) {
		int fib_num;
		int reps;

		if (i < 10) {
			reps = reps_small;	
		}		
		else {
			reps = reps_large;
		}

		clock_t t0 = std::clock( );
		for (int j = 0; j < reps; j++) {
			fib_num = fib2(i, fib_nums);
		}
		clock_t t1 = std::clock( );

		double dt = ((double)(t1 - t0)) / CLOCKS_PER_SEC;
		double msec_per_rep = (dt / reps)*1000;

		std::cout << fib_num << ", " << i << ", " << msec_per_rep << std::endl;

	}
}
void testFib1() {
	
	int reps_large = 10;
	int reps_small = 10000;

	std::cout << "fibonacci number" << ", " << "n" << ", " << "time (milliseconds)" << std::endl;

	for ( int i = 1; i <= 40; i++ ) {
		int fib_num;
		int reps;

		if (i < 10) {
			reps = reps_small;	
		}		
		else {
			reps = reps_large;
		}

		clock_t t0 = std::clock( );
		for (int j = 0; j < reps; j++) {
			fib_num = fib1(i);
		}
		clock_t t1 = std::clock( );

		double dt = ((double)(t1 - t0)) / CLOCKS_PER_SEC;
		double msec_per_rep = (dt / reps)*1000;

		std::cout << fib_num << ", " << i << ", " << msec_per_rep << std::endl;

	}
}

int main() {
	testFib1();
	std::cout << std::endl;
	testFib2();
	std::cout << std::endl;
	return 0;
}
