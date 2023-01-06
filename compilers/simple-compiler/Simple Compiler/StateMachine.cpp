#include "StateMachine.h"
#include "Debug.h"

StateMachineClass::StateMachineClass() : mCurrentState(START_STATE) 
{
	// First, initialize all the mLegalMoves to CANTMOVE_STATE
	// Then, reset the mLegalMoves that are legitimate 
	for (int i = 0; i < STATE_COUNT; i++)
	{
		for (int j = 0; j < CHAR_COUNT; j++)
		{
			mLegalMoves[i][j] = CANTMOVE_STATE;
		}
	}
	mLegalMoves[START_STATE][LETTER_CHAR] = IDENTIFIER_STATE;
	mLegalMoves[START_STATE][UNDERSCORE_CHAR] = IDENTIFIER_STATE;
	mLegalMoves[IDENTIFIER_STATE][LETTER_CHAR] = IDENTIFIER_STATE;
	mLegalMoves[IDENTIFIER_STATE][UNDERSCORE_CHAR] = IDENTIFIER_STATE;
	mLegalMoves[IDENTIFIER_STATE][DIGIT_CHAR] = IDENTIFIER_STATE;

	mLegalMoves[START_STATE][DIGIT_CHAR] = INTEGER_STATE;
	mLegalMoves[INTEGER_STATE][DIGIT_CHAR] = INTEGER_STATE;

	mLegalMoves[START_STATE][LCURLY_CHAR] = LCURLY_STATE;
	mLegalMoves[START_STATE][RCURLY_CHAR] = RCURLY_STATE;
	mLegalMoves[START_STATE][LPAREN_CHAR] = LPAREN_STATE;
	mLegalMoves[START_STATE][RPAREN_CHAR] = RPAREN_STATE;
	mLegalMoves[START_STATE][SEMICOLON_CHAR] = SEMICOLON_STATE;
	mLegalMoves[START_STATE][PLUS_CHAR] = PLUS_STATE;
	mLegalMoves[START_STATE][MINUS_CHAR] = MINUS_STATE;
	mLegalMoves[START_STATE][TIMES_CHAR] = TIMES_STATE;
	mLegalMoves[TIMES_STATE][TIMES_CHAR] = EXP_STATE;
	mLegalMoves[START_STATE][DIVIDE_CHAR] = DIVIDE_STATE;

	mLegalMoves[DIVIDE_STATE][DIVIDE_CHAR] = LINE_COMMENT_STATE;
	for (int i = 0; i < CHAR_COUNT; i++)
	{
		mLegalMoves[LINE_COMMENT_STATE][i] = LINE_COMMENT_STATE;
	}
	mLegalMoves[LINE_COMMENT_STATE][RETURN_CHAR] = START_STATE;
	mLegalMoves[LINE_COMMENT_STATE][EOF_CHAR] = EOF_STATE;

	mLegalMoves[DIVIDE_STATE][TIMES_CHAR] = BLOCK_OPEN_STATE;
	for (int i = 0; i < CHAR_COUNT; i++)
	{
		mLegalMoves[BLOCK_OPEN_STATE][i] = BLOCK_OPEN_STATE;
	}
	mLegalMoves[BLOCK_OPEN_STATE][TIMES_CHAR] = BLOCK_CLOSING_STATE;
	for (int i = 0; i < CHAR_COUNT; i++)
	{
		mLegalMoves[BLOCK_CLOSING_STATE][i] = BLOCK_OPEN_STATE;
	}
	mLegalMoves[BLOCK_CLOSING_STATE][TIMES_CHAR] = BLOCK_CLOSING_STATE;
	mLegalMoves[BLOCK_CLOSING_STATE][DIVIDE_CHAR] = START_STATE;


	mLegalMoves[START_STATE][EQUAL_CHAR] = ASSIGNMENT_STATE;
	mLegalMoves[ASSIGNMENT_STATE][EQUAL_CHAR] = EQUAL_STATE;
	mLegalMoves[START_STATE][LESS_CHAR] = LESS_STATE;
	mLegalMoves[LESS_STATE][EQUAL_CHAR] = LESSEQUAL_STATE;
	mLegalMoves[LESS_STATE][LESS_CHAR] = INSERTION_STATE;
	mLegalMoves[START_STATE][GREATER_CHAR] = GREATER_STATE;
	mLegalMoves[GREATER_STATE][EQUAL_CHAR] = GREATEREQUAL_STATE;
	mLegalMoves[START_STATE][NOT_CHAR] = NOT_STATE;
	mLegalMoves[NOT_STATE][EQUAL_CHAR] = NOTEQUAL_STATE;

	mLegalMoves[START_STATE][EOF_CHAR] = EOF_STATE;

	mLegalMoves[START_STATE][WHITESPACE_CHAR] = START_STATE;
	mLegalMoves[START_STATE][RETURN_CHAR] = START_STATE;
	
	mLegalMoves[START_STATE][AMP_CHAR] = BIN_AND_STATE;
	mLegalMoves[BIN_AND_STATE][AMP_CHAR] = AND_STATE;

	mLegalMoves[START_STATE][BAR_CHAR] = BIN_OR_STATE;
	mLegalMoves[BIN_OR_STATE][BAR_CHAR] = OR_STATE;

	// First, initialize all states to correspond to the BAD token type.
	// Then, reset the end states to correspond to the correct token types.
	for (int i = 0; i < STATE_COUNT; i++)
	{
		mCorrespondingTokenTypes[i] = BAD_TOKEN;
	}
	mCorrespondingTokenTypes[IDENTIFIER_STATE] = IDENTIFIER_TOKEN;
	mCorrespondingTokenTypes[INTEGER_STATE] = INTEGER_TOKEN;
	mCorrespondingTokenTypes[ASSIGNMENT_STATE] = ASSIGNMENT_TOKEN;
	mCorrespondingTokenTypes[INSERTION_STATE] = INSERTION_TOKEN;
	mCorrespondingTokenTypes[LCURLY_STATE] = LCURLY_TOKEN;
	mCorrespondingTokenTypes[RCURLY_STATE] = RCURLY_TOKEN;
	mCorrespondingTokenTypes[LPAREN_STATE] = LPAREN_TOKEN;
	mCorrespondingTokenTypes[RPAREN_STATE] = RPAREN_TOKEN;
	mCorrespondingTokenTypes[SEMICOLON_STATE] = SEMICOLON_TOKEN;
	mCorrespondingTokenTypes[PLUS_STATE] = PLUS_TOKEN;
	mCorrespondingTokenTypes[MINUS_STATE] = MINUS_TOKEN;
	mCorrespondingTokenTypes[TIMES_STATE] = TIMES_TOKEN;
	mCorrespondingTokenTypes[DIVIDE_STATE] = DIVIDE_TOKEN;
	mCorrespondingTokenTypes[EXP_STATE] = EXP_TOKEN;

	mCorrespondingTokenTypes[LESS_STATE] = LESS_TOKEN;
	mCorrespondingTokenTypes[GREATER_STATE] = GREATER_TOKEN;
	mCorrespondingTokenTypes[LESSEQUAL_STATE] = LESSEQUAL_TOKEN;
	mCorrespondingTokenTypes[GREATEREQUAL_STATE] = GREATEREQUAL_TOKEN;
	mCorrespondingTokenTypes[NOTEQUAL_STATE] = NOTEQUAL_TOKEN;
	mCorrespondingTokenTypes[EQUAL_STATE] = EQUAL_TOKEN;
	mCorrespondingTokenTypes[NOT_STATE] = NOT_TOKEN;

	mCorrespondingTokenTypes[AND_STATE] = AND_TOKEN;
	mCorrespondingTokenTypes[OR_STATE] = OR_TOKEN;

	mCorrespondingTokenTypes[EOF_STATE] = EOF_TOKEN;

}

