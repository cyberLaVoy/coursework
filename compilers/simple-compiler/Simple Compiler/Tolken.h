#pragma once
#include <string>
#include <iostream>

enum TokenType {
	// Reserved Words:
	VOID_TOKEN, MAIN_TOKEN, INT_TOKEN, COUT_TOKEN, BOOL_TOKEN, IF_TOKEN, ELSE_TOKEN, WHILE_TOKEN, BEGIN_TOKEN, END_TOKEN,
	// Relational Operators:
	LESS_TOKEN, LESSEQUAL_TOKEN, GREATER_TOKEN, GREATEREQUAL_TOKEN, EQUAL_TOKEN, NOTEQUAL_TOKEN,
	NOT_TOKEN, AND_TOKEN, OR_TOKEN,
	// Other Operators:
	INSERTION_TOKEN, ASSIGNMENT_TOKEN, PLUS_TOKEN, MINUS_TOKEN, TIMES_TOKEN, DIVIDE_TOKEN, EXP_TOKEN,
	// Other Characters:
	SEMICOLON_TOKEN, LPAREN_TOKEN, RPAREN_TOKEN, LCURLY_TOKEN,
	RCURLY_TOKEN,
	// Other Token Types:
	IDENTIFIER_TOKEN, INTEGER_TOKEN,
	BAD_TOKEN, EOF_TOKEN
};
const std::string gTokenTypeNames[] = {
	"VOID", "MAIN", "INT", "COUT", "BOOL", "IF", "ELSE", "WHILE", "BEGIN", "END",
	"LESS", "LESSEQUAL", "GREATER", "GREATEREQUAL", "EQUAL", "NOTEQUAL",
	"NOT", "AND", "OR",
	"INSERTION", "ASSIGNMENT", "PLUS", "MINUS", "TIMES", "DIVIDE", "EXPONENT"
	"SEMICOLON", "LPAREN", "RPAREN", "LCURLY", "RCURLY",
	"IDENTIFIER", "INTEGER",
	"BAD", "ENDFILE"
};


class TokenClass
{
private:
	TokenType mType;
	std::string mLexeme;
public:
	TokenClass();
	TokenClass(TokenType type, const std::string& lexeme);
	TokenType getTokenType() const { return mType; }
	const std::string& getTokenTypeName() const
	{
		return gTokenTypeNames[mType];
	}
	std::string getLexeme() const { return mLexeme; }
	void CheckReserved();
	static const std::string& getTokenTypeName(TokenType type)
	{
		return gTokenTypeNames[type];
	}

};

std::ostream& operator<<(std::ostream& output_stream, const TokenClass& tolken_class);
