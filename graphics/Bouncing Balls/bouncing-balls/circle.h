#pragma once

class circle
{
public:
	circle();
	circle(double x, double y, double mDX, double mDY, double radius, double red, double green, double blue, char state);
	~circle();
	
	double getx() const { return mX; }
	double gety() const { return mY; }
	double getradius() const { return mRadius; }
	double getdx() const { return mDX; }
	double getdy() const { return mDY; }
	double getnextx() const { return mX + mDX; }
	double getnexty() const { return mY + mDY; }
	double getRed() { return mRed; }
	double getGreen() { return mGreen; }
	double getBlue() { return mBlue; }
	double getState() const { return mState; }

	void setdx(double dx) { mDX = dx; }
	void setdy(double dy) { mDY = dy; }
	void setRed(double red) { mRed = red; }
	void setGreen(double green) { mGreen = green; }
	void setBlue(double blue) { mBlue = blue; }

	void draw();
	void move();
	bool checkBallToBallCollisionGen(const std::vector<circle>& balls);
	bool willCollide(const circle& other);
	void collide(circle& other);
	void applyForces();
	bool checkBallToWallCollision(double screen_x, double screen_y);
	bool checkBallToBallCollisionSim(int me_index, std::vector<circle>& balls);
	void bounce(double screen_x, double screen_y, int me_index, std::vector<circle>& balls);
	
	void switchColors(circle& other);
	void makeRed();
	void makeBlue();
	void fadeToWhite();

protected:
	double mX;
	double mY;
	double mDX;
	double mDY;
	double mRadius;
	double mRed;
	double mGreen;
	double mBlue;
	char mState;
};

