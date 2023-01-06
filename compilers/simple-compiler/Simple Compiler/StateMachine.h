#pragma once
#include "Tolken.h"

enum MachineState {
	START_STATE, CANTMOVE_STATE,
	IDENTIFIER_STATE, INTEGER_STATE, ASSIGNMENT_STATE, INSERTION_STATE,
	LCURLY_STATE, RCURLY_STATE, LPAREN_STATE, RPAREN_STATE, SEMICOLON_STATE, 
	PLUS_STATE, MINUS_STATE, TIMES_STATE, DIVIDE_STATE, EXP_STATE,
	LESS_STATE, LESSEQUAL_STATE, GREATER_STATE, GREATEREQUAL_STATE, EQUAL_STATE, NOTEQUAL_STATE,
	NOT_STATE, BIN_AND_STATE, BIN_OR_STATE, AND_STATE, OR_STATE,
	LINE_COMMENT_STATE,
	BLOCK_OPEN_STATE, BLOCK_CLOSING_STATE,
	EOF_STATE,
	STATE_COUNT
};

enum CharacterType {
	BAD_CHAR,
	LETTER_CHAR, DIGIT_CHAR, UNDERSCORE_CHAR, WHITESPACE_CHAR, 
	LCURLY_CHAR, RCURLY_CHAR, LPAREN_CHAR, RPAREN_CHAR,
	PLUS_CHAR, MINUS_CHAR, TIMES_CHAR, DIVIDE_CHAR,
	LESS_CHAR, GREATER_CHAR, NOT_CHAR, EQUAL_CHAR, AMP_CHAR, BAR_CHAR, SEMICOLON_CHAR, 
	RETURN_CHAR,
	EOF_CHAR,
	CHAR_COUNT
};

class StateMachineClass
{
public:
	StateMachineClass();
	MachineState updateState(char currentCharacter, TokenType& correspondingTokenType);

private:
	MachineState mCurrentState;
	// The matrix of legal moves:
	MachineState mLegalMoves[STATE_COUNT][CHAR_COUNT];
	// Which end-machine-states correspond to which token types.
	// (non end states correspond to the BAD_TOKEN token type)
	TokenType mCorrespondingTokenTypes[STATE_COUNT];
};


