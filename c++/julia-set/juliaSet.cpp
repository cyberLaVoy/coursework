#include "juliaSet.h"

/*Constructor*/
JuliaSet::JuliaSet( int width, int height, double a, double b, int maxEscapeCount ) 
	: mMaxX(2), mMaxY(2), mMinX(-2), mMinY(-2), mMode(1)
{
	mWidth = width;
	mHeight = height;
	mA = a;
	mB = b;
	mMaxEscapeCount = maxEscapeCount;
}

/*Get Methods*/
int JuliaSet::getMode() const {
	return mMode;
}
int JuliaSet::getWidth( ) const 
{
	return mWidth;
}
int JuliaSet::getHeight( ) const
{
	return mHeight;
}
double JuliaSet::getMinX( ) const
{
	return mMinX;
}
double JuliaSet::getMaxX( ) const
{
	return mMaxX;
}
double JuliaSet::getMinY( ) const
{
	return mMinY;
}
double JuliaSet::getMaxY( ) const
{
	return mMaxY;
}
double JuliaSet::getA( ) const
{
	return mA;
}
double JuliaSet::getB( ) const
{
	return mB;
}
int JuliaSet::getMaxEscapeCount( ) const
{
	return mMaxEscapeCount;
}

/*Set Methods*/
void JuliaSet::setMode( const int& mode ) {
	mMode = mode;
}

void JuliaSet::setPixelSize( const int& width, const int& height ) {
	if (width >= 2 and height >= 2) {
		mWidth = width;
		mHeight = height;
	}	
}
void JuliaSet::setPlaneSize( const double& min_x, const double& max_x, const double& min_y, const double& max_y ) {
	if (min_x > max_x) {
		mMinX = max_x;
		mMaxX = min_x;
	}
	else {
		mMinX = min_x;
		mMaxX = max_x;
	}
	if (min_y > max_y) {
		mMinY = max_y;
		mMaxY = min_y;
	}
	else {
		mMinY = min_y;
		mMaxY = max_y;
	}
}
void JuliaSet::setParameters( const double& a, const double& b ) {
	mA = a;
	mB = b;
}
void JuliaSet::setMaxEscapeCount( const int& count ) {
	if (count >= 0) {
		mMaxEscapeCount = count;
	}
}

/*Coordinate Methods*/
double JuliaSet::calculateDeltaX( ) const {
	double delta_x;
	delta_x = (mMaxX-mMinX)/(mWidth-1);
	return delta_x;
}
double JuliaSet::calculateDeltaY( ) const {
	double delta_y;
	delta_y = (mMaxY-mMinY)/(mHeight-1);
	return delta_y;
}
double JuliaSet::calculatePlaneXFromPixelColumn( const int& column ) const {
	double plane_x = 0;
	if (column < mWidth and column >=0) {
		double delta_x;
		delta_x = calculateDeltaX();
		plane_x = mMinX + column*delta_x;	
	}
	return plane_x;

}
double JuliaSet::calculatePlaneYFromPixelRow( const int& row ) const {
	double plane_y = 0;
	if (row < mHeight and row >=0) {
		double delta_y;
		delta_y = calculateDeltaY();
		plane_y = mMaxY - row*delta_y;	
	}
	return plane_y;
}
void JuliaSet::calculatePlaneCoordinatesFromPixelCoordinates( const int& row, const int& column, double& x, double& y ) const {
	if (row >= mHeight or row < 0 or column >= mWidth or column < 0) {
		x = 0;
		y = 0;
	}
	else {
		x = calculatePlaneXFromPixelColumn(column);
		y = calculatePlaneYFromPixelRow(row);
	}
}

/*Excape Value Methods*/
void JuliaSet::calculateNextPoint( const double x0, const double y0, double& x1, double &y1 ) const {
	if (mMode == 1) {
		x1 = x0*x0 - y0*y0 + mA;
		y1 = 2*x0*y0 + mB;
	}
	if (mMode == 0) {
		x1 = x0*x0*x0 - 3*x0*y0*y0 + mA;
		y1 = 3*x0*x0*y0 - y0*y0*y0 + mB;
	}
}
int JuliaSet::calculatePlaneEscapeCount( const double& x0, const double& y0 ) const {
	int escape_count = 0;
	double x = x0;
	double y = y0;
	while (x*x + y*y <= 4 and escape_count < mMaxEscapeCount) {
		calculateNextPoint( x, y, x, y );	
		escape_count++;
	}
	return escape_count;
}
int JuliaSet::calculatePixelEscapeCount( const int& row, const int& column ) const {
	int escape_count;
	if (row >= mHeight or row < 0 or column >= mWidth or column < 0) {
		escape_count = -1;
	}
	else {
		double x0;
		double y0;
		calculatePlaneCoordinatesFromPixelCoordinates( row, column, x0, y0 );
		escape_count = calculatePlaneEscapeCount(x0, y0);
	}
	return escape_count;
}
void JuliaSet::calculateAllEscapeCounts( ) {
	for (int i = 0; i < mHeight; i++) {
		for (int j = 0; j < mWidth; j++) {
			int escape_count = calculatePixelEscapeCount( i, j );
			mEscapeCounts.push_back(escape_count);
		}
	}
}
int JuliaSet::getPixelEscapeCount( const int& row, const int& column ) const {
	int escape_count;
	if (row >= mHeight or row < 0 or column >= mWidth or column < 0) {
		escape_count = -1;
	}
	else {
		int pixel_number;
		pixel_number = row*mWidth + column;
		escape_count = mEscapeCounts[pixel_number];
	}
	return escape_count;
}


/*
	int mWidth;
	int mHeight;
	double mMaxX;
	double mMaxY;
	double mMinX;
	double mMinY;
	double mA;
	double mB;
	int mMaxEscapeCount;
	int mEscapeCounts;
*/

