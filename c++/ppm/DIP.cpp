#include "DIP.h"
#include<fstream>
#include<string>

void readImage(PPM& ppm_object, const std::string& ifilename) {
	std::ifstream fin(ifilename, std::ios::binary);
	fin >> ppm_object;
	fin.close();
}
void writeImage(PPM& ppm_object, const std::string& ofilename) {
	std::ofstream fout(ofilename, std::ios::binary);
	fout << ppm_object;
	fout.close();
}
void grayscaleColor(PPM& ppm_object, const int& color_option) {
	int image_width = ppm_object.getWidth();
	int image_height = ppm_object.getHeight();
	for (int i = 0; i < image_height; i++) {
		for (int j = 0; j < image_width; j++) {
			int color_set = ppm_object.getChannel(i, j, color_option);
			for (int k = 0; k < 3; k++) {
				ppm_object.setChannel(i,j,k, color_set);
			}
		}
	}
}

void directCopy(PPM& ppm_object, 
		const std::string& ifilename, const std::string& ofilename) {
	readImage(ppm_object, ifilename);
	writeImage(ppm_object, ofilename);
}

void grayscaleRed(PPM& ppm_object, 
		  const std::string& ifilename, const std::string& ofilename) {
	readImage(ppm_object, ifilename);
	grayscaleColor(ppm_object, 0);
	writeImage(ppm_object, ofilename);
}
void grayscaleGreen(PPM& ppm_object,
	            const std::string& ifilename, const std::string& ofilename) {
	readImage(ppm_object, ifilename);
	grayscaleColor(ppm_object, 1);
	writeImage(ppm_object, ofilename);
}
void grayscaleBlue(PPM& ppm_object, 
		   const std::string& ifilename, const std::string& ofilename) {
	readImage(ppm_object, ifilename);
	grayscaleColor(ppm_object, 2);
	writeImage(ppm_object, ofilename);
}
void linearColor(PPM& ppm_object,
	       	 const std::string& ifilename, const std::string& ofilename) {
	readImage(ppm_object, ifilename);
	int image_width = ppm_object.getWidth();
	int image_height = ppm_object.getHeight();
	for (int i = 0; i < image_height; i++) {
		for (int j = 0; j < image_width; j++) {
			int red = ppm_object.getChannel(i,j,0);
			int green = ppm_object.getChannel(i,j,1);
			int blue = ppm_object.getChannel(i,j,2);
			int linear_color = red*.2126 + green*.7152 + blue*.0722;
			for (int k = 0; k < 3; k++) {
				ppm_object.setChannel(i,j,k, linear_color);
			}
		}
	}
	writeImage(ppm_object, ofilename);
}
