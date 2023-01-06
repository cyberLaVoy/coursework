#pragma once
#include <string>
#include <vector>

class SymbolTableClass
{
public:
	bool Exists(const std::string&  s);
	void AddEntry(const std::string&  s);
	int GetValue(const std::string&  s);
	void SetValue(const std::string&  s, int v);
	int GetIndex(const std::string&  s);
	int GetCount();

	struct Variable { std::string mLabel;
					  int mValue; };
	std::vector<Variable> mSymbolTable;

};