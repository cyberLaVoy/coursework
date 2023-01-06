
#include "critter.h"
#include "lion.h"

/*Constructor*/
Lion::Lion( int x, int y ) 
	: Critter(x, y, 10), mMissedMealCount(0)
{
}
Lion::~Lion( ) 
{
}

/*Get Methods*/
int Lion::getMissedMealCount( ) const {
	return mMissedMealCount;
}

std::string Lion::getTextDisplay() {
	return "L";
}


/*Other Methods*/
Critter* Lion::findNeighborPrey( std::vector< Critter* >& critters ) const {
	Critter* critter = 0;
	for (unsigned int i = 0; i < critters.size(); i++) {
	if (!critter) {
		int critterX = critters[i]->getX();
		int critterY = critters[i]->getY();
		if (critterX == mX && (critterY == mY +1 || critterY == mY -1)) {
			if (critters[i]->isAlive() && critters[i]->getFoodChainLevel() < mFoodChainLevel) {
				critter = critters[i];
			}	
		}
		else if (critterY == mY && (critterX == mX +1 || critterX == mX -1)) {
			if (critters[i]->isAlive() && critters[i]->getFoodChainLevel() < mFoodChainLevel) {
				critter = critters[i];
			}	
		}
	}
	}
	return critter;
}

bool Lion::eat( std::vector< Critter* >& critters ) {
	bool fed = false;
	Critter* prey = findNeighborPrey(critters);
	if (prey) {
		prey->kill();
		setPosition(prey->getX(), prey->getY());	
		mMissedMealCount = 0;
		fed = true;
	}
	else {
		mMissedMealCount++;

	}
	if (mMissedMealCount == 3) {
		kill();
	}
	return fed;
}
bool Lion::reproduce( std::vector< Critter* >& critters ) {
	(void)critters;
	return false;
}


/*data members
unsigned int mMissedMealCount;
*/
