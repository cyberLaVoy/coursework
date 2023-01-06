#include "ppm.h"

PPM::PPM() : mPixels(0), mWidth(0), mHeight(0), mMax(0){
}
PPM::PPM(int image_width, int image_height, int max_color_value) {
	mWidth = image_width;
	mHeight = image_height;	
	mMax = max_color_value;
	size_t image_size = (image_width * image_height * 3);
	mPixels = new unsigned char[image_size]; 
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
		if (mPixels != 0) {
			delete[] mPixels;
		}
		size_t image_size = getSize();
		mPixels = new unsigned char[image_size]; 
	}
}
void PPM::setHeight( const int& height ) {
	if (height >= 0) {
		mHeight = height;
		if (mPixels != 0) {
			delete[] mPixels;
		}
		size_t image_size = getSize();
		mPixels = new unsigned char[image_size]; 
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

