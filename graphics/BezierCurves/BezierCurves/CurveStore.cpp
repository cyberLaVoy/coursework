#include "CurveStore.h"



CurveStore::CurveStore()
{
}


CurveStore::~CurveStore()
{
}

void CurveStore::addCurve()
{
	Bezier curve(mCurves.size() * 10);
	mCurves.push_back(curve);
}

void CurveStore::removeCurve()
{
	if (mCurveSelected != -1) {
		Bezier temp = mCurves[mCurveSelected];
		mCurves[mCurveSelected] = mCurves[mCurves.size() - 1];
		mCurves[mCurves.size() - 1] = temp;
		mCurves.pop_back();
		mCurveSelected = -1;
	}
}

void CurveStore::moveControlPoint(double x, double y)
{
	if (mCurveSelected != -1 && mControlPointSelected != -1) {
		mCurves[mCurveSelected].moveControlPoint(mControlPointSelected, x, y);
	}
}

void CurveStore::drawCurves()
{
	for (size_t i = 0; i < mCurves.size(); i++) {
		if (i == mCurveSelected) {
			glColor3d(1, 0, 0);
		}
		else {
			glColor3d(mCurves[i].getRed(), mCurves[i].getGreen(),mCurves[i].getBlue());
		}
		mCurves[i].drawControlPoints();
		glColor3d(mCurves[i].getRed(), mCurves[i].getGreen(),mCurves[i].getBlue());
		mCurves[i].drawCurve(25);
	}
}

bool CurveStore::selectControlPoint(double x, double y)
{
	for (size_t i = 0; i < mCurves.size(); i++) {
		int cp = mCurves[i].isPicked(x, y);
		if ( cp != -1) {
			this->setCurveSelected(i);
			this->setControlPointSelected(cp);
			return true;
		}
	}	
	return false;
}

void CurveStore::setSelectedCurveColor(double r, double g, double b)
{
	if (mCurveSelected != -1) {
		mCurves[mCurveSelected].setRed(r);
		mCurves[mCurveSelected].setGreen(g);
		mCurves[mCurveSelected].setBlue(b);
	}
}
