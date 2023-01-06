#include "juliaSet.h"
#include "colorTable.h"
#include "ppm.h"
#include <iostream>
#include <ctime>

void seed() {
	int seed = std::time( 0 );
	std::srand( seed );
}

ColorTable generateColorTable(int color_count, int max_color_value) {
	ColorTable colorTable(color_count);
	for (int position = 0; position < color_count-color_count/2; position++) {
		colorTable[position].setBlue((max_color_value - (position+254))%max_color_value);
		colorTable[position].setGreen((max_color_value - (254-position))%max_color_value);
		colorTable[position].setRed((max_color_value - (position+254))%max_color_value);
	}
	for (int position = color_count/2; position < color_count; position++) {
		colorTable[position].setGreen(position%max_color_value);
		colorTable[position].setBlue(255);
		colorTable[position].setRed((position+254)%max_color_value);
	}
	return colorTable;
}

void populatePPM(JuliaSet& juliaSet,PPM& ppm_object, ColorTable& colorTable,
	       	 int image_width, int image_height, int black) {

	juliaSet.calculateAllEscapeCounts();
	int escape_value;
	int color_count = colorTable.getNumberOfColors();
	for (int y = 0; y < image_height; y++) {
		int row = y;
		for (int x = 0; x < image_width; x++) {
			int column = x;
			escape_value = juliaSet.getPixelEscapeCount( row, column );
			int color_index = escape_value%color_count;
			for (int channel = 0; channel < 3; channel++) {
				int value = colorTable[color_index].getChannel(channel);
				if (escape_value <= 3) {
					value = black;
				}
				ppm_object.setChannel( row, column, channel, value );
			}
		}
	}
}


int main() {
	seed();
	
	int image_width = 25000;
	int image_height = 25000;
	int max_color_value = 255;
	int black = 0;
	int color_count = 400;
	double a = -0.8;
	double b = .156;
	int maxEscapeCount = 200000;


	ColorTable colorTable = generateColorTable(color_count, max_color_value);
	PPM ppm_object(image_width, image_height, max_color_value);
	JuliaSet juliaSet(image_width, image_height, a, b, maxEscapeCount);
	
	populatePPM(juliaSet, ppm_object, colorTable, image_width, image_height, black);	
	
	std::cout << ppm_object;

	return 0;
}
