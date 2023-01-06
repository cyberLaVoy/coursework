#pragma once
#include "Scanner.h"
#include "Symbol.h"
#include "Debug.h"
#include "Node.h"

class ParserClass {
public:
	ParserClass(ScannerClass* sc, SymbolTableClass* stc);
	StartNode* Start();

private:
	ScannerClass* mScanner;
	SymbolTableClass* mSymbolTable;

	TokenClass Match(TokenType expectedType);

	ProgramNode* Program();
	BlockNode* Block();
	StatementNode* Statement();
	StatementGroupNode* StatementGroup();
	IfStatementNode* IfStatement();
	WhileStatementNode* WhileStatement();
	DeclarationStatementNode* DeclarationStatement();
	AssignmentStatementNode* AssignmentStatement();
	CoutStatementNode* CoutStatement();
	ExpressionNode* Expression();
	ExpressionNode* And();
	ExpressionNode* Or();
	ExpressionNode* Relational();
	ExpressionNode* PlusMinus();
	ExpressionNode* TimesDivide();
	ExpressionNode* Exponent();
	ExpressionNode* Not();
	ExpressionNode* Factor();
	IdentifierNode* Identifier();
	IntegerNode* Integer();

	// <Start> ? <Program> ENDFILE
	// <Program> ? VOID MAIN LPAREN RPAREN <Block>
	// <Block> ? LCURLY <StatementGroup> RCURLY
	// <StatementGroup> ? {empty} 
	// <StatementGroup> ? <DeclarationStatement> <StatementGroup>
	// <StatementGroup> ? <AssignmentStatement> <StatementGroup>
	// <StatementGroup> ? <CoutStatement> <StatementGroup>
	// <StatementGroup> ? <Block> <StatementGroup>
	// <DeclarationStatement> ? INT <Identifier> SEMICOLON
	// <AssignmentStatement> ? <Identifier> ASSIGNMENT <Expression> SEMICOLON
	// <CoutStatement> ? COUT INSERTION <Expression> SEMICOLON 

};