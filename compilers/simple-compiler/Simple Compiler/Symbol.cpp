#include <iostream>
#include "Symbol.h"

bool SymbolTableClass::Exists(const std::string& s) {
// returns true if <s> is already in the symbol table.
	for (size_t i = 0; i < mSymbolTable.size(); i++) {
		if (mSymbolTable[i].mLabel == s) {
			return true;
		}
	}
	return false;
}
void SymbolTableClass::AddEntry(const std::string&  s) {
	if (!Exists(s)) {
		Variable v;
		v.mLabel = s;
		v.mValue = 0;
		mSymbolTable.push_back(v);
	}
	else {
		std::cerr << "Variable '" << s << "' already exists." << std::endl;
		system("pause");
		exit(1);
	}
// adds <s> to the symbol table, 
// or quits if it was already there
}
int SymbolTableClass::GetValue(const std::string&  s) {
	if (!Exists(s)) {
		std::cerr << "Variable '" << s << "' does not exists." << std::endl;
		system("pause");
		exit(1);
	}
	for (size_t i = 0; i < mSymbolTable.size(); i++) {
		if (mSymbolTable[i].mLabel == s) {
			return mSymbolTable[i].mValue;
		}
	}

// returns the current value of variable <s>, when interpreting. Meaningless for Coding and Executing.
// Prints a message and quits if variable s does not exist.
}

void SymbolTableClass::SetValue(const std::string&  s, int v) {
	if (!Exists(s)) {
		std::cerr << "Variable '" << s << "' does not exists." << std::endl;
		system("pause");
		exit(1);
	}
	for (size_t i = 0; i < mSymbolTable.size(); i++) {
		if (mSymbolTable[i].mLabel == s) {
			mSymbolTable[i].mValue = v;
		}
	}
// sets variable <s> to the given value, when interpreting.
// Meaningless for Coding and Executing.
// Prints a message and quits if variable s does not exist.
}

int SymbolTableClass::GetIndex(const std::string&  s) {
	for (size_t i = 0; i < mSymbolTable.size(); i++) {
		if (mSymbolTable[i].mLabel == s) {
			return i;
		}
	}
	return -1;
// returns the index of where variable <s> is.
// returns -1 if variable <s> is not there.
}
int SymbolTableClass::GetCount() {
	return mSymbolTable.size();
// returns the current number of variables in the symbol table.  
}
