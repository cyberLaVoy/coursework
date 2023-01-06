
#include "critter.h"
#include <cstdlib>

/*Constructor*/
Critter::Critter( int x, int y, int level ) 
	: mBreedStep(0), mFoodChainLevel(level), mIsAlive(true)
{
	if (x >= 0) {
		mX = x;
	}
	else {
		mX = 0;
	}
	if (y >= 0) {
		mY = y;
	}
	else {
		mY = 0;
	}
}
Critter::~Critter( ) 
{
}

/*Get Methods*/
int Critter::getX( ) const {
	return mX;
}
int Critter::getY( ) const {
	return mY;
}
int Critter::getFoodChainLevel( ) const {
	return mFoodChainLevel;
}
bool Critter::isAlive( ) const {
	return mIsAlive;
}

/*Set Methods*/
bool Critter::kill( ) {
	bool killed = false;
	if (mIsAlive) {
		mIsAlive = false;
		killed = true;
	}
	return killed;
}
void Critter::setPosition( int x, int y ) {
	mX = x;
	mY = y;
}

/*Other Methods*/
bool Critter::positionAvailable( int x, int y, std::vector< Critter* >& critters, int width, int height ) {
	bool available = true;
	if (x >= width || y >= height || x < 0 || y < 0) {
		available = false;
	}
	if (available) {
		for (unsigned int i = 0; i < critters.size(); i++) {
			if (critters[i]->getX() == x && critters[i]->getY() == y) {
				available = false;
			}
		}
	}
	return available;
}
bool Critter::move( std::vector< Critter* >& critters, int width, int height ) {
	bool moved = false;
	bool option1 = false;
	bool option2 = false;
	bool option3 = false;
	bool option4 = false;
	bool open_position = false;

	if (positionAvailable(mX, mY-1, critters, width, height)) {
		option1 = true;
		open_position = true;
	}
	if (positionAvailable(mX, mY+1, critters, width, height)) {
		option2 = true;
		open_position = true;
	}
	if (positionAvailable(mX-1, mY, critters, width, height)) {
		option3 = true;
		open_position = true;
	}
	if (positionAvailable(mX+1, mY, critters, width, height)) {
		option4 = true;
		open_position = true;
	}
	
	while (! moved && open_position && mIsAlive) {

		int v = std::rand( );
		v = v % 4;
		if (v == 0 && option1) {
			setPosition(mX, mY-1);	
			moved = true;
		}
		if (v == 1 && option2) {
			setPosition(mX, mY+1);	
			moved = true;
		}
		if (v == 2 && option3) {
			setPosition(mX-1, mY);	
			moved = true;
		}
		if (v == 3 && option4) {
			setPosition(mX+1, mY);	
			moved = true;
		}
	}	
	return moved;
}


/*data members
int mX;
int mY;
int mBreedStep;
int mFoodChainLevel;
bool mIsAlive;
*/

