// (your name here)
// Chess animation starter kit.

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <math.h>
#include <string.h>
#include <fstream>
#include <iostream>
#include <ctime>
#include <vector>
using namespace std;
#include "glut.h"
#include "graphics.h"


double screen_x = 600;
double screen_y = 500;

double gEyex = 4500;
double gEyez = -3000;
double viewRadius = 7500;
double h = 4500;
double k = 4500;
const double PI = 3.1415926535;
int gTheta = 180;

double gEyey = 8000;

enum piece_numbers { pawn = 100, king, queen, rook, bishop, knight };

// NOTE: Y is the UP direction for the chess pieces.
double eye[3] = {gEyex, gEyey, gEyez}; // movable view
//double eye[3] = {4500, 8000, -3000}; // white middle
//double eye[3] = {0, 9000, -4500}; // white right hand corner
//double eye[3] = {9000, 9000, -4500}; // white left hand corner
//double eye[3] = {9500, 9000, 14000}; // black right hand corner
//double eye[3] = {0, 9000, 14000}; // black left hand corner
//double eye[3] = {4500, 9000, 14000}; // black middle
double at[3]  = {4500, 0, 4500};


double GetTime()
{
	static clock_t start_time = clock();
	clock_t current_time = clock();
	double total_time = double(current_time - start_time) / CLOCKS_PER_SEC;
	return total_time;
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

// Given the three triangle points x[0],y[0],z[0],
//		x[1],y[1],z[1], and x[2],y[2],z[2],
//		Finds the normal vector n[0], n[1], n[2].
void FindTriangleNormal(double x[], double y[], double z[], double n[])
{
	// Convert the 3 input points to 2 vectors, v1 and v2.
	double v1[3], v2[3];
	v1[0] = x[1] - x[0];
	v1[1] = y[1] - y[0];
	v1[2] = z[1] - z[0];
	v2[0] = x[2] - x[0];
	v2[1] = y[2] - y[0];
	v2[2] = z[2] - z[0];
	
	// Take the cross product of v1 and v2, to find the vector perpendicular to both.
	n[0] = v1[1]*v2[2] - v1[2]*v2[1];
	n[1] = -(v1[0]*v2[2] - v1[2]*v2[0]);
	n[2] = v1[0]*v2[1] - v1[1]*v2[0];

	double size = sqrt(n[0]*n[0] + n[1]*n[1] + n[2]*n[2]);
	n[0] /= -size;
	n[1] /= -size;
	n[2] /= -size;
}

// Loads the given data file and draws it at its default position.
// Call glTranslate before calling this to get it in the right place.
void DrawPiece(const char filename[])
{
	// Try to open the given file.
	char buffer[200];
	ifstream in(filename);
	if(!in)
	{
		cerr << "Error. Could not open " << filename << endl;
		exit(1);
	}

	double x[100], y[100], z[100]; // stores a single polygon up to 100 vertices.
	int done = false;
	int verts = 0; // vertices in the current polygon
	int polygons = 0; // total polygons in this file.
	do
	{
		in.getline(buffer, 200); // get one line (point) from the file.
		int count = sscanf(buffer, "%lf, %lf, %lf", &(x[verts]), &(y[verts]), &(z[verts]));
		done = in.eof();
		if(!done)
		{
			if(count == 3) // if this line had an x,y,z point.
			{
				verts++;
			}
			else // the line was empty. Finish current polygon and start a new one.
			{
				if(verts>=3)
				{
					glBegin(GL_POLYGON);
					double n[3];
					FindTriangleNormal(x, y, z, n);
					glNormal3dv(n);
					for(int i=0; i<verts; i++)
					{
						glVertex3d(x[i], y[i], z[i]);
					}
					glEnd(); // end previous polygon
					polygons++;
					verts = 0;
				}
			}
		}
	}
	while(!done);

	if(verts>0)
	{
		cerr << "Error. Extra vertices in file " << filename << endl;
		exit(1);
	}

}

void DrawQuad(double x1, double y1, double z1, double x2, double y2, double z2)
{
	glBegin(GL_QUADS);
	glNormal3d(0,1,0);
	glVertex3d(x1, y1, z1);
	glVertex3d(x2, y1 ,z2);
	glVertex3d(x2, y2 ,z2);
	glVertex3d(x1, y2, z1);
	glEnd();
}
void DrawQuad2(double x1, double y1, double z1, double x2, double y2, double z2)
{
	glBegin(GL_QUADS);
	glNormal3d(0,1,0);
	glVertex3d(x1, y1, z1);
	glVertex3d(x2, y1 ,z1);
	glVertex3d(x2, y2 ,z2);
	glVertex3d(x1, y2, z2);
	glEnd();
}
void drawBoard() {
	GLfloat darkBrown[] = {(float)42/255, (float)11/255, (float)0/255, 1.0f};
	GLfloat lightBrown[] = {(float)102/255, (float)65/255, (float)16/255, 1.0f};
	int color = 1;
	for (int x1 = 500; x1 <= 7500; x1 += 1000) {
		color += 1;
		color %= 2;
		for (int z1 = 500; z1 <= 7500; z1 += 1000) {
			if (color) {
				glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, darkBrown);
			}
			else {
				glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, lightBrown);
			}
			DrawQuad2(x1, 0, z1, x1+1000, 0, z1+1000);
			color += 1;
			color %= 2;
		}
	}
	glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, darkBrown);
	double z1 = 500;
	double z2 = 8500;
	double x1 = 500;
	double x2 = 8500;
	double y1 = 0;
	double y2 = -350;
	DrawQuad(x1, y1, z1, x2, y2, z1);
	DrawQuad(x1, y1, z2, x2, y2, z2);
	DrawQuad(x1, y1, z1, x1, y2, z2);
	DrawQuad(x2, y1, z1, x2, y2, z2);
}

