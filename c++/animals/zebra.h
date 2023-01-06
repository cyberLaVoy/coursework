#ifndef ZEBRA_H
#define ZEBRA_H

#include "critter.h"
#include <string>
class Zebra : public Critter {
public:
	/*Constructor*/
	Zebra( int x, int y );
	virtual ~Zebra( );

	/*Get Methods*/
	std::string getTextDisplay();

	/*Set Methods*/

	/*Other Methods*/
	virtual bool eat( std::vector< Critter* >& critters );
	//virtual bool reproduce( std::vector< Critter* >& critters, CritterPtr& );
	virtual bool reproduce( std::vector< Critter* >& critters);

protected:
	/*data members*/
};

#endif

