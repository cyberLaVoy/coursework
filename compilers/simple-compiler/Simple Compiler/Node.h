#pragma once
#include<vector>
#include<string>
#include "Symbol.h"
#include "Debug.h"

class Node {
public:
	virtual ~Node() {};
	virtual void interpret() {};
};
class StatementNode : public Node {
public:
	virtual ~StatementNode() {};
};
class ExpressionNode {
public:
	virtual ~ExpressionNode() {};
	virtual int evaluate() = 0;
};
class BinaryOperatorNode : public ExpressionNode {
public:
	BinaryOperatorNode(ExpressionNode* left, ExpressionNode* right);
	virtual ~BinaryOperatorNode();
protected:
	ExpressionNode * mLeft;
	ExpressionNode * mRight;
};



class StatementGroupNode : public Node {
public:
	StatementGroupNode();
	virtual ~StatementGroupNode();
	void addStatement(StatementNode* sn);
	void interpret();
private:
	std::vector<StatementNode*>  mSNs;
};

class BlockNode : public StatementNode {
public:
	BlockNode(StatementGroupNode *sgn);
	virtual ~BlockNode();
	void interpret();
private:
	StatementGroupNode * mSGN;
};

class ProgramNode : public Node {
public:
	ProgramNode(BlockNode *bn);
	virtual ~ProgramNode();
	void interpret();
private:
	BlockNode * mBN;
};

class StartNode : public Node {
public:
	StartNode(ProgramNode *pn);
	virtual ~StartNode();
	void interpret();
private:
	ProgramNode * mPN;
};

class IdentifierNode : public ExpressionNode {
public:
	IdentifierNode(std::string label, SymbolTableClass* st);
	void declareVariable();
	void setValue(int v);
	int getIndex();
	int evaluate();
private:
	std::string mLabel;
	SymbolTableClass* mSymbolTable;
};


class DeclarationStatementNode : public StatementNode {
public:
	DeclarationStatementNode(IdentifierNode *in);
	virtual ~DeclarationStatementNode();
	void interpret();
private:
	IdentifierNode * mIN;
};

class AssignmentStatementNode : public StatementNode {
public:
	AssignmentStatementNode(IdentifierNode *in, ExpressionNode *en);
	virtual ~AssignmentStatementNode();
	void interpret();
private:
	IdentifierNode * mIN;
	ExpressionNode * mEN;
};

class CoutStatementNode : public StatementNode {
public:
	CoutStatementNode(ExpressionNode *en);
	virtual ~CoutStatementNode();
	void interpret();
private:
	ExpressionNode * mEN;
};

class IfStatementNode : public StatementNode {
public:
	IfStatementNode(ExpressionNode* en, StatementNode* sn1, StatementNode* sn2);
	virtual ~IfStatementNode();
	void interpret();
private:
	ExpressionNode* mEN;
	StatementNode* mSN1;
	StatementNode* mSN2;
};

class WhileStatementNode : public StatementNode {
public:
	WhileStatementNode(ExpressionNode *en, BlockNode* bn);
	virtual ~WhileStatementNode();
	void interpret();
private:
	ExpressionNode * mEN;
	BlockNode * mBN;
};

class IntegerNode : public ExpressionNode
{
public:
	IntegerNode(int value);
	virtual int evaluate() { return mValue; };
private:
	int mValue;
};

// arithmetic operators
class PlusNode : public BinaryOperatorNode {
public:
	PlusNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class MinusNode : public BinaryOperatorNode {
public:
	MinusNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class TimesNode : public BinaryOperatorNode {
public:
	TimesNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class DivideNode : public BinaryOperatorNode {
public:
	DivideNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};

// relational operators
class LessNode : public BinaryOperatorNode {
public:
	LessNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class GreaterNode : public BinaryOperatorNode {
public:
	GreaterNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class LessEqualNode : public BinaryOperatorNode {
public:
	LessEqualNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class GreaterEqualNode : public BinaryOperatorNode {
public:
	GreaterEqualNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class EqualNode : public BinaryOperatorNode {
public:
	EqualNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class NotEqualNode : public BinaryOperatorNode {
public:
	NotEqualNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class AndNode : public BinaryOperatorNode {
public:
	AndNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class OrNode : public BinaryOperatorNode {
public:
	OrNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class ExponentNode : public BinaryOperatorNode {
public:
	ExponentNode(ExpressionNode* left, ExpressionNode* right);
	int evaluate();
};
class NotNode : public ExpressionNode {
public:
	NotNode(ExpressionNode* en);
	~NotNode();
	int evaluate();
private:
	ExpressionNode * mEn;
};

