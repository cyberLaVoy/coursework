// Your Name Here!
// CS 3600
// Ray Tracer, crippled
// Modified in 2010 to detect MAC empty lines.


#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <math.h>
#include <string.h>
#include <fstream>
#include <algorithm>
#include <iostream>
#include <time.h>
using namespace std;
#include "glut.h"
#include "graphics.h"
#include "vector.h"

// Turn this to zero to see OpenGL draw the correct picture.
// Turn it to one, and have your code ray-trace it the same way.
#define RAY_TRACE 1
bool gAntiAlias = true;
bool gShadows = true;

class Sphere
{
public:
	Point3 origin;
	float radius;
	float ambient[4]; // ambient rgb1;
	float diffuse[4]; // diffuse rgb1;
	float specular[4]; // specular rgb1
	float specular_exponent;
};

class Scene
{
public:
	Scene();
	~Scene();
	bool Load(const char * filename);
	void CreateRay(int x, int y, Vector3 & ray);
	void CastRay(const Vector3 & ray, float &r,float &g,float &b);
	void CalculateRightAndUp();

	// These values are loaded from the input file:
	int version; // version number of the file format.
	Point3 eye; // eye point
	Point3 at; // at point
	Vector3 up; // up vector
	float near_plane, far_plane; // near and far planes distances
	float fov; // field of view;
	int screen_x, screen_y; // screen size
	int num_point_lights;
	Point4 * pl;
	int num_spheres;
	Sphere * s;

	// These are calculated from the values read from the input file above:
	bool first_time;
	Vector3 forward;
	Vector3 right;
	Point3 ww_tr; // World Windows top right.
	Point3 ww_tl; // World Windows top left.
	Point3 ww_bl; // World Windows bottom left.
	Point3 ww_br; // World Windows bottom right.

	// These values store your ray traced pixels:
	GLubyte *pixels_red; // holds all pixels in the screen
	GLubyte *pixels_green;
	GLubyte *pixels_blue;
};

Scene::Scene()
{
	first_time = true;
	pl=NULL;
	s=NULL;
	pixels_red=NULL;
	pixels_green=NULL;
	pixels_blue=NULL;
}

Scene::~Scene()
{
	if(pl!=NULL)
		delete [] pl;
	if(s!=NULL)
		delete [] s;
	if(pixels_red!=NULL)
		delete [] pixels_red;
	if(pixels_green!=NULL)
		delete [] pixels_green;
	if(pixels_blue!=NULL)
		delete [] pixels_blue;
}

// These are the calculations we did in class.
void Scene::CalculateRightAndUp()
{
	first_time = false; // don't need to do this again.

	// Calculate Forward vector
	forward = at - eye;
	// Normalize Forward vector.
	forward.Normalize();
	// Right vector is Forward cross Up
	right = CrossProduct(forward, up);
	// Normalize Right vector.
	right.Normalize();
	// Reset Up vector to be Right cross Forward
	up = CrossProduct(right, forward);
	// Set World window corners to be a little in front of eye.
	double u = tan(fov*3.1416 / 360);
	double r = u * (double)screen_x / (double)screen_y;
	ww_tr = eye + forward + u * up + r*right;
	ww_tl = eye + forward + u * up - r*right;
	ww_br = eye + forward - u * up + r*right;
	ww_bl = eye + forward - u * up - r*right;
}

// These are the calculations we did in class.
void Scene::CreateRay(int x, int y, Vector3 &ray)
{
	if(first_time)
	{
		CalculateRightAndUp();
	}

	// Calculate right_ratio and up_ratio.
	double right_ratio = (double)x / (double)screen_x;
	double up_ratio = (double)y / (double)screen_y;
	// Calculate where x,y on the screen maps to on the WorldWindow (film.)
	Vector3 right = ww_br - ww_bl;
	Vector3 up = ww_tl - ww_bl;
	Point3 f = ww_bl + (right)*right_ratio + (up)*up_ratio;
	// Generate a ray from the eye to the film position.
	ray = f - eye;
	ray.Normalize();
}

// These are the calculations we did in class.
bool RayIntersectSphere(const Point3& eye,
						const Vector3& ray, 
						const Sphere& s,
						float& distance,
						Point3& intersection_point,
						Vector3& intersection_normal
						)
{
	Vector3 eo = eye - s.origin;
	double A = DotProduct(ray, ray);
	double B = 2*DotProduct(eo, ray);
	double C = DotProduct(eo, eo) - s.radius*s.radius;
	double determinant = B * B - 4 * A*C;
	if (determinant < 0) {
		return false;
	}
	double T1 = (-B + sqrt(B*B - 4 * A*C)) / (2 * A);
	double T2 = (-B - sqrt(B*B - 4 * A*C)) / (2 * A);
	if (T1 < 0 && T2 < 0) {
		return false;
	}
	else if (T2 < 0) {
		distance = T1;
	}
	else if (T1 < 0) {
		distance = T2;
	}
	else {
		distance = std::min(T1, T2);
	}
	intersection_point = eye + distance * ray;
	intersection_normal = intersection_point - s.origin;
	intersection_normal.Normalize();
	return true;
}

