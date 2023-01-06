#pragma once
#include <fstream>
#include <string>
#include "Tolken.h"
#include "StateMachine.h"

class ScannerClass {
public:
	ScannerClass(std::string file_name);
	~ScannerClass();

	TokenClass getNextToken();
	TokenClass peekNextToken();
	int getLineNumber() { return mLineNumber; };

private:
	std::ifstream mFin;
	int mLineNumber;
};