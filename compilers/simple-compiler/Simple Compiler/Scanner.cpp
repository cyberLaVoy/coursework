#include "Scanner.h"
#include "Debug.h"

ScannerClass::ScannerClass(std::string file_name)
{
	MSG("Initializing ScannerClass object"); //preprocessor macro

	mFin.open(file_name);
	//PRINT ERROR MESSAGE AND QUIT IF FILE DOESN'T OPEN
	if (!mFin) {
		std::cerr << "Failed to open file." << std::endl;
		exit(1);
	}
	mLineNumber = 1;
}

ScannerClass::~ScannerClass()
{
	mFin.close();
}

TokenClass ScannerClass::getNextToken()
{
	StateMachineClass stateMachine;
	std::string lexeme = "";
	TokenType token_type;
	char input_char;
	MachineState machine_state = START_STATE;
	while (machine_state != CANTMOVE_STATE ) {
		input_char = mFin.get();
		lexeme += input_char;
		machine_state = stateMachine.updateState(input_char, token_type);
		if (machine_state == START_STATE || machine_state == BLOCK_OPEN_STATE) {
			lexeme = "";
			if (input_char == 10) {
				mLineNumber++;
			}
		}
	}
	if (token_type == BAD_TOKEN) {
	//print error message and quit
	std::cerr << "BAD TOKEN" << std::endl;
	exit(1);
	}

	mFin.unget();
	lexeme = lexeme.substr(0, lexeme.size()-1);
	//tellg and seekg if unget() is not supported
	TokenClass token(token_type, lexeme);
	token.CheckReserved();
	return token;
}

TokenClass ScannerClass::peekNextToken()
{
	double currentLineNumber = mLineNumber;
	int cursorPosition = mFin.tellg();

	TokenClass peekedToken = getNextToken();

	if (!mFin) // if we triggered EOF, then seekg doesn't work,
		mFin.clear();// unless we first clear()

	mLineNumber = currentLineNumber;
	mFin.seekg(cursorPosition);

	return peekedToken;
}
