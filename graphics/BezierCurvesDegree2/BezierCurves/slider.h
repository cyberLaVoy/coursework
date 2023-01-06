#pragma once
class Slider
{
public:
	Slider(double left, double top, double right, double bottom,
			double low, double high, double current,
			double red, double green, double blue);
	double GetCurrentValue();
	void Draw();
	bool MouseDown(double wx, double wy);
private:
	double mLeft, mTop, mRight, mBottom;
	double mLow, mHigh, mCurrent;
	double mRed, mGreen, mBlue;
};