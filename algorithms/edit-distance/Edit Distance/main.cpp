#include <iostream>
#include <ctime>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

int editDistance(std::string w1, std::string w2) {
	size_t m = w1.size();
	size_t n = w2.size();
	std::vector< std::vector<size_t> > E;
	
	// create m+1 x n+1 matrix
	for (size_t i = 0; i <= m; i++) {
		std::vector<size_t> ri;
		for (size_t j = 0; j <= n; j++) {
			ri.push_back(0);
		}
		E.push_back(ri);
	}

	for (size_t i = 0; i <= m; i++) {
		E[i][0] = i;
	}
	for (size_t j = 1; j <= n; j++) {
		E[0][j] = j;
	}

	for (size_t i = 1; i <= m; i++) {
		for (size_t j = 1; j <= n; j++) {
			size_t diff;
			(w1[i-1] == w2[j-1]) ? diff = 0 : diff = 1;
			size_t opt1 = std::min(E[i - 1][j] + 1, E[i][j - 1] + 1);
			size_t opt2 = E[i-1][j-1] + diff;
			E[i][j] = std::min(opt1, opt2);
		}
	}
	return E[m][n];
}

void editDistanceCosts() {
	std::string sizes[11] = {"4","8","10","20","40","80","100","200","400","800","1000"};
	std::string versions[4] = { "1", "2","3", "4" };
	std::ifstream fin;
	for (size_t i = 0; i < 11; i++) {
		for (size_t j = 0; j < 4; j++) {
			std::string path = "C:\\words\\words-" + sizes[i] + '-' + versions[j] + ".txt";
			fin.open(path);
			std::string w1;
			std::string w2;
			size_t sum = 0;
			while (fin >> w1 && fin >> w2) {
				sum += editDistance(w1, w2);
			}
			fin.close();
			std::cout << sum << std::endl;
		}
	}

}

void printSums(std::vector<size_t>& V) {
	for (size_t i = 0; i < V.size(); i++) {
		std::cout << V[i] << std::endl;
	}
}

void editDistanceRuntime() {
	std::vector<size_t> sums;
	std::string sizes[11] = {"4","8","10","20","40","80","100","200","400","800","1000"};
	std::string versions[4] = { "1", "2","3", "4" };
	std::ifstream fin;
	size_t numFiles = 4;
	for (size_t i = 0; i < 11; i++) {
		double totalDeltaT = 0;
		for (size_t j = 0; j < numFiles; j++) {
			std::string path = "C:\\words\\words-" + sizes[i] + '-' + versions[j] + ".txt";
			fin.open(path);
			std::string w1;
			std::string w2;
			size_t numWords = 0;
			size_t sum = 0;
			clock_t t0 = std::clock();
			while (fin >> w1 && fin >> w2) {
				sum += editDistance(w1, w2);
				numWords++;
			}
			clock_t t1 = std::clock();
			sums.push_back(sum);
			double dt = ((double)(t1 - t0)) / ((double)numWords*(CLOCKS_PER_SEC));
			totalDeltaT += dt;
			fin.close();
		}
		double dt = totalDeltaT / ((double)numFiles);
		std::cout << dt << std::endl;
	}
	printSums(sums);
}


int main() {
	//editDistanceCosts();
	editDistanceRuntime();
	return 1;
}