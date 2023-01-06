#include <cmath>
#include <iostream>
#include <ctime>
#include <vector>
#include <cstdlib>


bool isPrime(long long int n) {
	if (n == 2) {
		return true;
	}
	if ( n % 2 == 0 ) {
		return false;
	}
	for (long long int i = 3; i <= sqrt(n); i+=2) {
		if ( n % i == 0 ) {
			return false;
		}
	}
	return true;
}

long long int modexp(long long int x, long long int y, long long int n) {
	if (y ==0 ) {
		return 1;
	}
	long long int z = modexp(x, y/2, n); 

	if (y % 2 == 0) {
		return z*z % n;
	} 
	else {
		return x*z*z % n;
	}
	
}
long long int gcd(long long int a, long long int b) {
	if ( b == 0 ) {
		return a;
	}
	return gcd(b, a%b);
}
bool areRelativelyPrime(long long int a, long long int b) {
	if (gcd(a, b) == 1) {
		return true;
	}
	else {
		return false;
	}
}
bool isPrime2(long long int n) {
	for (int i = 0; i < 100; i++)	{
		long long int a = std::rand();
		a %= (n-1);
		a += 1;
		while (! areRelativelyPrime(n, a) ) {
			a = std::rand();
			a %= (n-1);
			a += 1;	
		}
		if (modexp(a, n-1, n) != 1) {
			return false;
		}
	}
	return true;
}

void testIsPrime() {
	std::cout << "# bits, " << "time" << std::endl;
	int reps;
	for (int i = 1; i <= 49; i++) {
		long long int n = pow(2, i);
		int primes_count = 0;
		int while_count = 0;
		if (i < 20) {
			reps = 50;
		}	
		else {
			reps = 1;
		}
		clock_t t0 = std::clock();
		while (n > 1 && primes_count < 1024) {
			bool is_prime;
			for (int j = 0; j < reps; j++) {
				is_prime = isPrime2(n);
			}
			if ( is_prime ) {
				primes_count++;
			}
			while_count++;
			n -= 1;
		}
		clock_t t1 = std::clock();

		double dt = ((double)(t1 - t0)) / (CLOCKS_PER_SEC*while_count*reps);
		std::cout << i+1 << ", " << dt << std::endl;
		//std::cout << dt << std::endl;
	}
}

std::vector<long long int> primeFactorization( long long int n, std::vector<long long int>& factors) {
	if (isPrime(n)) {
		factors.push_back(n);
		return factors;
	}
	for (long long int i = 2; i <= sqrt(n); i+=2) {
		if ( n % i == 0 ) {
			factors.push_back(i);
			n /= i;
			while ( n % i == 0 ) {
				factors.push_back(i);
				n /= i;
			}
			if ( n == 2 ) {
				i = 1;
			}
		}
	}
	if ( n != 1) {
		factors.push_back(n);
	}
	return factors;
}

void testPrimeFactorization() {
	std::cout << "# bits, " << "time" << std::endl;
	for (int i = 1; i <= 50; i++) {
		long long int n = pow(2, i) - 1;
		long long int n_before = pow(2, i-1) - 1;
		long long int stop_value = n - n_before;
		int while_count = 0;
		clock_t t0 = std::clock();
		while (n >= stop_value && while_count < 1024) {
			std::vector<long long int> factors;
			primeFactorization(n, factors);
			while_count++;
			n -= 1;
		}
		clock_t t1 = std::clock();

		double dt = ((double)(t1 - t0)) / (CLOCKS_PER_SEC*while_count);
		std::cout << i << ", " << dt << std::endl;
	}
}

int main() {
	//std::cout << "Prime Factorization" << std::endl;
	//testPrimeFactorization();
	std::cout << "Is Prime" << std::endl;
	testIsPrime();
	return 0;
}
