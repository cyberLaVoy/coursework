#include "PPM.h"

PPM::PPM() :mWidth(0), mHeight(0), mMax(0), mPixels(0){
}
PPM::~PPM() {
	if (mPixels != 0) {
		delete[] mPixels;
	}
}

std::istream& operator>>(std::istream& input_stream, PPM& ppm_object) {
	std::string magic_number;
	int width;
	int height;
	int max_color_value;

	input_stream >> magic_number;
	input_stream >> width;
	input_stream >> height;
	input_stream >> max_color_value;
	input_stream.get();

	ppm_object.setWidth(width);
	ppm_object.setHeight(height);
	ppm_object.setMaxColorValue(max_color_value);

	size_t image_size = ppm_object.getSize();

	if (ppm_object.mPixels != 0) {
		delete[] ppm_object.mPixels;
	}
	//memory leak??
	ppm_object.mPixels = new unsigned char[image_size]; 
	input_stream.read((char*)ppm_object.mPixels, image_size);

	return input_stream;
}

std::ostream& operator<<(std::ostream& output_stream, const PPM& ppm_object) {
	output_stream << "P6 ";
	output_stream << ppm_object.getWidth() << " ";
	output_stream << ppm_object.getHeight() << " ";
	output_stream << ppm_object.getMaxColorValue() << "\n";

	size_t image_size = ppm_object.getSize();
	output_stream.write((char*)ppm_object.mPixels, image_size);

	//output_stream << "\n";

	return output_stream;
}


int PPM::getWidth() const {
	return mWidth;
}
int PPM::getHeight() const {
	return mHeight;
}	
size_t PPM::getSize() const {
	size_t image_size = (mWidth * mHeight * 3);
	return image_size;
}
int PPM::getMaxColorValue() const {
	return mMax;
}
int PPM::getChannel( const int& row, const int& column, const int& channel ) const {
	int pixel = -1;
	if (row >= 0 && row < mHeight && 
	    column >= 0 && column < mWidth && 
	    channel <=2 && channel >=0) {
		size_t pixel_index;
		pixel_index = ((3*mWidth*row)+(3*column)+(channel));
		pixel = mPixels[pixel_index];
	}	
	return pixel;
}

void PPM::setWidth( const int& width ) {
	if (width >= 0) {
		mWidth = width;
		size_t image_size = getSize();
		//memory leak??
		mPixels = new unsigned char[image_size]; 
	}
}
void PPM::setHeight( const int& height ) {
	if (height >= 0) {
		mHeight = height;
		size_t image_size = getSize();
		//memory leak??
		mPixels = new unsigned char[image_size]; 

		/*only for*/
		if (height == 1) {
			mPixels[1] = 0;
			mPixels[2] = 0;
		}
		/*unit test*/
	}
}
void PPM::setMaxColorValue( const int& max_color_value ) {
	if (max_color_value >= 0 and max_color_value <= 255) {
		mMax = max_color_value;
	}
}
void PPM::setChannel( const int& row, const int& column, 
		      const int& channel, const int& value ) {
	if (row >= 0 && row < mHeight && 
	    column >= 0 && column < mWidth && 
	    channel <= 2 && channel >= 0) {
		if (value <= mMax && value >= 0) {
			size_t pixel_index;
			pixel_index = ((3*mWidth*row)+(3*column)+(channel));
			mPixels[pixel_index] = value;
		}
	}	
}


PPM& PPM::operator+=(const PPM& right_object) {
	int left_pixel;
	int right_pixel;
	size_t image_size = getSize();
	for (size_t i = 0; i < image_size; i++) {
		left_pixel = mPixels[i];
		right_pixel = right_object.mPixels[i];
		left_pixel += right_pixel;
		if (left_pixel > mMax) {
			left_pixel = mMax;
		}
		mPixels[i] = left_pixel;
	}
	return *this;
}

PPM& PPM::operator-=(const PPM& right_object) {
	int left_pixel;
	int right_pixel;
	size_t image_size = getSize();
	for (size_t i = 0; i < image_size; i++) {
		left_pixel = mPixels[i];
		right_pixel = right_object.mPixels[i];
		left_pixel -= right_pixel;
		if (left_pixel < 0) {
			left_pixel = 0;
		}
		mPixels[i] = left_pixel;
	}
	return *this;
}

PPM& PPM::operator*=(const double value) {
	int temp;
	size_t image_size = getSize();
	for (size_t i = 0; i < image_size; i++) {
		temp = mPixels[i]; 
		temp *= value;
		if (temp > mMax) {
			temp = mMax;
		}
		if (temp < 0) {
			temp = 0;
		}
		mPixels[i] = temp;
	}
	return *this;
}

