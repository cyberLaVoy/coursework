#include "glut.h"
#include "slider.h"
#include "main.h"

Slider::Slider(double left, double top, double right, double bottom,
	double low, double high, double current,
	double red, double green, double blue) :
	mLeft(left), mTop(top), mRight(right), mBottom(bottom),
	mLow(low), mHigh(high), mCurrent(current),
	mRed(red),mGreen(green), mBlue(blue)
{

}
double Slider::GetCurrentValue()
{
	return mCurrent;
}

void Slider::Draw()
{
	// Draw the inside:
	glColor3d(mRed, mGreen, mBlue);
	double ratio = (mCurrent - mLow) / (mHigh - mLow);
	double newRight = mLeft + (mRight - mLeft)*ratio;
	DrawRectangle(mLeft, mTop, newRight, mBottom);
	// Draw the outline:
	glColor3d(0, 0, 0);
	glBegin(GL_LINE_LOOP);
	glVertex2d(mLeft, mTop);
	glVertex2d(mRight, mTop);
	glVertex2d(mRight, mBottom);
	glVertex2d(mLeft, mBottom);
	glEnd();
}

bool Slider::MouseDown(double wx, double wy)
{
	if (wx >= mLeft && wx <= mRight &&
		wy >= mBottom && wy <= mTop)
	{
		double ratio = (wx - mLeft) / (mRight - mLeft);
		mCurrent = mLow + (mHigh - mLow)*ratio;
		return true;
	}
	return false;

}