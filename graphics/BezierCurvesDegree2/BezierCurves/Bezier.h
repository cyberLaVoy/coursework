#pragma once
#include "Point2.h"
#include "glut.h"
#include "main.h"
#include <vector>

class Bezier
{
public:
	Bezier(int startPoint);
	~Bezier();
	Point2 evaluate(double t);
	void drawCurve(int pointDensity);
	void drawControlPoints();
	int isPicked(double x, double y);
	void moveControlPoint(size_t cp, double x, double y);
	double getCPRadius() { return mControlPointsRadius; }
	double getRed() { return mR; };
	double getGreen() { return mG; };
	double getBlue() { return mB; };
	void setRed(double r) { mR = r; };
	void setGreen(double g) { mG = g; };
	void setBlue(double b) { mB = b; };

private:
	Point2 mControlPoints[3];
	double mControlPointsRadius;
	double mR;
	double mG;
	double mB;
};