MachineState StateMachineClass::updateState(char currentCharacter, TokenType& correspondingTokenType)
{
	// convert the input character into an input character type
	CharacterType charType = BAD_CHAR;

	if (isdigit(currentCharacter))
		charType = DIGIT_CHAR;
	if (isalpha(currentCharacter))
		charType = LETTER_CHAR;
	if (isspace(currentCharacter))
		charType = WHITESPACE_CHAR;
	if (currentCharacter == '\n') 
		charType = RETURN_CHAR;
	if (currentCharacter == '_')
		charType = UNDERSCORE_CHAR;
	if (currentCharacter == ';')
		charType = SEMICOLON_CHAR;
	if (currentCharacter == '+')
		charType = PLUS_CHAR;
	if (currentCharacter == '-')
		charType = MINUS_CHAR;
	if (currentCharacter == '*')
		charType = TIMES_CHAR;
	if (currentCharacter == '/')
		charType = DIVIDE_CHAR;
	if (currentCharacter == '<')
		charType = LESS_CHAR;
	if (currentCharacter == '>')
		charType = GREATER_CHAR;
	if (currentCharacter == '=')
		charType = EQUAL_CHAR;
	if (currentCharacter == '!')
		charType = NOT_CHAR;
	if (currentCharacter == '{')
		charType = LCURLY_CHAR;
	if (currentCharacter == '}')
		charType = RCURLY_CHAR;
	if (currentCharacter == '(')
		charType = LPAREN_CHAR;
	if (currentCharacter == ')')
		charType = RPAREN_CHAR;
	if (currentCharacter == '&')
		charType = AMP_CHAR;
	if (currentCharacter == '|')
		charType = BAR_CHAR;
	if (currentCharacter == EOF)
		charType = EOF_CHAR;

	correspondingTokenType = mCorrespondingTokenTypes[mCurrentState];
	mCurrentState = mLegalMoves[mCurrentState][charType];
	return mCurrentState;
}
