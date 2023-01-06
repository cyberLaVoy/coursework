#include "Parser.h"

ParserClass::ParserClass(ScannerClass* sc, SymbolTableClass* stc) : mScanner(sc), mSymbolTable(stc)
{
}

// Verify that the next token in the input file is of the same type
// that the parser expects.
TokenClass ParserClass::Match(TokenType expectedType)
{
	TokenClass currentToken = mScanner->getNextToken();
	if (currentToken.getTokenType() != expectedType)
	{
		std::cerr << "Error in ParserClass::Match. " << std::endl;
		std::cerr << "Expected token type " <<
			TokenClass::getTokenTypeName(expectedType) <<
			", but got type " << currentToken.getTokenTypeName() << std::endl;
		system("pause");
		exit(1);
	}
	MSG("\tSuccessfully matched Token Type: " <<
		currentToken.getTokenTypeName() << ". Lexeme: \"" <<
		currentToken.getLexeme() << "\"");
	return currentToken; // the one we just processed
}

// <Start> ? <Program> ENDFILE
StartNode* ParserClass::Start()
{
	ProgramNode *pn = Program();
	Match(EOF_TOKEN);
	StartNode* sn = new StartNode(pn);
	return sn;

}

// <Program> ? VOID MAIN LPAREN RPAREN <Block>
ProgramNode* ParserClass::Program() {
	Match(VOID_TOKEN);
	Match(MAIN_TOKEN);
	Match(LPAREN_TOKEN);
	Match(RPAREN_TOKEN);
	BlockNode* bn = Block();
	ProgramNode* pn = new ProgramNode(bn);
	return pn;
}
// <Block> ? LCURLY <StatementGroup> RCURLY
BlockNode* ParserClass::Block() {
	TokenClass peekedToken = mScanner->peekNextToken();
	if (peekedToken.getTokenType() == LCURLY_TOKEN) {
		Match(LCURLY_TOKEN);
	}
	else {
		Match(BEGIN_TOKEN);
	}
	StatementGroupNode* sg = StatementGroup();
	peekedToken = mScanner->peekNextToken();
	if (peekedToken.getTokenType() == RCURLY_TOKEN) {
		Match(RCURLY_TOKEN);
	}
	else {
		Match(END_TOKEN);
	}
	BlockNode* bn = new BlockNode(sg);
	return bn;
}

// <StatementGroup> ? <DeclarationStatement> <StatementGroup>
// <StatementGroup> ? <AssignmentStatement> <StatementGroup>
// <StatementGroup> ? <CoutStatement> <StatementGroup>
// <StatementGroup> ? <Block> <StatementGroup>
// <StatementGroup> ? {empty} 
StatementNode* ParserClass::Statement() {
	TokenClass peekedToken = mScanner->peekNextToken();
	if (peekedToken.getTokenType() == INT_TOKEN) {
		DeclarationStatementNode* dsn = DeclarationStatement();
		return dsn;
	}
	else if (peekedToken.getTokenType() == IDENTIFIER_TOKEN) {
		AssignmentStatementNode* asn = AssignmentStatement();
		return asn;
	}
	else if (peekedToken.getTokenType() == COUT_TOKEN) {
		CoutStatementNode* csn = CoutStatement();
		return csn;
	}
	else if (peekedToken.getTokenType() == IF_TOKEN) {
		IfStatementNode* csn = IfStatement();
		return csn;
	}
	else if (peekedToken.getTokenType() == WHILE_TOKEN) {
		WhileStatementNode* csn = WhileStatement();
		return csn;
	}
	else if (peekedToken.getTokenType() == LCURLY_TOKEN || peekedToken.getTokenType() == BEGIN_TOKEN ) {
		BlockNode* bn = Block();
		return bn;
	}
	else {
		return NULL;
	}
}
StatementGroupNode* ParserClass::StatementGroup() {
	StatementGroupNode* sgn = new StatementGroupNode();
	StatementNode* sn = Statement();
	while (sn) {
		sgn->addStatement(sn);
		sn = Statement();
	}
	return sgn;
}
// <IfStatement> ? IF LPAREN <Expression> RPAREN <Block>
IfStatementNode* ParserClass::IfStatement() {
	StatementNode* statement1;
	StatementNode* statement2 = NULL;
	Match(IF_TOKEN);
	Match(LPAREN_TOKEN);
	ExpressionNode* en = Expression();
	Match(RPAREN_TOKEN);
	statement1 = Statement();
	TokenType tt = mScanner->peekNextToken().getTokenType();
	if (tt == ELSE_TOKEN)
	{
		Match(tt);
		statement2 = Statement();
	}
	IfStatementNode* isn = new IfStatementNode(en, statement1, statement2);
	return isn;
}
// <WhileStatement> ? WHILE LEFT_PAREN <Expression> RIGHT_PAREN <Block>
WhileStatementNode* ParserClass::WhileStatement() {
	Match(WHILE_TOKEN);
	Match(LPAREN_TOKEN);
	ExpressionNode* en = Expression();
	Match(RPAREN_TOKEN);
	BlockNode* bn = Block();
	WhileStatementNode* wsn = new WhileStatementNode(en, bn);
	return wsn;
}

