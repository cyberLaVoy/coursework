// OpenGL/GLUT starter kit for Windows 7 and Visual Studio 2010
// Created spring, 2011
//
// This is a starting point for OpenGl applications.
// Add code to the "display" function below, or otherwise
// modify this file to get your desired results.
//
// For the first assignment, add this file to an empty Windows Console project
//		and then compile and run it as is.
// NOTE: You should also have glut.h,
// glut32.dll, and glut32.lib in the directory of your project.
// OR, see GlutDirectories.txt for a better place to put them.

#include <cmath>
#include <cstring>
#include <cstdlib>
#include <ctime>
#include <Windows.h>
#include <vector>
#include "glut.h"
#include "circle.h"


// Global Variables (Only what you need!)
double screen_x = 700;
double screen_y = 600;
std::vector<circle> balls;

// 
// Functions that draw basic primitives
//
void DrawCircle(double x1, double y1, double radius)
{
	glBegin(GL_POLYGON);
	for(int i=0; i<32; i++)
	{
		double theta = (double)i/32.0 * 2.0 * 3.1415926;
		double x = x1 + radius * cos(theta);
		double y = y1 + radius * sin(theta);
		glVertex2d(x, y);
	}
	glEnd();
}

void DrawRectangle(double x1, double y1, double x2, double y2)
{
	glBegin(GL_QUADS);
	glVertex2d(x1,y1);
	glVertex2d(x2,y1);
	glVertex2d(x2,y2);
	glVertex2d(x1,y2);
	glEnd();
}

void DrawTriangle(double x1, double y1, double x2, double y2, double x3, double y3)
{
	glBegin(GL_TRIANGLES);
	glVertex2d(x1,y1);
	glVertex2d(x2,y2);
	glVertex2d(x3,y3);
	glEnd();
}

// Outputs a string of text at the specified location.
void DrawText(double x, double y, char *string)
{
	void *font = GLUT_BITMAP_9_BY_15;

	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
	
	int len, i;
	glRasterPos2d(x, y);
	len = (int) strlen(string);
	for (i = 0; i < len; i++) 
	{
		glutBitmapCharacter(font, string[i]);
	}

    glDisable(GL_BLEND);
}


//
// GLUT callback functions
//

// This callback function gets called by the Glut
// system whenever it decides things need to be redrawn.

void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT);

	for (size_t i = 0; i < balls.size(); i++) {
		balls[i].bounce(screen_x, screen_y, i, balls);
	}
	//Sleep(1);
	glutPostRedisplay();
	glutSwapBuffers();
}


// This callback function gets called by the Glut
// system whenever a key is pressed.
void keyboard(unsigned char c, int x, int y)
{
	switch (c) 
	{
		case 27: // escape character means to quit the program
			exit(0);
			break;
		case 'b':
			// do something when 'b' character is hit.
			break;
		default:
			return; // if we don't care, return without glutPostRedisplay()
	}

	glutPostRedisplay();
}


// This callback function gets called by the Glut
// system whenever the window is resized by the user.
void reshape(int w, int h)
{
	// Reset our global variables to the new width and height.
	screen_x = w;
	screen_y = h;

	// Set the pixel resolution of the final picture (Screen coordinates).
	glViewport(0, 0, w, h);

	// Set the projection mode to 2D orthographic, and set the world coordinates:
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0, w, 0, h);
	glMatrixMode(GL_MODELVIEW);

}

int createRandomInt(int low, int high) {
	int count = high - low + 1;
	int r = std::rand() % count + low;
	return r;
}

double createRandomDouble(double low, double high) {
	double r = (double)std::rand() / RAND_MAX;
	double scale = high - low;
	r *= scale;
	r += low;
	return r;
}
// This callback function gets called by the Glut
// system whenever any mouse button goes up or down.
void mouse(int mouse_button, int state, int x, int y)
{
	if (mouse_button == GLUT_LEFT_BUTTON && state == GLUT_DOWN) 
	{
		int r = createRandomInt(5, 30);
		int r_state = createRandomInt(0, 1);
		char state = 'r';
		//if (r_state) {
		//	state = 'r';
		//}
		//else {
		//	state = 'b';
		//}
		circle c(x, screen_y-y, 0, .5, r, 1, 1, 1, state);
		if (!c.checkBallToBallCollisionGen(balls)) {
			balls.push_back(c);
		}
	}
	if (mouse_button == GLUT_LEFT_BUTTON && state == GLUT_UP) 
	{
	}
	if (mouse_button == GLUT_MIDDLE_BUTTON && state == GLUT_DOWN) 
	{
	}
	if (mouse_button == GLUT_MIDDLE_BUTTON && state == GLUT_UP) 
	{
	}
	glutPostRedisplay();
}


void createBalls() {

	int numBalls = 20;
	double red = 1;
	double green = 1;
	double blue = 1;
	for (int i = 0; i < numBalls; i++) {
		bool colide = true;
		while (colide) {
			int r = createRandomInt(5, 30);
			int x = createRandomInt(r, screen_x - r);
			int y = createRandomInt(r, screen_y - r);

			double dx = createRandomDouble(.2, .4);
			double dy = createRandomDouble(.2, .4);

			if (i % 2 == 0) {
				dx = -dx;
				dy = -dy;
			}
			char state = 'r';
			circle c(x, y, dx, dy, r, red, green, blue, state);
			colide = c.checkBallToBallCollisionGen(balls);
			if (!colide) {
				balls.push_back(c);
			}
		}
	}
}
void createBalls5() {
	int numBalls = 5;
	double red = 1;
	double green = 1;
	double blue = 1;
	for (int i = 0; i < numBalls; i++) {
		bool colide = true;
		while (colide) {
			int r = createRandomInt(30, 30);
			int x = createRandomInt(r, screen_x - r);
			int y = createRandomInt(r, screen_y - r);

			double dx = createRandomDouble(.2, .5);
			double dy = createRandomDouble(.2, .5);
			
			red = createRandomDouble(0, 1);
			green = createRandomDouble(0, 1);
			blue = createRandomDouble(0, 1);

			if (i % 2 == 0) {
				dx = -dx;
				dy = -dy;
			}

			char state = 'r';
			circle c(x, y, dx, dy, r, red, green, blue, state);
			colide = c.checkBallToBallCollisionGen(balls);
			if (!colide) {
				balls.push_back(c);
			}
		}
	}
}
// Your initialization code goes here.
void InitializeMyStuff() {
	//createBalls5();
	createBalls();
}


int main(int argc, char **argv) {
	int seed = std::time(0);
	std::srand(seed);

	glutInit(&argc, argv);

	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
	glutInitWindowSize(screen_x, screen_y);
	glutInitWindowPosition(50, 50);

	int fullscreen = 0;
	if (fullscreen) 
	{
		glutGameModeString("800x600:32");
		glutEnterGameMode();
	} 
	else 
	{
		glutCreateWindow("This appears in the title bar");
	}

	glutDisplayFunc(display);
	glutKeyboardFunc(keyboard);
	glutReshapeFunc(reshape);
	glutMouseFunc(mouse);

	glColor3d(0,0,0); // forground color
	glClearColor(0, 0, 0, 0); // background color
	InitializeMyStuff();

	glutMainLoop();

	return 0;
}