// Some free code for you.
void Scene::CastRay(const Vector3 &ray,float &r,float &g,float &b)
{
	float closest_distance = far_plane; // far plane.
	int closest_hit_sphere = -1;
	Point3 closest_point;
	Vector3 closest_normal;

	for(int i=0; i<num_spheres; i++)
	{
		float distance;
		Point3 intersection_point;
		Vector3 intersection_normal;
		bool hit = RayIntersectSphere(	eye, ray, s[i], 
										distance,
										intersection_point,
										intersection_normal
										);
		if(hit && distance < closest_distance)
		{
			closest_hit_sphere = i;
			closest_distance = distance;
			closest_point = intersection_point;
			closest_normal = intersection_normal;
		}
	}

	// Add correct lighting. This is for Program #11.
	if (closest_hit_sphere != -1)
	{

		// Add ambient color
		r = s[closest_hit_sphere].ambient[0];
		g = s[closest_hit_sphere].ambient[1];
		b = s[closest_hit_sphere].ambient[2];


		// Add diffuse and specular color
		for (int i = 0; i < num_point_lights; i++) {
			// pl[i] is current light source
			Vector3 toLight = pl[i] - closest_point;
			toLight.Normalize();
			bool lightBlocked = false;
			for (int j = 0; j < num_spheres; j++) {
				float d; Point3 ip; Vector3 in;
				if (j != closest_hit_sphere) {
					if (RayIntersectSphere(closest_point, toLight, s[j], d, ip, in)) {
						lightBlocked = true;
					}
				}
			}
			if (lightBlocked && gShadows) {
				// do nothing
			}
			else {
				Vector3 toEye = eye - closest_point;
				toEye.Normalize();
				// diffuse contribution:
				double dot = DotProduct(toLight, closest_normal);
				if (dot > 0) {
					r += (s[closest_hit_sphere].diffuse[0] * dot);
					g += (s[closest_hit_sphere].diffuse[1] * dot);
					b += (s[closest_hit_sphere].diffuse[2] * dot);
				}
				// specular contribution:
				Vector3 sum = toLight + toEye;
				sum.Normalize();
				double dot2 = DotProduct(sum, closest_normal);
				if (dot > 0) {
					if (dot2 > 0) {
						dot2 = pow(dot2, s[i].specular_exponent);
						r += (s[closest_hit_sphere].specular[0] * dot2);
						g += (s[closest_hit_sphere].specular[1] * dot2);
						b += (s[closest_hit_sphere].specular[2] * dot2);
					}
				}
				if (r > 1.0) {
					r = 1.0;
				}
				if (g > 1.0) {
					g = 1.0;
				}
				if (b > 1.0) {
					b = 1.0;
				}
			}
		}
	}

	else
	{
		r = g = b = .0;
	}
}

const int bufsize = 200;
bool ReadActualLine(ifstream & in, char buffer[])
{
	do
	{
		in.getline(buffer, bufsize);
		if(in.eof())
			return false;
	}
	while(strlen(buffer)==0 || buffer[0] == '/' || buffer[0] == '\n' || buffer[0] == '\r'); // ignore empty lines and comment lines.

	return true;
}

bool ReadInteger(ifstream & in, int & x)
{
	char buffer[bufsize];
	if(!ReadActualLine(in,buffer))
		return false;

	if(sscanf(buffer, "%i", &x) != 1)
		return false;

	return true;
}

bool ReadFloat(ifstream & in, float & x)
{
	char buffer[bufsize];
	if(!ReadActualLine(in,buffer))
		return false;

	if(sscanf(buffer, "%f", &x) != 1)
		return false;

	return true;
}

bool ReadPoint3(ifstream & in, Point3 & p)
{
	char buffer[bufsize];
	if(!ReadActualLine(in,buffer))
		return false;

	if(sscanf(buffer, "%f %f %f", &p.p[0], &p.p[1], &p.p[2]) != 3)
		return false;

	return true;
}

// Read 3 values, set last to 1.0;
bool ReadPoint4(ifstream & in, Point4 & p)
{
	char buffer[bufsize];
	if(!ReadActualLine(in,buffer))
		return false;

	if(sscanf(buffer, "%f %f %f", &p.p[0], &p.p[1], &p.p[2]) != 3)
		return false;

	p.p[3] = 1.0;

	return true;
}

