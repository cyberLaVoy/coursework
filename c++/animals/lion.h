#ifndef LION_H
#define LION_H

#include "critter.h"
#include <string>
class Lion : public Critter {
public:
	/*Constructor*/
	Lion( int x, int y );
	virtual ~Lion( );

	/*Get Methods*/
	int getMissedMealCount( ) const;
	std::string getTextDisplay();
	
	/*Set Methods*/


	/*Other Methods*/
	Critter *findNeighborPrey( std::vector< Critter* >& critters ) const;
	virtual bool eat( std::vector< Critter* >& critters );
	//virtual bool reproduce( std::vector< Critter* >& critters, CritterPtr& );
	virtual bool reproduce( std::vector< Critter* >& critters);


protected:
	/*data members*/
	unsigned int mMissedMealCount;
};

#endif