// As t goes from t0 to t1, set v and u between v0, u0 and v1, u0 accordingly.
void interpolate(double t, double t0, double t1, double &v, double v0, double v1) {
	double ratio = (t - t0) / (t1 - t0);
	if (ratio < 0) {
		ratio = 0;
	}
	else if (ratio > 1) {
		ratio = 1;
	}
	v = v0 + (v1 - v0)* ratio;
}



//
// GLUT callback functions
//
// This callback function gets called by the Glut
// system whenever it decides things need to be redrawn.
void display(void)
{
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	GLfloat silver[] = {(float)202/255, (float)203/255, (float)206/255, 1.0f};
	GLfloat gold[] = {(float)229/255, (float)208/255, (float)143/255, 1.0f};

	std::vector< std::vector<float> > moveTimer;
	float numberOfMoves = 7;
	for (float i = .5; i <= numberOfMoves+.5; i += 1) {
		std::vector<float> moveVector;
		moveVector.push_back(i);
		moveVector.push_back(i+1);
		moveTimer.push_back(moveVector);
	}
	double time = GetTime();

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glLoadIdentity();
	gluLookAt(eye[0], eye[1], eye[2],  at[0], at[1], at[2],  0,1,0); // Y is up!

	// Draw the chess board.
	drawBoard();

	// Set the color for one side (white), and draw its 16 pieces.
	glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, silver);

	glPushMatrix();
	glTranslatef(1000, 0, 1000);
	glCallList(rook);
	glPopMatrix();

	glPushMatrix();
	glTranslatef(2000, 0, 1000);
	glCallList(knight);
	glPopMatrix();

	{
		double z;
		double x;
		interpolate(time, moveTimer[2][0], moveTimer[2][1], z, 1000, 4000);
		interpolate(time, moveTimer[2][0], moveTimer[2][1], x, 3000, 6000);
		if (time > moveTimer[2][1]) {
			interpolate(time, moveTimer[6][0], moveTimer[6][1]+.5, z, 4000, 7000);
			interpolate(time, moveTimer[6][0], moveTimer[6][1]+.5, x, 6000, 3000);
		}
		glPushMatrix();
		glTranslatef(x, 0, z);
		glCallList(bishop);
		glPopMatrix();
	}

	glPushMatrix();
	glTranslatef(4000, 0, 1000);
	glCallList(king);
	glPopMatrix();

	{
		double z;
		double x;
		interpolate(time, moveTimer[4][0], moveTimer[4][1], z, 1000, 3000);
		interpolate(time, moveTimer[4][0], moveTimer[4][1], x, 5000, 3000);
		glPushMatrix();
		glTranslatef(x, 0, z);
		glCallList(queen);
		glPopMatrix();
	}

	glPushMatrix();
	glTranslatef(6000, 0, 1000);
	glCallList(bishop);
	glPopMatrix();

	glPushMatrix();
	glTranslatef(7000, 0, 1000);
	glCallList(knight);
	glPopMatrix();

	glPushMatrix();
	glTranslatef(8000, 0, 1000);
	glCallList(rook);
	glPopMatrix();

	for (int x = 1000; x <= 8000; x += 1000)
	{
		glPushMatrix();
		if (x == 4000) {
			double z;
			interpolate(time, moveTimer[0][0], moveTimer[0][1], z, 2000, 3000);
			glTranslatef(x, 0, z);
		}
		else {
			glTranslatef(x, 0, 2000);
		}
		glCallList(pawn);
		glPopMatrix();
	}

	// Set the color for one side (black), and draw its 16 pieces.
	glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, gold);

	glPushMatrix();
	glTranslatef(1000, 0, 8000);
	glCallList(rook);
	glPopMatrix();

	glPushMatrix();
	glTranslatef(2000, 0, 8000);
	glCallList(knight);
	glPopMatrix();

	{
		double grow;
		interpolate(time, moveTimer[1][0], moveTimer[3][0], grow, 1, 2);
		glPushMatrix();
		glTranslatef(3000, 0, 8000);
		//glScaled(1, grow, 1);
		glCallList(bishop);
		glPopMatrix();
	}

	{
		double rotateDegrees;
		interpolate(time, moveTimer[7][0], moveTimer[7][1], rotateDegrees, 0, 90);
		glPushMatrix();
		glTranslatef(4000, 0, 8000);
		glRotated(rotateDegrees, 1, 0, 0);
		glCallList(king);
		glPopMatrix();
	}

	glPushMatrix();
	glTranslatef(5000, 0, 8000);
	glCallList(queen);
	glPopMatrix();

	{
		double rotateDegrees;
		interpolate(time, moveTimer[4][0], moveTimer[6][0], rotateDegrees, 0, 90);
		double grow;
		interpolate(time, moveTimer[1][0], moveTimer[3][0], grow, 1, 2);
		glPushMatrix();
		glTranslatef(6000, 0, 8000);
		//glRotated(rotateDegrees, 1, 0, 0);
		//glScaled(1, grow, 1);
		glCallList(bishop);
		glPopMatrix();
	}

	glPushMatrix();
	glTranslatef(7000, 0, 8000);
	glCallList(knight);
	glPopMatrix();

	{
		double z;
		interpolate(time, moveTimer[3][0], moveTimer[3][1], z, 8000, 6000);
		glPushMatrix();
		glTranslatef(8000, 0, z);
		glCallList(rook);
		glPopMatrix();
	}
	
	for(int x=1000; x<=8000; x+=1000)
	{
		glPushMatrix();
		if (x == 8000) {
			double z;
			interpolate(time, moveTimer[1][0], moveTimer[1][1], z, 7000, 5000);
			glTranslatef(x, 0, z);
			glCallList(pawn);
		}
		else if (x == 7000) {
			double z;
			interpolate(time, moveTimer[5][0], moveTimer[5][1], z, 7000, 5000);
			glTranslatef(x, 0, z);
			glCallList(pawn);
		}
		else if (x == 3000) {
			double y;
			double fade;
			interpolate(time, moveTimer[6][0]+.5, moveTimer[6][1]+2, y, 0, 2000);
			interpolate(time, moveTimer[6][0]+.5, moveTimer[6][1]+2, fade, 1, 0);
			GLfloat goldFading[] = {(float)229/255, (float)208/255, (float)143/255, fade};
			glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, goldFading);
			glTranslatef(x, y, 7000);
			glScaled(fade, 1, fade);
			glCallList(pawn);
			glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, gold);
		}
		else {
			glTranslatef(x, 0, 7000);
			glCallList(pawn);
		}
		glPopMatrix();
	}

	GLfloat light_position[] = { 1,2,-.1, 0 }; // light comes FROM this vector direction.
	glLightfv(GL_LIGHT0, GL_POSITION, light_position); // position first light

	glLightfv(GL_LIGHT1, GL_POSITION, light_position); // position first light

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
		case 'a':
			gTheta += 2;
			gTheta %= 360;
			eye[0] = h + viewRadius * sin(gTheta * PI / 180);
			eye[2] = k + viewRadius * cos(gTheta * PI / 180);
			break;
		case 'd':
			gTheta -= 2;
			gTheta %= 360;
			eye[0] = h + viewRadius * sin(gTheta * PI / 180);
			eye[2] = k + viewRadius * cos(gTheta * PI / 180);
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
	double aspectRatio = (GLdouble) w/(GLdouble) h;
	gluPerspective( 
	/* field of view in degree */ 45.0,
	/* aspect ratio */ aspectRatio,
	/* Z near */ 100, /* Z far */ 30000.0);
	glMatrixMode(GL_MODELVIEW);
}