bool ReadVector(ifstream & in, Vector3 & v)
{
	char buffer[bufsize];
	if(!ReadActualLine(in,buffer))
		return false;

	if(sscanf(buffer, "%f %f %f", &v.v[0], &v.v[1], &v.v[2]) != 3)
		return false;

	return true;
}

bool Scene::Load(const char * filename)
{
	ifstream in(filename, ios::in);
	if(!in)
	{
		cerr << "Error. Could not open file " << filename << endl;
		return false;
	}

	//
	// Read in all data from non-empty, non-comment lines.
	//
	if(!ReadInteger(in, version))
		return false;

	if(!ReadPoint3(in, eye))
		return false;

	if(!ReadPoint3(in, at))
		return false;

	if(!ReadVector(in, up))
		return false;

	if(!ReadFloat(in, near_plane))
		return false;

	if(!ReadFloat(in, far_plane))
		return false;

	if(!ReadFloat(in, fov))
		return false;

	if(!ReadInteger(in, screen_x))
		return false;

	if(!ReadInteger(in, screen_y))
		return false;

	pixels_red = new GLubyte[screen_x*screen_y];
	if(!pixels_red)
		return false;
	pixels_green = new GLubyte[screen_x*screen_y];
	if(!pixels_green)
		return false;
	pixels_blue = new GLubyte[screen_x*screen_y];
	if(!pixels_blue)
		return false;


	// Read in all point lights.
	if(!ReadInteger(in, num_point_lights))
		return false;

	pl = new Point4[num_point_lights];
	int i;
	for(i=0; i<num_point_lights; i++)
	{
		if(!ReadPoint4(in, pl[i]))
			return false;
	}

	// Read in all Spheres.
	if(!ReadInteger(in, num_spheres))
		return false;

	s = new Sphere[num_spheres];
	for(i=0; i<num_spheres; i++)
	{
		if(!ReadPoint3(in, s[i].origin))
			return false;

		if(!ReadFloat(in, s[i].radius))
			return false;

		char buffer[bufsize];
		if(!ReadActualLine(in,buffer))
			return false;
		if(sscanf(buffer, "%f %f %f", &s[i].ambient[0], &s[i].ambient[1], &s[i].ambient[2]) != 3)
			return false;
		s[i].ambient[3] = 1;

		if(!ReadActualLine(in,buffer))
			return false;
		if(sscanf(buffer, "%f %f %f", &s[i].diffuse[0], &s[i].diffuse[1], &s[i].diffuse[2]) != 3)
			return false;
		s[i].diffuse[3] = 1;

		if(!ReadActualLine(in,buffer))
			return false;
		if(sscanf(buffer, "%f %f %f %f", &s[i].specular[0], &s[i].specular[1], &s[i].specular[2], &s[i].specular_exponent) != 4)
			return false;
		s[i].specular[3] = 1;
	}

	
	return true;
}


Scene the_scene;


void DrawSphere(float x, float y, float z, float radius)
{
	glPushMatrix();
	glTranslatef(x,y,z);
	int slices = 40;
	int stacks = 40;
	glutSolidSphere(radius, slices, stacks);
	glPopMatrix();
}

//
// GLUT callback functions
//

