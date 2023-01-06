#include "Node.h"

StatementGroupNode::StatementGroupNode()
{
}
StatementGroupNode::~StatementGroupNode()
{
	for (size_t i = 0; i < mSNs.size(); i++) {
		delete mSNs[i];
	}
}
void StatementGroupNode::addStatement(StatementNode * sn)
{
	mSNs.push_back(sn);
}

void StatementGroupNode::interpret()
{
	for (size_t i = 0; i < mSNs.size(); i++) {
		mSNs[i]->interpret();
	}
}



BinaryOperatorNode::BinaryOperatorNode(ExpressionNode * left, ExpressionNode * right) : mLeft(left), mRight(right)
{
}
BinaryOperatorNode::~BinaryOperatorNode()
{
	MSG("BinaryOperatorNode destructor called."); //preprocessor macro
	delete mLeft;
	delete mRight;
}

IdentifierNode::IdentifierNode(std::string label, SymbolTableClass* st) : mLabel(label), mSymbolTable(st)
{
}

void IdentifierNode::declareVariable()
{
	mSymbolTable->AddEntry(mLabel);
}
void IdentifierNode::setValue(int v)
{
	mSymbolTable->SetValue(mLabel, v);
}
int IdentifierNode::getIndex()
{
	return mSymbolTable->GetIndex(mLabel);
}
int IdentifierNode::evaluate()
{
	return mSymbolTable->GetValue(mLabel);
}
IntegerNode::IntegerNode(int value) : mValue(value)
{
}


CoutStatementNode::CoutStatementNode(ExpressionNode * en) : mEN(en)
{
}
CoutStatementNode::~CoutStatementNode()
{
	MSG("CoutStatmentNode destructor called."); //preprocessor macro
	delete mEN;
}
void CoutStatementNode::interpret()
{
	std::cout << mEN->evaluate() << std::endl;
}

IfStatementNode::IfStatementNode(ExpressionNode * en, StatementNode* sn1, StatementNode* sn2) : mEN(en), mSN1(sn1), mSN2(sn2)
{
}
IfStatementNode::~IfStatementNode()
{
	MSG("IfStatmentNode destructor called."); //preprocessor macro
	delete mEN;
	delete mSN1;
	delete mSN2;
}
void IfStatementNode::interpret()
{
	if (mEN->evaluate()) {
		mSN1->interpret();
	}
	else {
		mSN2->interpret();
	}
}

WhileStatementNode::WhileStatementNode(ExpressionNode * en, BlockNode* bn) : mEN(en), mBN(bn)
{
}
WhileStatementNode::~WhileStatementNode()
{
	MSG("WhileStatmentNode destructor called."); //preprocessor macro
	delete mEN;
	delete mBN;
}
void WhileStatementNode::interpret()
{
	while (mEN->evaluate()) {
		mBN->interpret();
	}
}

AssignmentStatementNode::AssignmentStatementNode(IdentifierNode * in, ExpressionNode * en) : mIN(in), mEN(en)
{
}
AssignmentStatementNode::~AssignmentStatementNode()
{
	MSG("AssignmentStatmentNode destructor called."); //preprocessor macro
	delete mIN;
	delete mEN;
}

void AssignmentStatementNode::interpret()
{
	int value = mEN->evaluate();
	mIN->setValue(value);
}

DeclarationStatementNode::DeclarationStatementNode(IdentifierNode * in) : mIN(in)
{
}
DeclarationStatementNode::~DeclarationStatementNode()
{
	MSG("DeclarationStatmentNode destructor called."); //preprocessor macro
	delete mIN;
}

void DeclarationStatementNode::interpret()
{
	mIN->declareVariable();
}

BlockNode::BlockNode(StatementGroupNode * sgn) : mSGN(sgn)
{
}
BlockNode::~BlockNode()
{
	MSG("BlockNode destructor called."); //preprocessor macro
	delete mSGN;
}

void BlockNode::interpret()
{
	mSGN->interpret();
}

ProgramNode::ProgramNode(BlockNode * bn) : mBN(bn)
{
}
ProgramNode::~ProgramNode()
{
	MSG("ProgramNode destructor called."); //preprocessor macro
	delete mBN;
}

void ProgramNode::interpret()
{
	mBN->interpret();
}

StartNode::StartNode(ProgramNode * pn) : mPN(pn)
{
}
StartNode::~StartNode()
{
	MSG("StartNode destructor called."); //preprocessor macro
	delete mPN;
}

void StartNode::interpret()
{
	mPN->interpret();
}

// arithmetic operators
PlusNode::PlusNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right)
{
}
int PlusNode::evaluate()
{
	return mLeft->evaluate() + mRight->evaluate();
}

MinusNode::MinusNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int MinusNode::evaluate()
{
	return mLeft->evaluate() - mRight->evaluate();
}

TimesNode::TimesNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int TimesNode::evaluate()
{
	return mLeft->evaluate() * mRight->evaluate();
}

DivideNode::DivideNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int DivideNode::evaluate()
{
	return mLeft->evaluate() / mRight->evaluate();
}


// relational operators
LessNode::LessNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int LessNode::evaluate()
{
	return mLeft->evaluate() < mRight->evaluate();
}

GreaterNode::GreaterNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int GreaterNode::evaluate()
{
	return mLeft->evaluate() > mRight->evaluate();
}

LessEqualNode::LessEqualNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int LessEqualNode::evaluate()
{
	return mLeft->evaluate() <= mRight->evaluate();
}

GreaterEqualNode::GreaterEqualNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int GreaterEqualNode::evaluate()
{
	return mLeft->evaluate() >= mRight->evaluate();
}

EqualNode::EqualNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int EqualNode::evaluate()
{
	return mLeft->evaluate() == mRight->evaluate();
}

NotEqualNode::NotEqualNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int NotEqualNode::evaluate()
{
	return mLeft->evaluate() != mRight->evaluate();
}

AndNode::AndNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int AndNode::evaluate()
{
	return mLeft->evaluate() && mRight->evaluate();
}

OrNode::OrNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int OrNode::evaluate()
{
	return mLeft->evaluate() || mRight->evaluate();
}

ExponentNode::ExponentNode(ExpressionNode * left, ExpressionNode * right) : BinaryOperatorNode(left, right) 
{
}
int ExponentNode::evaluate()
{
	int value = 1;
	for (size_t i = 0; i < mRight->evaluate(); i++) {
		value *= mLeft->evaluate();
	}
	return value;
}

NotNode::NotNode(ExpressionNode* en) : mEn(en)
{
}
NotNode::~NotNode()
{
	MSG("NotNode destructor called."); //preprocessor macro
	delete mEn;
}
int NotNode::evaluate()
{
	if (mEn->evaluate() == 0) {
		return 1;
	}
	else {
		return 0;
	}
}