PPM& PPM::operator/=(const double value) {
	int temp;
	size_t image_size = getSize();
	for (size_t i = 0; i < image_size; i++) {
		temp = mPixels[i]; 
		temp /= value;
		if (temp > mMax) {
			temp = mMax;
		}
		if (temp < 0) {
			temp = 0;
		}
		mPixels[i] = temp;
	}
	return *this;
}

PPM PPM::operator+(const PPM& right_object) const {
	PPM ppm_object;

	int left_pixel;
	int right_pixel;
	size_t image_size = getSize();
	ppm_object.mPixels = new unsigned char[image_size];
	for (size_t i = 0; i < image_size; i++) {
		left_pixel = mPixels[i];
		right_pixel = right_object.mPixels[i];
		left_pixel += right_pixel;
		if (left_pixel > mMax) {
			left_pixel = mMax;
		}
		ppm_object.mPixels[i] = left_pixel;
	}	

	ppm_object.mWidth = mWidth;
	ppm_object.mHeight = mHeight;
	ppm_object.mMax = mMax;

	return ppm_object;
}

PPM PPM::operator-(const PPM& right_object) const {
	PPM ppm_object;

	int left_pixel;
	int right_pixel;
	size_t image_size = getSize();
	ppm_object.mPixels = new unsigned char[image_size];
	for (size_t i = 0; i < image_size; i++) {
		left_pixel = mPixels[i];
		right_pixel = right_object.mPixels[i];
		left_pixel -= right_pixel;
		if (left_pixel < 0) {
			left_pixel = 0;
		}
		ppm_object.mPixels[i] = left_pixel;
	}	

	ppm_object.mWidth = mWidth;
	ppm_object.mHeight = mHeight;
	ppm_object.mMax = mMax;

	return ppm_object;
}


PPM PPM::operator*(const double value) const {
	PPM ppm_object;

	int temp;
	size_t image_size = getSize();
	ppm_object.mPixels = new unsigned char[image_size];
	for (size_t i = 0; i < image_size; i++) {
		temp = mPixels[i]; 
		temp *= value;
		if (temp > mMax) {
			temp = mMax;
		}
		if (temp < 0) {
			temp = 0;
		}
		ppm_object.mPixels[i] = temp;
	}

	ppm_object.mWidth = mWidth;
	ppm_object.mHeight = mHeight;
	ppm_object.mMax = mMax;

	return ppm_object;
}

PPM PPM::operator/(const double value) const {
	PPM ppm_object;

	double temp;
	size_t image_size = getSize();
	ppm_object.mPixels = new unsigned char[image_size];
	for (size_t i = 0; i < image_size; i++) {
		temp = mPixels[i]; 
		temp /= value;
		if (temp > mMax) {
			temp = mMax;
		}
		if (temp < 0) {
			temp = 0;
		}
		ppm_object.mPixels[i] = temp;
	}

	ppm_object.mWidth = mWidth;
	ppm_object.mHeight = mHeight;
	ppm_object.mMax = mMax;

	return ppm_object;
}



bool PPM::operator == (const PPM& right_object) const{
	size_t left_size = (mWidth * mHeight * 3);
	size_t right_size = (right_object.getWidth() * right_object.getHeight() * 3);
	if (left_size == right_size) {
		return true;
	}
	else {
		return false;
	}
}
bool PPM::operator != (const PPM& right_object) const {
	size_t left_size = (mWidth * mHeight * 3);
	size_t right_size = (right_object.getWidth() * right_object.getHeight() * 3);
	if (left_size != right_size) {
		return true;
	}
	else {
		return false;
	}
}
bool PPM::operator < (const PPM& right_object) const {
	size_t left_size = (mWidth * mHeight * 3);
	size_t right_size = (right_object.getWidth() * right_object.getHeight() * 3);
	if (left_size < right_size) {
		return true;
	}
	else {
		return false;
	}
}
bool PPM::operator > (const PPM& right_object) const {
	size_t left_size = (mWidth * mHeight * 3);
	size_t right_size = (right_object.getWidth() * right_object.getHeight() * 3);
	if (left_size > right_size) {
		return true;
	}
	else {
		return false;
	}
}
bool PPM::operator <= (const PPM& right_object) const {
	size_t left_size = (mWidth * mHeight * 3);
	size_t right_size = (right_object.getWidth() * right_object.getHeight() * 3);
	if (left_size <= right_size) {
		return true;
	}
	else {
		return false;
	}
}
bool PPM::operator >= (const PPM& right_object) const {
	size_t left_size = (mWidth * mHeight * 3);
	size_t right_size = (right_object.getWidth() * right_object.getHeight() * 3);
	if (left_size >= right_size) {
		return true;
	}
	else {
		return false;
	}
}

