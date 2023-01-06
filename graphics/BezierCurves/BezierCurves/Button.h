#pragma once
#include "main.h"
class Button
{
public:
	Button(double x1, double x2, double y1, double y2, const char* text);
	~Button();
	bool isClicked(double x, double y);
	void draw();
private:
	double mX1;
	double mX2;
	double mY1;
	double mY2;
	double mPadding;
	const char* mText;
};

