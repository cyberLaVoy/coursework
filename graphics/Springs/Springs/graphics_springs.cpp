// CS 3600 Graphics Programming
// Spring, 2002
// Program #4 - SpringMan
// This program simulates various forces between particles, such as springs.

#include <cstdlib>
#include <cstdio>
#include <cassert>
#include <cmath>
#include <string>
#include <iostream>
#include <fstream>
#include <windows.h>
using namespace std;
#include "glut.h"
#include "graphics.h"
#include "particle.h"
#include "forces.h"


// Global Variables
// Some colors you can use, or make your own and add them
// here and in graphics.h
GLdouble redMaterial[] = {0.7, 0.1, 0.2, 1.0};
GLdouble greenMaterial[] = {0.1, 0.7, 0.4, 1.0};
GLdouble brightGreenMaterial[] = {0.1, 0.9, 0.1, 1.0};
GLdouble blueMaterial[] = {0.1, 0.2, 0.7, 1.0};
GLdouble whiteMaterial[] = {1.0, 1.0, 1.0, 1.0};

double screen_x = 700;
double screen_y = 500;

double gSleepTime = .25;
// The particle system.
ParticleSystem PS;

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

void DrawLine(double x1, double y1, double x2, double y2)
{
	glBegin(GL_LINES);
	glVertex2d(x1,y1);
	glVertex2d(x2,y2);
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
void text_output(double x, double y, char *string)
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
	int i;
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3dv(whiteMaterial);
	

	//EulerStep(PS);
	//MidpointStep(PS);
	RungeKuttaStep(PS);

	int N = PS.GetNumParticles();
	int NF = PS.GetNumForces();

	// Check Resulting particles for wall collisions
	for(i=0; i<N; i++)
	{
		Particle * p = PS.GetParticle(i);
		double radius = p->GetRadius();
		double x = p->GetPositionx();
		double y = p->GetPositiony();
		double xDir = p->GetDirectionx();
		double yDir = p->GetDirectiony();

		// bounce off left wall
		if(x - radius < 0)
		{
			p->SetPositionx(radius);
			p->SetDirectionx(fabs(xDir));
		}

		// bounce off right wall
		if(x + radius > screen_x)
		{
			p->SetPositionx(screen_x - radius);
			p->SetDirectionx(-fabs(xDir));
		}

		// bounce off bottom wall
		if(y - radius < 0)
		{
			p->SetPositiony(radius);
			p->SetDirectiony(fabs(yDir));
		}

		// bounce off top wall
		if(y + radius > screen_y)
		{
			p->SetPositiony(screen_y - radius);
			p->SetDirectiony(-fabs(yDir));
		}
	}


	// Draw Spring Forces as edges
	for(i=0; i<NF; i++)
	{
		Force * f = PS.GetForce(i);
		if(f->Type() == SPRING_FORCE)
		{
			SpringForce * sf = (SpringForce*)f;
			Particle * p1 = sf->GetParticle1();
			Particle * p2 = sf->GetParticle2();
			GLdouble color[] = { sf->getRed(),sf->getGreen(),sf->getBlue(), 1.0 };
			glColor3dv(color);
			DrawLine(p1->GetPositionx(), p1->GetPositiony(),  p2->GetPositionx(), p2->GetPositiony());
		}
	}

	// Draw Particles
	for(i=0; i<N; i++)
	{
		Particle * p = PS.GetParticle(i);
		double radius = p->GetRadius();

		double thePos[DIM];
		p->GetPosition(thePos);
		if(p->GetAnchored())
			glColor3dv(redMaterial);
		else
			glColor3dv(whiteMaterial);
		DrawCircle(thePos[0], thePos[1], radius);
	}
	
	//Sleep(gSleepTime);
	glutSwapBuffers();
	glutPostRedisplay();
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
		case 'f': {
			gSleepTime += .01;
			PS.setDeltaT(gSleepTime);
			break;
			}
		case 's':
			gSleepTime -= .01;
			if (gSleepTime < 0) {
				gSleepTime = 0;
			}
			PS.setDeltaT(gSleepTime);
			break;

		case 't': {
			double gravity[DIM] = {0, .5};
			Force * GFT = new GravityForce(gravity, &PS);
			PS.AddForce(GFT);
			break;
			}
		case 'r': {
			double gravity[DIM] = {.5, 0};
			Force * GFR = new GravityForce(gravity, &PS);
			PS.AddForce(GFR);
			break;
		}
		case 'b': {
			double gravity[DIM] = {0, -.5};
			Force * GFB = new GravityForce(gravity, &PS);
			PS.AddForce(GFB);
			break;
		}
		case 'l': {
			double gravity[DIM] = {-.5, 0};
			Force * GFL = new GravityForce(gravity, &PS);
			PS.AddForce(GFL);
			break;
		}
		default:
			return; // if we don't care, return without glutPostRedisplay()
	}

	glutPostRedisplay();
}


