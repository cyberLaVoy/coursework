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
#include <Windows.h>
#include "glut.h"
#include "Rat.h"


// Global Variables (Only what you need!)
double screen_x = 700;
double screen_y = 500;
double resolution = 200; // resolution**2 = number of quads
double waterHeight = 5;
double detlaWaterLevel = .1;
double gFloorRaise = 1;

bool gSpinningLeft = false;
bool gSpinningRight = false;
bool gMovingForward = false;

viewtype current_view = perspective_view;
Rat gRat;
// 
// Functions that draw basic primitives
//
void DrawCircle(double x1, double y1, double z1, double radius)
{
	glBegin(GL_POLYGON);
	for(int i=0; i<32; i++)
	{
		double theta = (double)i/32.0 * 2.0 * 3.1415926;
		double x = x1 + radius * cos(theta);
		double y = y1 + radius * sin(theta);
		glVertex3d(x, y, z1);
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

double zValue(double x, double y) {
	x = .1*(-resolution/2 +x);
	y = .1*(-resolution/2 + y);
	double t = 4;
	double w = 1.5;
	double k = 1.5;
	double R = sqrt(x*x + y*y);
	double z = 27 * cos(k*R + w*t) +cos(x)+sin(y);
	return z*gFloorRaise;
}

void drawTerrain() {
	glBegin(GL_QUADS);
	for (int i = 0; i < resolution; i++) {
		for (int j = 0; j < resolution; j++) {
			glColor3d(.5,zValue(i,j),(double)j/100);
			glVertex3d(i, j, zValue(i,j));
			glVertex3d(i, j+1, zValue(i,j+1));
			glVertex3d(i+1, j+1, zValue(i+1,j+1));
			glVertex3d(i+1, j, zValue(i+1,j));
		}
	}
	glEnd();
}


//
// GLUT callback functions
//

// This callback function gets called by the Glut
// system whenever it decides things need to be redrawn.
void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	if (current_view == perspective_view)
	{
		glEnable(GL_DEPTH_TEST);
		glLoadIdentity();
		gluLookAt(resolution/2, -resolution/1.5, resolution, resolution/2, resolution/2, 0, 0, 0, 1);;
		}
	else // current_view == rat_view
	{
		glEnable(GL_DEPTH_TEST);
		glLoadIdentity();
		double z_level = 1;
		double x = gRat.getX();
		double y = gRat.getY();
		double z = zValue(x, y);
		if (z < waterHeight) {
			z = waterHeight;
		}
		z += 8;
		double dx = gRat.getDX();
		double dy = gRat.getDY();
		double at_x = x + dx*.8;
		double at_y = y + dy*.8;
		double at_z = zValue(at_x, at_y);
		if (at_z < waterHeight) {
			at_z = waterHeight;
		}
		at_z += 8;
		gluLookAt(x, y, z, at_x, at_y, at_z, 0, 0, 1);
	}


	//draw terrain
	drawTerrain();

	if (gSpinningLeft) {
		gRat.spinLeft();
	}
	if (gSpinningRight) {
		gRat.spinRight();
	}
	if (gMovingForward) {
		gRat.moveForward();
	}
	gRat.draw();


	//draw water
	if (waterHeight < -8 || waterHeight > 7) {
		detlaWaterLevel = -detlaWaterLevel;
	}
	waterHeight += detlaWaterLevel;
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_BLEND);
	glColor4d(0, 0, 0, .5);
	glBegin(GL_QUADS);
	glVertex3f(0, 0, waterHeight);
	glVertex3f(resolution, 0, waterHeight);
	glVertex3f(resolution, resolution, waterHeight);
	glVertex3f(0, resolution, waterHeight);
	glEnd();
	glDisable(GL_BLEND);


	glutPostRedisplay();
	glutSwapBuffers();
}


// This callback function gets called by the Glut
// system whenever a key is pressed.
void keyboard_down(unsigned char c, int x, int y)
{
	switch (c) 
	{
		case 27: // escape character means to quit the program
			exit(0);
		case 'r':
			current_view = rat_view;
			break;
		case 'p':
			current_view = perspective_view;
			break;
		case 'a':
			gSpinningLeft = true;
			break;
		case 'w':
			gMovingForward = true;
			break;
		case 'd':
			gSpinningRight = true;
			break;
		case 'u':
			gFloorRaise += .1;
			break;
		case 'y':
			gFloorRaise -= .1;
			break;
		default:
			return; // if we don't care, return without glutPostRedisplay()
	}

	glutPostRedisplay();
}
void keyboard_up(unsigned char c, int x, int y)
{
	switch (c)
	{
	case 'a':
		gSpinningLeft = false;
		break;
	case 'w':
		gMovingForward = false;
		break;
	case 'd':
		gSpinningRight = false;
		break;
	default:
		return; // if we don't care, return without glutPostRedisplay()
	}

	glutPostRedisplay();
}

void SetPerspectiveView(int w, int h)
{
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	double aspectRatio = (GLdouble)w / (GLdouble)h;
	gluPerspective(
		/* field of view in degree */ 38.0,
		/* aspect ratio */ aspectRatio,
		/* Z near */ .1, /* Z far */ 1000.0);
	glMatrixMode(GL_MODELVIEW);
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

	SetPerspectiveView(w, h);

}

// This callback function gets called by the Glut
// system whenever any mouse button goes up or down.
void mouse(int mouse_button, int state, int x, int y)
{
	if (mouse_button == GLUT_LEFT_BUTTON && state == GLUT_DOWN) 
	{
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

// Your initialization code goes here.
void InitializeMyStuff()
{
}


int main(int argc, char **argv)
{
	glutInit(&argc, argv);

	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
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
	glutKeyboardFunc(keyboard_down);
	glutKeyboardUpFunc(keyboard_up);
	glutReshapeFunc(reshape);
	glutMouseFunc(mouse);

	glColor3d(0,0,0); // forground color
	glClearColor(0, 0, 0, 0); // background color
	InitializeMyStuff();

	glutMainLoop();

	return 0;
}
