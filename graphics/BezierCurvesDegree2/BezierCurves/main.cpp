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
#include <iostream>
#include "glut.h"
#include "Point2.h"
#include "Bezier.h"
#include "CurveStore.h"
#include "Button.h"
#include "Slider.h"

// Global Variables (Only what you need!)
double screen_x = 900;
double screen_y = 600;
CurveStore gCurveStore;
Button gAddButton( (double)10, (double)110, screen_y-40, screen_y-10, "Add curve" );
Button gDeleteButton( (double)120, (double)250, screen_y-40, screen_y-10, "Delete curve" );
// Slider Parameters are left, top, right, bottom, etc.
Slider gRedSlider(10, 90, 60, 70, 0.0, 1.0, .75, 1.0, 0.0, 0.0);
Slider gGreenSlider(10, 60, 60, 40, 0.0, 1.0, .5, 0.0, 1.0, 0.0);
Slider gBlueSlider(10, 30, 60, 10, 0.0, 1.0, .25, 0.0, 0.0, 1.0);
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
void DrawText(double x, double y, const char *string)
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
	glColor3d(0, 0, 0);
	gCurveStore.drawCurves();
	gAddButton.draw();
	gDeleteButton.draw();
	
	gRedSlider.Draw();
	gGreenSlider.Draw();
	gBlueSlider.Draw();

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

// This callback function gets called by the Glut
// system whenever any mouse button goes up or down.
void mouse(int mouse_button, int state, int x, int y)
{
	if (mouse_button == GLUT_LEFT_BUTTON && state == GLUT_DOWN) 
	{
		y = screen_y - y;
		bool cpSelected = gCurveStore.selectControlPoint(x, y);
		bool rPressed = gRedSlider.MouseDown(x, y);
		bool gPressed = gGreenSlider.MouseDown(x, y);
		bool bPressed = gBlueSlider.MouseDown(x, y);
		if (gAddButton.isClicked(x, y)) {
			gCurveStore.addCurve();
		}
		else if (gDeleteButton.isClicked(x, y)) {
			gCurveStore.removeCurve();
		}
		else if (rPressed || gPressed || bPressed) {
			double r = gRedSlider.GetCurrentValue();
			double g = gGreenSlider.GetCurrentValue();
			double b = gBlueSlider.GetCurrentValue();
			gCurveStore.setSelectedCurveColor(r, g, b);
		}
		else if (cpSelected) {
		}
		else {
			gCurveStore.setCurveSelected(-1);
		}
	}
	if (mouse_button == GLUT_LEFT_BUTTON && state == GLUT_UP) 
	{
		gCurveStore.setControlPointSelected(-1);
	}
	if (mouse_button == GLUT_MIDDLE_BUTTON && state == GLUT_DOWN) 
	{
	}
	if (mouse_button == GLUT_MIDDLE_BUTTON && state == GLUT_UP) 
	{
	}
	glutPostRedisplay();
}
void motion(int x, int y) {
	y = screen_y - y;
	int cps = gCurveStore.getControlPointSelected();
	int cs = gCurveStore.getCurveSelected();
	gCurveStore.moveControlPoint(x, y);
	bool rPressed = gRedSlider.MouseDown(x, y);
	bool gPressed = gGreenSlider.MouseDown(x, y);
	bool bPressed = gBlueSlider.MouseDown(x, y);
	if (rPressed || gPressed || bPressed) {
		double r = gRedSlider.GetCurrentValue();
		double g = gGreenSlider.GetCurrentValue();
		double b = gBlueSlider.GetCurrentValue();
		gCurveStore.setSelectedCurveColor(r, g, b);
	}
	glutPostRedisplay();
}
// Your initialization code goes here.
void InitializeMyStuff()
{
	gCurveStore.addCurve();
}


int main(int argc, char **argv)
{
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
	glutMotionFunc(motion);

	glColor3d(0,0,0); // forground color
	glClearColor(1, 1, 1, 0); // background color
	InitializeMyStuff();

	glutMainLoop();

	return 0;
}
