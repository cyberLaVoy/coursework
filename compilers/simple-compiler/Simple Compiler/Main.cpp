#include <iostream>
#include <string>
#include "Scanner.h"
#include "Symbol.h"
#include "Node.h"
#include "Parser.h"
#include "Instructions.h"

void testScanner() {
	ScannerClass scanner("input.txt");
	TokenClass token;
	int line_number;
	token = scanner.getNextToken();
	while (token.getTokenType() != EOF_TOKEN) {
	line_number = scanner.getLineNumber();
		std::cout << "Line #" << line_number;
		std::cout << " Token:" << token.getTokenTypeName();
		std::cout << " Lexeme: " << token.getLexeme() << std::endl;
		token = scanner.getNextToken();
	}
	line_number = scanner.getLineNumber();
	std::cout << "Line #" << line_number;
	std::cout << " Token:" << token.getTokenTypeName();
	std::cout << " Lexeme: " << token.getLexeme() << std::endl;
}
void testSymbolTable() {
	SymbolTableClass symbolTable;
	
	std::cout << "symbolTable.GetCount()" << symbolTable.GetCount() << std::endl;
	std::cout << "symbolTable.Exists('nope')" << symbolTable.Exists("nope") << std::endl;

	std::cout << "symbolTable.AddEntry('yes')" << std::endl;
	symbolTable.AddEntry("yes");
	std::cout << "symbolTable.GetCount()" << symbolTable.GetCount() << std::endl;
	std::cout << "symbolTable.AddEntry('doubleYes')" << std::endl;
	symbolTable.AddEntry("doubleYes");
	std::cout << "symbolTable.GetCount()" << symbolTable.GetCount() << std::endl;

	std::cout << "symbolTable.Exists('yes')" << symbolTable.Exists("yes") << std::endl;
	std::cout << "symbolTable.Exists('doubleYes')" << symbolTable.Exists("doubleYes") << std::endl;

	std::cout << "symbolTable.SetValue('yes', 13);" << std::endl;
	symbolTable.SetValue("yes", 13);
	std::cout << "symbolTable.SetValue('doubleYes', 7);" << std::endl;
	symbolTable.SetValue("doubleYes", 7);

	std::cout << "symbolTable.GetValue('yes')" << symbolTable.GetValue("yes") << std::endl;
	std::cout << "symbolTable.GetValue('doubleYes')" << symbolTable.GetValue("doubleYes") << std::endl;
	std::cout << "symbolTable.GetIndex('yes')" << symbolTable.GetIndex("yes") << std::endl;
	std::cout << "symbolTable.GetIndex('doubleYes')" << symbolTable.GetIndex("doubleYes") << std::endl;

	//these should cause the compiler to call exit(1), or return -1

	std::cout << "symbolTable.GetIndex('missing')" << symbolTable.GetIndex("missing") << std::endl;

	std::cout << "symbolTable.AddEntry('yes')" << std::endl;
	symbolTable.AddEntry("yes");

	//std::cout << "symbolTable.SetValue('notHere', 2);" << std::endl;
	//symbolTable.SetValue("notHere", 2);

	//std::cout << "symbolTable.GetValue('die')" << symbolTable.GetValue("die") << std::endl;

}

void testNodeCode() {
	SymbolTableClass st;

	IdentifierNode* sum1 = new IdentifierNode("sum", &st);
	DeclarationStatementNode* ds = new DeclarationStatementNode(sum1);

	IdentifierNode* sum2 = new IdentifierNode("sum", &st);
	IntegerNode* in13 = new IntegerNode(13);
	AssignmentStatementNode* as = new AssignmentStatementNode(sum2, in13);

	IdentifierNode* sum3 = new IdentifierNode("sum", &st);
	IntegerNode* in17 = new IntegerNode(17);
	PlusNode* plusn = new PlusNode(sum3, in17);
	CoutStatementNode* cn = new CoutStatementNode(plusn);

	StatementGroupNode* sgn = new StatementGroupNode();
	sgn->addStatement(ds);
	sgn->addStatement(as);
	sgn->addStatement(cn);

	BlockNode* bn = new BlockNode(sgn);
	ProgramNode* programN = new ProgramNode(bn);
	StartNode* sn = new StartNode(programN);
	
	delete sn;
}

void testParser() {
	ScannerClass Scanner("input.txt");
	SymbolTableClass SymbolTable;
	ParserClass Parser(&Scanner, &SymbolTable);
	StartNode* sn = Parser.Start();
	sn->interpret();
	delete sn;
}

void testDummyMachineCode() {
	unsigned char mCode[] = { 0x55, 0x8B, 0xEC, 0X5d, 0XC3 };
	std::cout << "About to Execute the machine code...\n";
	void * ptr = mCode;
	void(*f)(void);
	f = (void(*)(void)) ptr;
	f(); // call the array as if it were a function
	std::cout << "There and back again!\n\n";
}

void testInstructionSet() {
	InstructionsClass ic;
	ic.Finish();
	ic.Execute();
}
int main() {
	//testSymbolTable();
	//testNodeCode();
	//testParser();
	//testDummyMachineCode();
	testInstructionSet();
	return 0;
}