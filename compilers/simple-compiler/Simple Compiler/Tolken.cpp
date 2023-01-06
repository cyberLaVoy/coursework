#include "Tolken.h"
#include "Debug.h"

TokenClass::TokenClass()
{
}

TokenClass::TokenClass(TokenType type, const std::string & lexeme) : mType(type), mLexeme(lexeme)
{
}

void TokenClass::CheckReserved()
{
	if (mLexeme == "void") {
		mType = VOID_TOKEN;
	}
	else if (mLexeme == "main") { 
		mType = MAIN_TOKEN;
	}
	else if (mLexeme == "int") {
		mType = INT_TOKEN;
	}
	else if (mLexeme == "cout") {
		mType = COUT_TOKEN;
	}
	else if (mLexeme == "bool") {
		mType = BOOL_TOKEN;
	}
	else if (mLexeme == "if") {
		mType = IF_TOKEN;
	}
	else if (mLexeme == "else") {
		mType = ELSE_TOKEN;
	}
	else if (mLexeme == "while") {
		mType = WHILE_TOKEN;
	}
	else if (mLexeme == "begin") {
		mType = BEGIN_TOKEN;
	}
	else if (mLexeme == "end") {
		mType = END_TOKEN;
	}
}

std::ostream & operator<<(std::ostream & output_stream, const TokenClass& token_class)
{
	output_stream << "Token type: " << token_class.getTokenType() << " " << "Token name: " << token_class.getTokenTypeName() << " " << "Lexeme: " << token_class.getLexeme();
	return output_stream;
}
