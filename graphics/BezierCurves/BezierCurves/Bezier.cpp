#include "Bezier.h"

Bezier::Bezier(int startPoint)
{
	mControlPointsRadius = 7;
	mControlPoints[0].setX(startPoint + 150);
	mControlPoints[0].setY(startPoint + 100);
	mControlPoints[1].setX(startPoint + 200);
	mControlPoints[1].setY(startPoint + 200);
	mControlPoints[2].setX(startPoint + 300);
	mControlPoints[2].setY(startPoint + 300);
	mControlPoints[3].setX(startPoint + 350);
	mControlPoints[3].setY(startPoint + 400);
	mR = 0;
	mG = 0;
	mB = 0;
}

Bezier::~Bezier()
{
}

Point2 Bezier::evaluate(double t)
{
	Point2 calcPoint;
	double calcPointX;
	double calcPointY;
	double P0X = mControlPoints[0].getX();
	double P1X = mControlPoints[1].getX();
	double P2X = mControlPoints[2].getX();
	double P3X = mControlPoints[3].getX();
	double P0Y = mControlPoints[0].getY();
	double P1Y = mControlPoints[1].getY();
	double P2Y = mControlPoints[2].getY();
	double P3Y = mControlPoints[3].getY();
	calcPointX = P0X * (1 - t)*(1 - t)*(1 - t) + 3 * P1X*(1 - t)*(1 - t)*t + 3 * P2X*(1 - t)*t*t + P3X * t*t*t;
	calcPointY = P0Y * (1 - t)*(1 - t)*(1 - t) + 3 * P1Y*(1 - t)*(1 - t)*t + 3 * P2Y*(1 - t)*t*t + P3Y * t*t*t;
	calcPoint.setX(calcPointX);
	calcPoint.setY(calcPointY);
	return calcPoint;
}

void Bezier::drawCurve(int pointDensity)
{
	double dt = 1 / (double)pointDensity;
	double t = 0;
	glBegin(GL_LINE_STRIP);
	for (int i = 0; i < pointDensity-1; i++)
	{
		t += dt;
		Point2 evalPoint = evaluate(t);
		double x = evalPoint.getX();
		double y = evalPoint.getY();
		glVertex2d(x, y);
	}
	glEnd();
}

void Bezier::drawControlPoints()
{
	double radius = mControlPointsRadius;
	DrawCircle(mControlPoints[0].getX(), mControlPoints[0].getY(), radius);
	DrawCircle(mControlPoints[1].getX(), mControlPoints[1].getY(), radius);
	DrawCircle(mControlPoints[2].getX(), mControlPoints[2].getY(), radius);
	DrawCircle(mControlPoints[3].getX(), mControlPoints[3].getY(), radius);
}

int Bezier::isPicked(double x, double y)
{
	for (int i = 0; i < 4; i++) {
		double cpX = mControlPoints[i].getX();
		double cpY = mControlPoints[i].getY();
		double distance = sqrt((cpX - x)*(cpX - x) + (cpY - y)*(cpY - y));
		if (distance <= mControlPointsRadius) {
			return i;
		}
	}
	return -1;
}

void Bezier::moveControlPoint(size_t cp, double x, double y)
{
	mControlPoints[cp].setX(x);
	mControlPoints[cp].setY(y);
}