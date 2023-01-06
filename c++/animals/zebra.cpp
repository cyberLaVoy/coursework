
#include "critter.h"
#include "zebra.h"


/*Constructor*/
Zebra::Zebra( int x, int y )
	: Critter(x, y, 5)
{
}
Zebra::~Zebra( ) {
}


/*Get Methods*/
std::string Zebra::getTextDisplay() {
	return "Z";
}
/*Other Methods*/
bool Zebra::eat( std::vector< Critter* >& critters ) {
	(void)critters;
	return false;
}
bool Zebra::reproduce( std::vector< Critter* >& critters ) {
	(void)critters;
	return false;
}


