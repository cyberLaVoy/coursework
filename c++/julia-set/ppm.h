#include<iostream>
#include<string>

#ifndef PPM_H
#define PPM_H

class PPM {
public:
	PPM();
	PPM(int image_width, int image_height, int max_color_value);
	~PPM();

	int getWidth() const;
	int getHeight() const;
	size_t getSize() const;
	int getMaxColorValue() const;
	int getChannel( const int& row, const int& column, 
			const int& channel ) const;
	
	void setWidth( const int& width );
	void setHeight( const int& height );
	void setMaxColorValue( const int& max_color_value );
	void setChannel( const int& row, const int& column, 
			 const int& channel, const int& value );

	unsigned char* mPixels;
protected:
	int mWidth;
	int mHeight;
	int mMax;	

};

std::ostream& operator<<(std::ostream& output_stream, 
			 const PPM& ppm_object);
std::istream& operator>>(std::istream& input_stream, 
			 PPM& ppm_object);

#endif
