#ifndef COLORTABLE_H
#define COLORTABLE_H

#include<vector>
#include<cstdlib>

class Color {
public:
	/*Constructor*/
	Color( );
	Color( const int& red, const int& green, const int& blue );

	/*Get Methods*/
	int getRed( ) const;
	int getGreen( ) const;
	int getBlue( ) const;
	int getChannel( const int& channel ) const;
		
	/*Set Methods*/
	void setRed( const int& value );
	void setGreen( const int& value );
	void setBlue( const int& value );
	void setChannel( const int& channel, const int& value );	

	/*Other Methods*/
	void invert( const int& max_color_value );
	bool operator==( const Color& rhs ) const;

protected:
	/*data members*/
	int mRed;
	int mGreen;
	int mBlue;
};

class ColorTable {
public:
	/*Constructor*/
	ColorTable( const size_t& num_color );

	/*Get Methods*/
	size_t getNumberOfColors( ) const;
	
	/*Set Methods*/
	void setNumberOfColors( const size_t& num_color );

	/*Operators*/
	const Color& operator[]( const int& i ) const;
	Color& operator[]( const int& i );

	/*Other Methods*/
	void setRandomColor( const int& max_color_value, const size_t& position );
	void insertGradient( const Color& color1, const Color& color2, const size_t& position1, const size_t& position2 );

protected:
	/*data members*/
	std::vector<Color> mColors;
};

#endif

