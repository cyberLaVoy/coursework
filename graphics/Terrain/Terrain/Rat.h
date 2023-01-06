#pragma once
#include "Main.h"
const double SPIN_SPEED = 5;
const double MOVE_SPEED = 1;
class Rat
{
public:
	Rat();
	void draw();
	void spinLeft();
	void spinRight();
	void moveForward();
	double getHitRadus() { return mHitRadius; };
	double getX() { return mX; };
	double getY() { return mY; };
	double getDX() { return mDX; };
	double getDY() { return mDY; };
	
	void setX(double x) { mX = x; };
	void setY(double y) { mY = y; };

private:
	double mX, mY, mDegrees, mDX, mDY;
	double mHitRadius;
};