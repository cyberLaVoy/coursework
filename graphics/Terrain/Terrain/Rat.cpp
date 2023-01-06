#include <cmath>
#include "glut.h"
#include "Rat.h"

extern viewtype current_view;
Rat::Rat()
{
	mX = .5;
	mY = .5;
	mDX = cos((mDegrees/180)*3.14);
	mDY = sin((mDegrees/180)*3.14);
	mDegrees = 90;
	mHitRadius = .3;
}

void Rat::draw()
{
	if (current_view != rat_view)
	{
		glPushMatrix();
		glTranslated(mX, mY, 0);
		glRotated(mDegrees, 0, 0, 1);
		glColor3d(.5, .6, .7);
		double z = zValue(getX(), getY());
		if (z < 0) {
			z = 0;
		}
		z += 8;
		DrawCircle(0, 0, z, 3);
		DrawCircle(3, 0, z, 2);
		glPopMatrix();
	}
}


void Rat::spinLeft()
{	
	mDegrees += SPIN_SPEED;
	mDX = cos((mDegrees/180)*3.14);
	mDY = sin((mDegrees/180)*3.14);
}

void Rat::spinRight()
{	
	mDegrees -= SPIN_SPEED;
	mDX = cos((mDegrees/180)*3.14);
	mDY = sin((mDegrees/180)*3.14);
}

void Rat::moveForward()
{
	mDX = cos((mDegrees/180)*3.14);
	mDY = sin((mDegrees/180)*3.14);
	double newX = mX + mDX * MOVE_SPEED;
	double newY = mY + mDY * MOVE_SPEED;
	mX = newX;
	mY = newY;

}


