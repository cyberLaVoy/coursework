#pragma once
class Point2
{
public:
	Point2();
	Point2(int x, int y);
	~Point2();
	void setX(double x) { mX = x; };
	void setY(double y) { mY = y; };
	double getX() { return mX; };
	double getY() { return mY; };
private:
	double mX;
	double mY;
};