// <DeclarationStatement> ? INT <Identifier> SEMICOLON
DeclarationStatementNode* ParserClass::DeclarationStatement() {
	Match(INT_TOKEN);
	IdentifierNode* in = Identifier();
	Match(SEMICOLON_TOKEN);
	DeclarationStatementNode* dsn = new DeclarationStatementNode(in);
	return dsn;
}
// <AssignmentStatement> ? <Identifier> ASSIGNMENT <Expression> SEMICOLON
AssignmentStatementNode* ParserClass::AssignmentStatement() {

	IdentifierNode* in = Identifier();
	Match(ASSIGNMENT_TOKEN);
	ExpressionNode* en = Expression();
	Match(SEMICOLON_TOKEN);
	AssignmentStatementNode* asn = new AssignmentStatementNode(in, en);
	return asn;
}
// <CoutStatement> ? COUT INSERTION <Expression> SEMICOLON 
CoutStatementNode* ParserClass::CoutStatement() {
	Match(COUT_TOKEN);
	Match(INSERTION_TOKEN);
	ExpressionNode* en = Expression();
	Match(SEMICOLON_TOKEN);
	CoutStatementNode* csn = new CoutStatementNode(en);
	return csn;
}

// <Expression> -> <Relational>
ExpressionNode* ParserClass::Expression() {
	ExpressionNode* en = Or();
	return en;
}

ExpressionNode* ParserClass::And() {
	ExpressionNode* current = Relational();
	while (true)
	{
		TokenType tt = mScanner->peekNextToken().getTokenType();
		if (tt == AND_TOKEN)
		{
			Match(tt);
			current = new AndNode(current, Relational());
		}
		else {
			return current;
		}
	}
}
ExpressionNode* ParserClass::Or() {
	ExpressionNode* current = And();
	while (true)
	{
		TokenType tt = mScanner->peekNextToken().getTokenType();
		if (tt == OR_TOKEN)
		{
			Match(tt);
			current = new OrNode(current, And());
		}
		else {
			return current;
		}
	}
}
// <Relational> -> <PlusMinus> <RelationalTail> 
// <RelationalTail> -> LESS_TOKEN <PlusMinus>
// <RelationalTail> -> LESSEQUAL_TOKEN <PlusMinus>
// <RelationalTail> -> GREATER_TOKEN <PlusMinus>
// <RelationalTail> -> GREATEREQUAL_TOKEN <PlusMinus>
// <RelationalTail> -> EQUAL_TOKEN <PlusMinus>
// <RelationalTail> -> NOTEQUAL_TOKEN <PlusMinus>
// <RelationalTail> -> {empty}
ExpressionNode* ParserClass::Relational()
{
	ExpressionNode * current = PlusMinus();

	// Handle the optional tail:
	TokenType tt = mScanner->peekNextToken().getTokenType();
	if (tt == LESS_TOKEN)
	{
		Match(tt);
		current = new LessNode(current, PlusMinus());
	}
	else if (tt == LESSEQUAL_TOKEN)
	{
		Match(tt);
		current = new LessEqualNode(current, PlusMinus());
	}
	else if (tt == GREATER_TOKEN)
	{
		Match(tt);
		current = new GreaterNode(current, PlusMinus());
	}
	else if (tt == GREATEREQUAL_TOKEN)
	{
		Match(tt);
		current = new GreaterEqualNode(current, PlusMinus());
	}
	else if (tt == EQUAL_TOKEN)
	{
		Match(tt);
		current = new EqualNode(current, PlusMinus());
	}
	else if (tt == NOTEQUAL_TOKEN)
	{
		Match(tt);
		current = new NotEqualNode(current, PlusMinus());
	}
	else
	{
		return current;
	}
}

