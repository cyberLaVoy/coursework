
#include "colorTable.h"
#include <ctime>
#include <math.h>

/*COLOR CLASS*/

/*Constructor*/
Color::Color( ) 
	: mRed(0), mGreen(0), mBlue(0)
{
}
Color::Color( const int& red, const int& green, const int& blue ) 
	: mRed(red), mGreen(green), mBlue(blue)
{
}

/*Get Methods*/
int Color::getRed( ) const {
	return mRed;
}
int Color::getGreen( ) const {
	return mGreen;
}
int Color::getBlue( ) const {
	return mBlue;
}
int Color::getChannel( const int& channel ) const {
	int channel_value = -1;
	if (channel == 0) {
		channel_value = mRed;
	}
	if (channel == 1) {
		channel_value = mGreen;
	}
	if (channel == 2) {
		channel_value = mBlue;
	}
	return channel_value;
}
	
/*Set Methods*/
void Color::setRed( const int& value ) {
	if (value >= 0) {
		mRed = value;
	}
}
void Color::setGreen( const int& value ) {
	if (value >= 0) {
		mGreen = value;
	}
}
void Color::setBlue( const int& value ) {
	if (value >= 0) {
		mBlue = value;
	}
}
void Color::setChannel( const int& channel, const int& value ) {
	if (value >= 0) {
		if (channel == 0) {
			mRed = value;
		}
		if (channel == 1) {
			mGreen = value;
		}
		if (channel == 2) {
			mBlue = value;
		}
	}
}	

/*Other Methods*/
void Color::invert( const int& max_color_value ) {
	if (mRed <= max_color_value && mBlue <= max_color_value 
			&& mGreen <= max_color_value) {
		mRed = (max_color_value - mRed);
		mBlue = (max_color_value - mBlue);
		mGreen = (max_color_value - mGreen);
	}
}
bool Color::operator==( const Color& rhs ) const {
	bool is_equal = false;
	if (rhs.mRed == mRed && rhs.mBlue == mBlue
			&& rhs.mGreen == mGreen) {
		is_equal = true;
	}
	return is_equal;
}



/*COLORTABLE CLASS*/

/*Constructor*/
ColorTable::ColorTable( const size_t& num_color ) {
	for (size_t i = 0; i < num_color; i++) {
		Color color;
		mColors.push_back(color);
	}
	//seed random number generator
	int seed = std::time( 0 );
	std::srand( seed );
}

/*Get Methods*/
size_t ColorTable::getNumberOfColors( ) const {
	return mColors.size();
}

/*Set Methods*/
void ColorTable::setNumberOfColors( const size_t& num_color ) {
	mColors.clear();
	for (size_t i = 0; i < num_color; i++) {
		Color color;
		mColors.push_back(color);
	}
}

/*Operators*/
const Color& ColorTable::operator[]( const int& i ) const {
	if (i >= 0 && i < (int)mColors.size()) {
		return mColors[i];
	}
	else {
		static Color blank_color(-1, -1, -1);
		return blank_color;
	}
}
Color& ColorTable::operator[]( const int& i ) {
	if (i >= 0 && i < (int)mColors.size()) {
		return mColors[i];
	}
	else {
		static Color blank_color(-1, -1, -1);
		return blank_color;
	}
}

/*Other Methods*/
void ColorTable::setRandomColor( const int& max_color_value, const size_t& position ) {
	if (max_color_value >= 0 && (int)position >= 0 && position < mColors.size()) {
		for (int i = 0; i < 3; i++) {
			int r = std::rand( );	
			r = r % (max_color_value+1);
			mColors[position].setChannel(i, r);
		}
	}	
}
void ColorTable::insertGradient( const Color& color1, const Color& color2, const size_t& position1, const size_t& position2 ) {
	if (position1 < position2) {
		int k;
		for (int i = 0; i < 3; i++) {
			int c1 = color1.getChannel(i);
			int c2 = color2.getChannel(i);
			int division_number = position2 - position1;
			double delta_c = (c2 - c1) / division_number;
			k = 0;
			for (size_t j = position1; j <= position2; j++) {
				double color_value = k*delta_c + c1;
				int set_value = floor( color_value );
				mColors[j].setChannel(i, set_value);
				k++;
			}
		}
	}	
}
