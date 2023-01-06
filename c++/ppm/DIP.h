#include "PPM.h"
#include<string>

#ifndef DIP_H
#define DIP_H

void readImage(PPM& ppm_object, const std::string& ifilename);
void writeImage(PPM& ppm_object, const std::string& ofilename);


void directCopy(PPM& ppm_object, 
		const std::string& ifilename, const std::string& ofilename);


void grayscaleColor(PPM& ppm_object, const int& color_option);
void grayscaleRed(PPM& ppm_object,
		  const std::string& ifilename, const std::string& ofilename);
void grayscaleGreen(PPM& ppm_object,
		    const std::string& ifilename, const std::string& ofilename);
void grayscaleBlue(PPM& ppm_object,
		   const std::string& ifilename, const std::string& ofilename);
void linearColor(PPM& ppm_object,
		 const std::string& ifilename, const std::string& ofilename);

#endif
