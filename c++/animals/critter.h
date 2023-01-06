#ifndef CRITTER_H
#define CRITTER_H

#include<vector>
#include<string>
class Critter {
public:
	/*Constructor*/
	Critter( int x, int y, int level );
	virtual ~Critter( );

	/*Get Methods*/
	int getX( ) const;
	int getY( ) const;
	int getFoodChainLevel( ) const;
	bool isAlive( ) const;
	virtual std::string getTextDisplay() = 0;
	
	/*Set Methods*/
	bool kill( );
	void setPosition( int x, int y );

	/*Other Methods*/
	bool positionAvailable( int x, int y, std::vector< Critter* >& critters, int width, int height );
	virtual bool move( std::vector< Critter* >& critters, int width, int height );
	virtual bool eat( std::vector< Critter* >& critters ) = 0;
	//virtual bool reproduce( std::vector< Critter* >& critters, CritterPtr& ) = 0;
	virtual bool reproduce( std::vector< Critter* >& critters) = 0;


protected:
	/*data members*/
	int mX;
	int mY;
	int mBreedStep;
	int mFoodChainLevel;
	bool mIsAlive;
};

#endif

