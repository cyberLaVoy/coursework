#include <cmath>
#include <iostream>
#include <ctime>
#include <cstdlib>


long long int modexp(long long int x, long long int y, long long int n) {
	if (y ==0 ) {
		return 1;
	}
	long long int z = modexp(x, y>>1, n); 

	if ((y & 1) == 0) {
		return (z*z) % n;
	} 
	else {
		return ( x* ((z*z)%n) ) % n;
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
	for (int i = 1; i <= 30; i++) {
		long long int n = ( 1 << i );
		int primes_count = 0;
		int while_count = 0;
		if (i < 5) {
			reps = 1000;
		}
		else if (i < 10) {
			reps = 250;
		}	
		else if (i < 15) {
			reps = 25;
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
	}
}

int main() {
	std::cout << "Is Prime" << std::endl;
	testIsPrime();
	return 0;
}
