#include <cmath>
#include "glut.h"
#include "Rat.h"

extern viewtype current_view;
Rat::Rat()
{
}

void Rat::draw()
{
	if (current_view != rat_view)
	{
		glPushMatrix();
		glTranslated(mX, mY, 0);
		glRotated(mDegrees, 0, 0, 1);
		glColor3d(.5, .6, .7);
		DrawCircle(0, 0, mZ, .2);
		DrawCircle(.22, 0, mZ, .1);
		glPopMatrix();
	}
}

void Rat::init(Maze* pMaze)
{
	mX = .5;
	mY = .5;
	mZ = .01;
	mDX = cos((mDegrees/180)*3.14);
	mDY = sin((mDegrees/180)*3.14);
	mDZ = .01;
	mDegrees = 90;
	mHitRadius = .3;
	mpMaze = pMaze;
}

void Rat::spinLeft()
{	
	mDX = cos((mDegrees/180)*3.14);
	mDY = sin((mDegrees/180)*3.14);
	mDegrees += SPIN_SPEED;
}

void Rat::spinRight()
{	
	mDX = cos((mDegrees/180)*3.14);
	mDY = sin((mDegrees/180)*3.14);
	mDegrees -= SPIN_SPEED;
}
void Rat::strafeLeft()
{	
	mDX = cos((mDegrees/180)*3.14);
	mDY = sin((mDegrees/180)*3.14);
	double newX = mX - mDY * MOVE_SPEED;
	double newY = mY + mDX * MOVE_SPEED;
	if (mpMaze->isSafe(newX, newY, mHitRadius)) {
		mX = newX;
		mY = newY;
	}
	else if (mpMaze->isSafe(newX, mY, mHitRadius)) {
		mX = newX;
	}
	else if (mpMaze->isSafe(mX, newY, mHitRadius)) {
		mY = newY;
	}
}

void Rat::strafeRight()
{	
	mDX = cos((mDegrees/180)*3.14);
	mDY = sin((mDegrees/180)*3.14);
	double newX = mX + mDY * MOVE_SPEED;
	double newY = mY - mDX * MOVE_SPEED;
	if (mpMaze->isSafe(newX, newY, mHitRadius)) {
		mX = newX;
		mY = newY;
	}
	else if (mpMaze->isSafe(newX, mY, mHitRadius)) {
		mX = newX;
	}
	else if (mpMaze->isSafe(mX, newY, mHitRadius)) {
		mY = newY;
	}
}


void Rat::moveForward()
{
	mDX = cos((mDegrees/180)*3.14);
	mDY = sin((mDegrees/180)*3.14);
	double newX = mX + mDX * MOVE_SPEED;
	double newY = mY + mDY * MOVE_SPEED;
	if (mpMaze->isSafe(newX, newY, mHitRadius)) {
		mX = newX;
		mY = newY;
	}
	else if (mpMaze->isSafe(newX, mY, mHitRadius)) {
		mX = newX;
	}
	else if (mpMaze->isSafe(mX, newY, mHitRadius)) {
		mY = newY;
	}
}

void Rat::jumping()
{
	mZ += 2*mDZ;
	if (mZ > 1.2) {
		mZ = 1.2;
	}
}

void Rat::falling()
{
	mZ -= mDZ;
	if (mZ < .01) {
		mZ = .01;
	}
}


