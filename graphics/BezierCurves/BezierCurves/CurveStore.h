#pragma once
#include <vector>
#include "Bezier.h"
class CurveStore
{
public:
	CurveStore();
	~CurveStore();
	void addCurve();
	void removeCurve();
	void setCurveSelected(int s) { mCurveSelected = s; };
	void setControlPointSelected(int s) { mControlPointSelected = s; };
	int getCurveSelected() { return mCurveSelected; };
	int getControlPointSelected() { return mControlPointSelected; };
	void moveControlPoint(double x, double y);
	void drawCurves();
	bool selectControlPoint(double x, double y);
	void setSelectedCurveColor(double r, double g, double b);
private:
	std::vector<Bezier> mCurves;
	int mCurveSelected = -1;
	int mControlPointSelected = -1;
};

