
#include <math.h>
#include <vector>
#include "glut.h"
#include "circle.h"

circle::circle()
{
}

circle::circle(double x, double y, double DX, double DY, double r, double red, double green, double blue, char state) 
	: mX(x), mY(y), mDX(DX), mDY(DY), mRadius(r), mRed(red), mGreen(green), mBlue(blue), mState(state)
{
}

circle::~circle()
{
}


void circle::draw() {
	glBegin(GL_POLYGON);
	glColor3d(mRed,mGreen,mBlue);
	for (int i = 0; i<32; i++) {
		double theta = (double)i / 32.0 * 2.0 * 3.1415926;
		double x = mX + mRadius * cos(theta);
		double y = mY + mRadius * sin(theta);
		glVertex2d(x, y);
	}
	glEnd();
}

void circle::move()
{
	mX += mDX;
	mY += mDY;
}

void circle::applyForces() {
	//gravity	
	mDY -= .001;

	//air resistance
	double air_friction = .9999;
	mDX *= air_friction;
	mDY *= air_friction;
}

bool circle::checkBallToWallCollision(double screen_x, double screen_y)
{
	bool collide = false;
	if (mX + mDX + mRadius > screen_x) {
		mDX = -mDX;
		collide = true;
	}
	if (mX + mDX < mRadius) {
		mDX = -mDX;
		collide = true;
	}
	if (mY + mDY + mRadius > screen_y) {
		mDY = -mDY;
		collide = true;
	}
	if (mY + mDY < mRadius) {
		mDY = -mDY;
		collide = true;
	}
	return collide;
}


bool circle::willCollide(const circle& other) {
	double x1 = getnextx();
	double x2 = other.getnextx();
	double y1 = getnexty();
	double y2 = other.getnexty();
	double r1 = mRadius;
	double r2 = other.getradius();

	double distance = sqrt((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1));
	if (distance <= r1 + r2 && (getState() == other.getState())) {
		return true;
	}
	else {
		return false;
	}
}

bool circle::checkBallToBallCollisionGen(const std::vector<circle>& balls) {
	for (size_t i = 0; i < balls.size(); i++) {
		if (willCollide(balls[i])) {
			return true;
		}
	}
	return false;
}
bool circle::checkBallToBallCollisionSim(int me_index, std::vector<circle>& balls) {
	bool collision = false;
	for (size_t i = me_index+1; i < balls.size(); i++) {
		if (willCollide(balls[i])) {
			makeRed();
			balls[i].makeRed();
			collide(balls[i]);
			collision = true;
		}
		else {
			fadeToWhite();
			balls[i].fadeToWhite();
		}
	}
	return collision;
}

void circle::bounce(double screen_x, double screen_y, int me_index, std::vector<circle>& balls) {
	applyForces();
	checkBallToWallCollision(screen_x, screen_y);
	checkBallToBallCollisionSim(me_index, balls);
	move();
	draw();
}

void circle::switchColors(circle& other)
{
	double tempB = mBlue;
	double tempG = mGreen;
	double tempR = mRed;
	mBlue = other.getBlue();
	mRed = other.getRed();
	mGreen = other.getGreen();
	other.setBlue(tempB);
	other.setRed(tempR);
	other.setGreen(tempG);
}

void circle::makeRed()
{
	setRed(1);
	setGreen(0);
	setBlue(0);
}

void circle::makeBlue()
{
	setRed(0);
	setGreen(0);
	setBlue(1);
}

void circle::fadeToWhite()
{
	double dColor = .001;
	mRed += dColor;
	mBlue += dColor;
	mGreen += dColor;
	if (mRed > 1) {
		mRed = 1;
	}
	if (mGreen > 1) {
		mGreen = 1;
	}
	if (mBlue > 1) {
		mBlue = 1;
	}
}

void circle::collide(circle& other) {

	const double COLLISION_FRICTION = 1.0;
	struct vectortype 
	{
		double x;
		double y;
	};

	vectortype en; // Center of Mass coordinate system, normal component
	vectortype et; // Center of Mass coordinate system, tangential component
	vectortype u[2]; // initial velocities of two particles
	vectortype um[2]; // initial velocities in Center of Mass coordinates
	double umt[2]; // initial velocities in Center of Mass coordinates, tangent component
	double umn[2]; // initial velocities in Center of Mass coordinates, normal component
	vectortype v[2]; // final velocities of two particles
	double m[2];	// mass of two particles
	double M; // mass of two particles together
	vectortype V; // velocity of two particles together
	double size;
	int i;

	double xdif = getnextx() - other.getnextx();
	double ydif = getnexty() - other.getnexty();

	// set Center of Mass coordinate system
	size = sqrt(xdif*xdif + ydif*ydif);
	xdif /= size; ydif /= size; // normalize
	en.x = xdif;
	en.y = ydif;
	et.x = ydif;
	et.y = -xdif;

	// set u values
	u[0].x = getdx();
	u[0].y = getdy();
	m[0] = getradius()*getradius();
	u[1].x = other.getdx();
	u[1].y = other.getdy();
	m[1] = other.getradius()*other.getradius();

	// set M and V
	M = m[0] + m[1];
	V.x = (u[0].x*m[0] + u[1].x*m[1]) / M;
	V.y = (u[0].y*m[0] + u[1].y*m[1]) / M;

	// set um values
	um[0].x = m[1] / M * (u[0].x - u[1].x);
	um[0].y = m[1] / M * (u[0].y - u[1].y);
	um[1].x = m[0] / M * (u[1].x - u[0].x);
	um[1].y = m[0] / M * (u[1].y - u[0].y);

	// set umt and umn values
	for (i = 0; i<2; i++)
	{
		umt[i] = um[i].x * et.x + um[i].y * et.y;
		umn[i] = um[i].x * en.x + um[i].y * en.y;
	}

	// set v values
	for (i = 0; i<2; i++)
	{
		v[i].x = umt[i] * et.x - umn[i] * en.x + V.x;
		v[i].y = umt[i] * et.y - umn[i] * en.y + V.y;
	}

	// reset particle values
	setdx(v[0].x*COLLISION_FRICTION);
	setdy(v[0].y*COLLISION_FRICTION);
	other.setdx(v[1].x*COLLISION_FRICTION);
	other.setdy(v[1].y*COLLISION_FRICTION);

} /* Collide */