// This callback function gets called by the Glut
// system whenever it decides things need to be redrawn.
void display(void)
{
#if RAY_TRACE
	glClear(GL_COLOR_BUFFER_BIT);
	int offset = 0;
	if (gAntiAlias) {
		offset = the_scene.screen_x + 1;
	}
	glBegin(GL_POINTS);
	for(int y=0; y<the_scene.screen_y; y++)
	{
		for(int x=0; x<the_scene.screen_x; x++)
		{
			double red = the_scene.pixels_red[offset];
			double green = the_scene.pixels_green[offset];
			double blue = the_scene.pixels_blue[offset];
			if (gAntiAlias) {
				int self = offset;
				int top = offset - the_scene.screen_x;
				int bottom = offset + the_scene.screen_x;
				int left = offset - 1;
				int right = offset + 1;
				red = the_scene.pixels_red[self] + the_scene.pixels_red[top] + the_scene.pixels_red[right] +the_scene.pixels_red[bottom] + the_scene.pixels_red[left];
				red /= 5;
				green = the_scene.pixels_green[self] + the_scene.pixels_green[top] + the_scene.pixels_green[right] +the_scene.pixels_green[bottom] + the_scene.pixels_green[left];
				green /= 5;
				blue = the_scene.pixels_blue[self] + the_scene.pixels_blue[top] + the_scene.pixels_blue[right] +the_scene.pixels_blue[bottom] + the_scene.pixels_blue[left];
				blue /= 5;
			}
			glColor3ub(red, green, blue);
			glVertex2d(x+.5,y+.5);
			offset++;
		}
	}
	glEnd();
	glFlush();
#else
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glLoadIdentity();

	gluLookAt(	the_scene.eye.p[0], the_scene.eye.p[1], the_scene.eye.p[2],
				the_scene.at.p[0], the_scene.at.p[1], the_scene.at.p[2],
				the_scene.up.v[0], the_scene.up.v[1], the_scene.up.v[2]);

	for(int i=0; i<the_scene.num_spheres; i++)
	{
		glMaterialfv(GL_FRONT, GL_AMBIENT, the_scene.s[i].ambient);
		glMaterialfv(GL_FRONT, GL_DIFFUSE, the_scene.s[i].diffuse);
		glMaterialfv(GL_FRONT, GL_SPECULAR, the_scene.s[i].specular);
		glMaterialf(GL_FRONT, GL_SHININESS, the_scene.s[i].specular_exponent);
		Point3 &ori = the_scene.s[i].origin;
		DrawSphere(ori.p[0], ori.p[1], ori.p[2], the_scene.s[i].radius);
	}

	glutSwapBuffers();
#endif
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
		default:
			return; // if we don't care, return without glutPostRedisplay()
	}

	glutPostRedisplay();
}


void SetTopView(int w, int h)
{
	// go into 2D mode
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();

	// Depending on the graphics card, either of the next two lines might work.
	gluOrtho2D(0,w,0,h);
	//gluOrtho2D(0,w-1,0,h-1);

	glMatrixMode(GL_MODELVIEW);
}

void SetPerspectiveView(int w, int h)
{
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	float aspectRatio = (GLdouble) w/(GLdouble) h;
	gluPerspective( 
	/* field of view in degree */ the_scene.fov,
	/* aspect ratio */ aspectRatio,
	/* Z near */ the_scene.near_plane, /* Z far */ the_scene.far_plane);
	glMatrixMode(GL_MODELVIEW);
}


// This callback function gets called by the Glut
// system whenever the window is resized by the user.
void reshape(int w, int h)
{
	// Set the pixel resolution of the final picture (Screen coordinates).
	glViewport(0, 0, w, h);

#if RAY_TRACE
	SetTopView(w,h);
#else
	SetPerspectiveView(w,h);
#endif

}


// Your initialization code goes here.
void PreInitializeMyStuff()
{
	if(!the_scene.Load("model.txt"))
	{
		exit(1);
	}

#if RAY_TRACE
	int offset = 0;

	Vector3 ray; // represents each ray.
	float r,g,b; // represents the color for each pixel

	for(int y=0; y<the_scene.screen_y; y++)
	{
		for(int x=0; x<the_scene.screen_x; x++)
		{
			the_scene.CreateRay(x, y, ray);
			the_scene.CastRay(ray,r,g,b);
			the_scene.pixels_red[offset] = GLubyte(r*255);
			the_scene.pixels_green[offset] = GLubyte(g*255);
			the_scene.pixels_blue[offset] = GLubyte(b*255);

			offset++;
		}
	}
#endif
}


// Your initialization code goes here.
void InitializeMyStuff()
{
#if RAY_TRACE
#else
	glEnable(GL_LIGHTING);	// enable general lighting

	GLfloat white_light[] = {.8,.8,.8,1};
	GLfloat low_light[] = {.2,.2,.2,1};
	// set light properties
	for(int i=0; i<the_scene.num_point_lights; i++)
	{
		glLightfv(GL_LIGHT0+i, GL_POSITION, the_scene.pl[i].p); // position light i
		glLightfv(GL_LIGHT0+i, GL_DIFFUSE, white_light); // specify light's color
		glLightfv(GL_LIGHT0+i, GL_SPECULAR, white_light);
		glEnable(GL_LIGHT0+i);	// enable the light i.
	}

	glEnable(GL_DEPTH_TEST); // turn on depth buffering
	glShadeModel(GL_SMOOTH);
	glLightModeli(GL_LIGHT_MODEL_LOCAL_VIEWER, GL_TRUE);
#endif
}

int main(int argc, char **argv)
{
	PreInitializeMyStuff();

	glutInit(&argc, argv);
#if RAY_TRACE
	glutInitDisplayMode(GLUT_RGB);
#else
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
#endif
	glutInitWindowSize(the_scene.screen_x, the_scene.screen_y);
	glutInitWindowPosition(0, 0);

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

	glClearColor(0,0,0,0);	
	InitializeMyStuff();

	glutMainLoop();

	return 0;
}