// This callback function gets called by the Glut
// system whenever the window is resized by the user.
void reshape(int w, int h)
{
	screen_x = w;
	screen_y = h;

	// Set the pixel resolution of the final picture (Screen coordinates).
	glViewport(0, 0, w, h);

	// go into 2D mode
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	// Set the world coordinates.
	gluOrtho2D(0, 700, 0, 500);
	glMatrixMode(GL_MODELVIEW);

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

void InitParticles1()
{	
	PS.setDeltaT(.1);
	Particle *p1 = new Particle(10, 0,  0, 0,  2, 1);
	Particle *p2 = new Particle(10, screen_y,  0, 0,  10, 0);
	Particle *p3 = new Particle(30, 0,  0, 0,  2, 1);
	Particle *p4 = new Particle(30, screen_y,  0, 0,  10, 0);
	Particle *p5 = new Particle(50, 0,  0, 0,  2, 1);
	Particle *p6 = new Particle(50, screen_y,  0, 0,  10, 0);
	Force * s1 = new SpringForce(p1, p2, .5, 0.1, 1, 0, 0, .7);
	Force * s2 = new SpringForce(p3, p4, .5, 0.1, 0, 1, 0, .6);
	Force * s3 = new SpringForce(p5, p6, .5, 0.1, 0, 0, 1, .8);

	Force * DF = new DragForce(.001, &PS);
	double gravity[DIM] = {0.0, -0.50};
	Force * GF = new GravityForce(gravity, &PS);

	PS.AddParticle(p1);
	PS.AddParticle(p2);
	PS.AddParticle(p3);
	PS.AddParticle(p4);
	PS.AddParticle(p5);
	PS.AddParticle(p6);
	PS.AddForce(s1);
	PS.AddForce(s2);
	PS.AddForce(s3);

	PS.AddForce(DF);
	PS.AddForce(GF);
}
void addParticle(std::istream& input_stream) {
	double x, y, xDir, yDir, r_temp;
	bool anchored_temp;
	input_stream >> x;
	input_stream >> y;
	input_stream >> xDir;
	input_stream >> yDir;
	input_stream >> r_temp;
	input_stream >> anchored_temp;
	if (x == -1) {
		x = screen_x;
	}
	if (y == -1) {
		y = screen_y;
	}
	Particle * p = new Particle(x, y, xDir, yDir, r_temp, anchored_temp);
	PS.AddParticle(p);
}
void addSpringForce(std::istream& input_stream) {
	int p1_index, p2_index;
	double spring_constant, damping_constant, r, g, b, rest_length;
	input_stream >> p1_index;
	input_stream >> p2_index;
	input_stream >> spring_constant;
	input_stream >> damping_constant;
	input_stream >> r;
	input_stream >> g;
	input_stream >> b;
	input_stream >> rest_length;
	Particle *p1 = PS.GetParticle(p1_index);
	Particle *p2 = PS.GetParticle(p2_index);
	Force * s = new SpringForce(p1, p2, spring_constant, damping_constant, r, g, b, rest_length);
	PS.AddForce(s);
}
void addDragForce(std::istream& input_stream) {
	double friction_temp;
	input_stream >> friction_temp;
	Force * f = new DragForce(friction_temp, &PS);
	PS.AddForce(f);
}
void addGravity(std::istream& input_stream) {
	double var1, var2;
	input_stream >> var1;
	input_stream >> var2;
	double gravity[DIM] = {var1, var2};
	Force * f = new GravityForce(gravity, &PS);
	PS.AddForce(f);
}

void initFromStream(std::istream& input_stream) {
	while (input_stream) {
		std::string type;
		input_stream >> type;
		if (type == "DT") {
			double deltaT;
			input_stream >> deltaT;
			PS.setDeltaT(deltaT);
			std::cout << deltaT;
		}
		if (type == "P") {
			addParticle(input_stream);
		}
		if (type == "SF") {
			addSpringForce(input_stream);
		}
		if (type == "DF") {
			addDragForce(input_stream);
		}
		if (type == "GF") {
			addGravity(input_stream);
		}
	}
}



// Your initialization code goes here.
void InitializeMyStuff()
{
	//InitParticles1();

	std::ifstream input;
	input.open("input.txt");
	initFromStream(input);
	input.close();
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
		glutCreateWindow("Shapes");
	}

	glutDisplayFunc(display);
	glutKeyboardFunc(keyboard);
	glutReshapeFunc(reshape);
	glutMouseFunc(mouse);

	glClearColor(.3,.3,.3,0);	
	InitializeMyStuff();

	glutMainLoop();

	return 0;
}
