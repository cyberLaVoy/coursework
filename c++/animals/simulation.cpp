
#include"simulation.h"

#include <cstdlib>
#include <string>


/*Constructor and destructor*/
Simulation::Simulation( int width, int height ) : mWidth(width), mHeight(height) {
	for (int x = 0; x < width; x++) {
		for (int y = 0; y < height; y++) {
			int r = std::rand( );
			r = r % 100;
			r = r + 1;
			if (r <= 40) {
				Zebra *z = new Zebra (x, y);
				mCritters.push_back(z);
				// create Zebra
			}
			else if (r >= 75) {
				// create Lion
				Lion *l = new Lion (x, y);
				mCritters.push_back(l);
			}
			else {
				// do nothing
			}
		}
	}
}
Simulation::~Simulation( ) {
	for (size_t i = 0; i < mCritters.size() ; i++) {
		delete mCritters[i];
	}
}

/*Get Methods*/
std::vector<Critter *> Simulation::getCritters() {
	return mCritters;
}
/*Other Methods*/
void Simulation::eatAll( ) {
	for (size_t i = 0; i < mCritters.size() ; i++) {
		mCritters[i]->eat(mCritters);
	}
}
void Simulation::reproduceAll( ) {
	for (size_t i = 0; i < mCritters.size() ; i++) {
		mCritters[i]->reproduce(mCritters);
	}
}
void Simulation::moveAll( ) {
	for (size_t i = 0; i < mCritters.size() ; i++) {
		mCritters[i]->move(mCritters, mWidth, mHeight);
	}
}
void Simulation::removeDead( ) {
	size_t i = 0;
	while ( i < mCritters.size() ) {
		if ( ! mCritters[i]->isAlive() ) {
			Critter* temp = mCritters[i];
			mCritters[i] = mCritters[mCritters.size()-1];
			mCritters[mCritters.size()-1] = temp;
			
			delete mCritters[mCritters.size()-1];
			mCritters.pop_back();
		}
		else {
			i++;
		}
	}
}

void Simulation::step( ) {
	eatAll();
	reproduceAll();
	moveAll();
	removeDead();
}

std::string Simulation::textDisplay() const {
	std::string display_text;
	for (int y = 0; y < mHeight; y++) {
		for (int x = 0; x < mWidth; x++) {
			std::string print_char = ".";	
			int critter_x;
			int critter_y;
			for (size_t i = 0; i < mCritters.size(); i++) {
				critter_x = mCritters[i]->getX();
				critter_y = mCritters[i]->getY();
				if (critter_x == x && critter_y == y) {
					print_char = mCritters[i]->getTextDisplay();
				}
			}

		display_text += print_char;
		}
		display_text += "\n";
	}
	return display_text;
}

/*data members
int mWidth;
int mHeight;
std::vector<Critter*> mCritters;
*/

