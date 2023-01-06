#ifndef JULIA_H
#define JULIA_H

#include <vector>

class JuliaSet {
public:
	/*Constructor*/
	JuliaSet(int width, int height, double a, double b, int maxEscapeCount );

	/*Get Methods*/
	int getWidth( ) const;
	int getHeight( ) const;
	double getMinX( ) const;
	double getMaxX( ) const;
	double getMinY( ) const;
	double getMaxY( ) const;
	double getA( ) const;
	double getB( ) const;
	int getMaxEscapeCount( ) const;

	int getMode() const;
	
	/*Set Methods*/
	void setPixelSize( const int& width, const int& height );
	void setPlaneSize( const double& min_x, const double& max_x, const double& min_y, const double& max_y );
	void setParameters( const double& a, const double& b );
	void setMaxEscapeCount( const int& count );

	void setMode(const int& mode );

	/*Coordinate Methods*/
	double calculateDeltaX( ) const;
	double calculateDeltaY( ) const;
	double calculatePlaneXFromPixelColumn( const int& column ) const;
	double calculatePlaneYFromPixelRow( const int& row ) const;
	void calculatePlaneCoordinatesFromPixelCoordinates( const int& row, const int& column, double& x, double& y ) const;
	
	/*Excape Value Methods*/
	void calculateNextPoint( const double x0, const double y0, double& x1, double &y1 ) const;
	int calculatePlaneEscapeCount( const double& x0, const double& y0 ) const;
	int calculatePixelEscapeCount( const int& row, const int& column ) const;
	void calculateAllEscapeCounts( );
	int getPixelEscapeCount( const int& row, const int& column ) const;

protected:
	int mWidth;
	int mHeight;
	double mMaxX;
	double mMaxY;
	double mMinX;
	double mMinY;
	double mA;
	double mB;
	int mMaxEscapeCount;
	int mMode;
	std::vector<int> mEscapeCounts;

};

#endif