// This callback function gets called by the Glut
// system whenever the window is resized by the user.
void reshape(int w, int h)
{
	screen_x = w;
	screen_y = h;

	// Set the pixel resolution of the final picture (Screen coordinates).
	glViewport(0, 0, w, h);

	SetPerspectiveView(w,h);
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

	// Make the display lists for speed
	glNewList(pawn, GL_COMPILE);
	DrawPiece("PAWN.POL");
	glEndList();
	glNewList(king, GL_COMPILE);
	DrawPiece("KING.POL");
	glEndList();
	glNewList(queen, GL_COMPILE);
	DrawPiece("QUEEN.POL");
	glEndList();
	glNewList(rook, GL_COMPILE);
	DrawPiece("ROOK.POL");
	glEndList();
	glNewList(bishop, GL_COMPILE);
	DrawPiece("BISHOP.POL");
	glEndList();
	glNewList(knight, GL_COMPILE);
	DrawPiece("KNIGHT.POL");
	glEndList();

	// set material's specular properties
	GLfloat mat_specular[] = {1.0f, 1.0f, 1.0f, 1.0f};
	GLfloat mat_shininess[] = {50.0f};
	glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
	glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);

	// set light properties
	GLfloat light_position[] = {(float)-500, (float)2000, (float)-500,1};
	GLfloat white_light[] = {1,1,1,1};
	GLfloat low_light[] = {.3f,.3f,.3f,1};
	glLightfv(GL_LIGHT0, GL_POSITION, light_position); // position first light
	glLightfv(GL_LIGHT0, GL_DIFFUSE, white_light); // specify first light's color
	glLightfv(GL_LIGHT0, GL_SPECULAR, low_light);

	GLfloat light_position1[] = {(float)8500, (float)2000, (float)-500,1};
	glLightfv(GL_LIGHT1, GL_POSITION, light_position1); // position first light
	glLightfv(GL_LIGHT1, GL_DIFFUSE, white_light); // specify first light's color
	glLightfv(GL_LIGHT1, GL_SPECULAR, low_light);

	glEnable(GL_DEPTH_TEST); // turn on depth buffering
	glEnable(GL_LIGHTING);	// enable general lighting
	glEnable(GL_LIGHT0);	// enable the first light.
}


int main(int argc, char **argv)
{
	glutInit(&argc, argv);

	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(screen_x, screen_y);
	glutInitWindowPosition(10, 10);

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

	glClearColor((float)135/255,(float)206/255,(float)235/255,1);	
	InitializeMyStuff();

	glutMainLoop();

	return 0;
}
