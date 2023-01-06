#pragma once
#include "Maze.h"

const double SPIN_SPEED = .5;
const double MOVE_SPEED = .003;
class Rat
{
public:
	Rat();
	void draw();
	void init(Maze* pMaze);
	void spinLeft();
	void spinRight();
	void strafeLeft();
	void strafeRight();
	void moveForward();
	void jumping();
	void falling();
	double getHitRadus() { return mHitRadius; };
	double getX() { return mX; };
	double getY() { return mY; };
	double getZ() { return mZ; };
	double getDX() { return mDX; };
	double getDY() { return mDY; };
	double getDZ() { return mDZ; };
	
	void setX(double x) { mX = x; };
	void setY(double y) { mY = y; };

private:
	double mX, mY, mZ, mDegrees, mDX, mDY, mDZ;
	double mHitRadius;
	Maze* mpMaze;
};