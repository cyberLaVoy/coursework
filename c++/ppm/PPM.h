#include<iostream>
#include<string>

#ifndef PPM_H
#define PPM_H

class PPM {
public:
	PPM();
	~PPM();

	PPM& operator+=(const PPM& right_object);
	PPM& operator-=(const PPM& right_object);
	PPM& operator*=(const double value);
	PPM& operator/=(const double value);

		
	PPM operator+(const PPM& right_object) const;
	PPM operator-(const PPM& right_object) const;
	PPM operator*(const double value) const;
	PPM operator/(const double value) const;
	
	bool operator==(const PPM& right_object) const;
	bool operator!=(const PPM& right_object) const;
	bool operator<(const PPM& right_object) const;
	bool operator>(const PPM& right_object) const;
	bool operator<=(const PPM& right_object) const;
	bool operator>=(const PPM& right_object) const;
	

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

private:
	int mWidth;
	int mHeight;
	int mMax;	

};

std::ostream& operator<<(std::ostream& output_stream, 
			 const PPM& ppm_object);
std::istream& operator>>(std::istream& input_stream, 
			 PPM& ppm_object);

#endif
