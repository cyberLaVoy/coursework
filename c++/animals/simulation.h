#ifndef SIMULATION_H
#define SIMULATION_H

#include<vector>
#include"lion.h"
#include"zebra.h"

class Simulation {
public:
	/*Constructor and destructor*/
	Simulation( int width, int height );
	virtual ~Simulation( );

	/*Get Methods*/
	std::vector<Critter *> getCritters();
	
	/*Set Methods*/

	/*Other Methods*/
	void eatAll( );
	void reproduceAll( );
	void moveAll( );
	void removeDead( );

	void step( );

	std::string textDisplay() const;


protected:
	/*data members*/
	int mWidth;
	int mHeight;
	std::vector<Critter*> mCritters;
};

#endif