// <PlusMinus> -> <TimesDivide> <PlusMinusTail>	
// <PlusMinusTail> -> PLUS_TOKEN <TimesDivide> <PlusMinusTail>
// <PlusMinusTail> -> MINUS_TOKEN <TimesDivide> <PlusMinusTail>
// <PlusMinusTail> -> {empty}
ExpressionNode * ParserClass::PlusMinus()
{
	ExpressionNode * current = TimesDivide();
	while (true)
	{
		TokenType tt = mScanner->peekNextToken().getTokenType();
		if (tt == PLUS_TOKEN)
		{
			Match(tt);
			current = new PlusNode(current, TimesDivide());
		}
		else if (tt == MINUS_TOKEN)
		{
			Match(tt);
			current = new MinusNode(current, TimesDivide());
		}
		else
		{
			return current;
		}
	}
}

// <TimesDivide> -> <Factor> <TimesDivideTail>
// <TimesDivideTail> -> TIMES_TOKEN <Factor> <TimesDivideTail>
// <TimesDivideTail> -> DIVIDE_TOKEN <Factor> <TimesDivideTail>
// <TimesDivideTail> -> {empty}
ExpressionNode* ParserClass::TimesDivide()
{
	ExpressionNode * current = Exponent();
	while (true)
	{
		TokenType tt = mScanner->peekNextToken().getTokenType();
		if (tt == TIMES_TOKEN)
		{
			Match(tt);
			current = new TimesNode(current, Exponent());
		}
		else if (tt == DIVIDE_TOKEN)
		{
			Match(tt);
			current = new DivideNode(current, Exponent());
		}
		else
		{
			return current;
		}
	}
}

ExpressionNode* ParserClass::Exponent()
{
	ExpressionNode * current = Not();
	while (true)
	{
		TokenType tt = mScanner->peekNextToken().getTokenType();
		if (tt == EXP_TOKEN)
		{
			Match(tt);
			current = new ExponentNode(current, Not());
		}
		else
		{
			return current;
		}
	}
}

// itterative version
//ExpressionNode * ParserClass::Not()
//{
//	TokenType tt = mScanner->peekNextToken().getTokenType();
//	int numberOfNots = 0;
//	while (tt == NOT_TOKEN)
//	{
//		Match(tt);
//		tt = mScanner->peekNextToken().getTokenType();
//		numberOfNots++;
//	}
//	ExpressionNode* current = Factor();
//	for (int i = 0; i < numberOfNots; i++) {
//		current = new NotNode(current);
//	}
//	return current;
//}

// recursive version
ExpressionNode * ParserClass::Not()
{
	while (true)
	{
		TokenType tt = mScanner->peekNextToken().getTokenType();
		if (tt == NOT_TOKEN)
		{
			Match(tt);
			return new NotNode( Not() );
		}
		else {
			return Factor();
		}
	}
}

// <Factor> ? <Identifier> 
// <Factor> ? <Integer> 
// <Factor> ? LPAREN_TOKEN <Expression> RPAREN_TOKEN
ExpressionNode* ParserClass::Factor()
{
	TokenType tt = mScanner->peekNextToken().getTokenType();
	if (tt == IDENTIFIER_TOKEN)
	{
		ExpressionNode* en = Identifier();
		return en;
	}
	else if (tt == INTEGER_TOKEN)
	{
		ExpressionNode* en = Integer();
		return en;
	}
	else if (tt == LPAREN_TOKEN) {
		Match(LPAREN_TOKEN);
		ExpressionNode* en = Expression();
		Match(RPAREN_TOKEN);
		return en;
	}
	else
	{
		std::cerr << "Error in ParserClass::Factor. " << std::endl;
		std::cerr << "Expected token type integer, identifier, or left parenthesis, but got type " << TokenClass::getTokenTypeName(tt) << std::endl;
		system("pause");
		exit(1);
	}
}

// <Identifier> ? IDENTIFIER_TOKEN
IdentifierNode* ParserClass::Identifier() {
	TokenClass tc = Match(IDENTIFIER_TOKEN);
	IdentifierNode* in = new IdentifierNode(tc.getLexeme(), mSymbolTable);
	return in;
}

// <Integer> ? INTEGER_TOKEN
IntegerNode* ParserClass::Integer() {
	TokenClass tc = Match(INTEGER_TOKEN);
	int integer = atoi( tc.getLexeme().c_str() );
	IntegerNode* in = new IntegerNode(integer);
	return in;
}

