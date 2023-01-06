#include "Button.h"
#include "glut.h"


Button::Button(double x1, double x2, double y1, double y2, const char * text)
	: mX1(x1), mX2(x2), mY1(y1), mY2(y2), mText(text)
{
	mPadding = 10;
}

Button::~Button()
{
}

bool Button::isClicked(double x, double y)
{
	if (x >= mX1 && x <= mX2) {
		if (y >= mY1 && y <= mY2) {
			return true;
		}
	}
	return false;
}

void Button::draw()
{
	glColor3d(0, 0, 0);
	DrawRectangle(mX1, mY1, mX2, mY2);
	glColor3d(1, 1, 1);
	DrawText(mX1+mPadding, mY1+mPadding, mText);
}
