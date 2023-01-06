
#include<iostream>
#include "Maze.h"
#include "glut.h"
extern viewtype current_view;

Maze::Maze()
{
}
Maze::~Maze()
{
}

void Maze::drawFloor()
{
	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, texName[3]);
	glBegin(GL_QUADS);
	glTexCoord2f(0,0); glVertex2d(0,0);
	glTexCoord2f(M,0); glVertex2d(M,0);
	glTexCoord2f(M,M); glVertex2d(M,N);
	glTexCoord2f(0,M); glVertex2d(0,N);
	glEnd();
	glDisable(GL_TEXTURE_2D);
}
void Maze::drawSky()
{
	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, texName[2]);
	glBegin(GL_QUADS);
	static double textureBottom = 0.0;
	glTexCoord2f(0,textureBottom); glVertex3d(-M*2,-N*2, 5);
	glTexCoord2f(1,textureBottom); glVertex3d(M*2,-N*2, 5);
	glTexCoord2f(1,textureBottom +1); glVertex3d(M*2,N*2, 5);
	glTexCoord2f(0,textureBottom+1); glVertex3d(-M*2,N*2, 5);
	textureBottom -= .0001;
	glEnd();
	glDisable(GL_TEXTURE_2D);
}


void Maze::draw()
{
	drawFloor();
	drawSky();
	for (int i = 0; i < M; i++) {
		for (int j = 0; j < N; j++) {
			cells[i][j].draw(i, j);
		}
	}
}

std::map<std::string, Cell*> Maze::getUnvisitedNeighbors(int i, int j)
{
	std::map<std::string, Cell*> unvisitedNeighbors;
	if (i + 1 < M) {
		if (!cells[i+1][j].isVisited()) {
			unvisitedNeighbors["right"] = &cells[i+1][j];
		}
	}
	if (i - 1 >= 0) {
		if (!cells[i-1][j].isVisited()) {
			unvisitedNeighbors["left"] = &cells[i-1][j];
		}
	}
	if (j + 1 < N) {
		if (!cells[i][j+1].isVisited()) {
			unvisitedNeighbors["top"] = &cells[i][j+1];
		}
	}
	if (j - 1 >= 0) {
		if (!cells[i][j-1].isVisited()) {
			unvisitedNeighbors["bottom"] = &cells[i][j-1];
		}
	}
	return unvisitedNeighbors;
}


void updateLocation(std::string location, int i, int j, int& next_i, int& next_j) {
	if (location == "top") {
		next_j = j+1;
	}
	else if (location == "bottom") {
		next_j = j-1;
	}
	else if (location == "right") {
		next_i = i+1;
	}
	else if (location == "left") {
		next_i = i-1;
	}
}
void Maze::removeWallsRecursive(int i, int j)
{
	Cell* current = &cells[i][j];
	current->setVisited(true);
	bool neighborsAvailable = false;
	std::map<std::string, Cell*> unvisitedNeighbors = getUnvisitedNeighbors(i, j);
	if (unvisitedNeighbors.size() != 0) {
		neighborsAvailable = true;
	}
	while (neighborsAvailable) {

		std::vector<std::string> v;
		for ( std::map<std::string, Cell*>::iterator it = unvisitedNeighbors.begin(); it != unvisitedNeighbors.end(); ++it) {
			v.push_back(it->first);
		}
		int random = rand() % v.size();
		std::string key = v[random];
		Cell* neighbor = unvisitedNeighbors[key];
		current->removeWall(key, neighbor);
		int next_i = i;
		int next_j = j;
		updateLocation(key, i, j, next_i,next_j);
		removeWallsRecursive(next_i, next_j);
		neighborsAvailable = false;
		unvisitedNeighbors = getUnvisitedNeighbors(i, j);
		if (unvisitedNeighbors.size() != 0) {
			neighborsAvailable = true;
		}
	}
}
void Maze::removeWalls()
{
	removeWallsRecursive(0,0);
}

Cell::Cell()
{
	mLeft = mTop = mRight = mBottom = true;
	mVisited = false;
}

void drawWall(double x1, double y1, double x2, double y2)
{

	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, texName[1]);

	//glColor3d(1,x1/N,y1/M);
	glBegin(GL_QUADS);
	glTexCoord2f(-1, -1); glVertex3d(x1,y1, 0);
	glTexCoord2f(2, -1); glVertex3d(x2,y2, 0);
	glTexCoord2f(2, 2); glVertex3d(x2,y2, 1);
	glTexCoord2f(-1, 2); glVertex3d(x1,y1, 1);
	glEnd();

	glDisable(GL_TEXTURE_2D);
}
void drawLine(double x1, double y1, double x2, double y2) {
	glColor3d(1,x1/N,y1/M);
	glBegin(GL_LINES);
	glVertex2i(x1, y1);
	glVertex2i(x2, y2);
	glEnd();
}

void Cell::draw(int i, int j) {
	if (current_view == top_view)
	{
		if (mBottom) {
			drawLine(i, j, i + 1, j);
		}
		if (mLeft) {
			drawLine(i, j, i, j+1);
		}
		if (mRight) {
			drawLine(i+1, j, i+1, j+1);
		}
		if (mTop) {
			drawLine(i, j+1, i+1, j+1);
		}
		// draw walls as GL_LINES
	}
	else
	{
		if (mBottom) {
			drawWall(i, j, i + 1, j);
		}
		if (mLeft) {
			drawWall(i, j, i, j+1);
		}
		if (mRight) {
			drawWall(i+1, j, i+1, j+1);
		}
		if (mTop) {
			drawWall(i, j+1, i+1, j+1);
		}
		// draw walls as GL_QUADS
		// figure out a way to draw each wall in a different color. (you don't have to save the color of the wall)
		// figure out a way to prevent two co-planar wall from 'bleeding' on top of each other when drawing.
	}



}

void Cell::setVisited(bool visited)
{
	mVisited = visited;
}

bool Cell::isVisited()
{
	return mVisited;
}

void Cell::removeWall(std::string placement, Cell * neighbor)
{
	if (placement == "top") {
		this->setTop(false);
		neighbor->setBottom(false);
	}
	else if (placement == "bottom") {
		this->setBottom(false);
		neighbor->setTop(false);
	}
	else if (placement == "right") {
		this->setRight(false);
		neighbor->setLeft(false);
	}
	else if (placement == "left") {
		this->setLeft(false);
		neighbor->setRight(false);
	}
	else {
	}
}

void Cell::addWall(std::string placement, Cell * neighbor)
{
	if (placement == "top") {
		this->setTop(true);
		neighbor->setBottom(true);
	}
	else if (placement == "bottom") {
		this->setBottom(true);
		neighbor->setTop(true);
	}
	else if (placement == "right") {
		this->setRight(true);
		neighbor->setLeft(true);
	}
	else if (placement == "left") {
		this->setLeft(true);
		neighbor->setRight(true);
	}
	else {
	}
}

bool Maze::isSafe(double x, double y, double radius)
{
	int i = (int)x;
	int j = (int)y;
	double cX = x - i;
	double cY = y - j;
	if (cells[i][j].getLeft() && cX - radius < 0) {
		if (mMonsterRat) {
			removeCellWall("left", i, j);
			return true;
		}
		return false;
	}
	if (cells[i][j].getRight() && cX + radius > 1) {
		if (mMonsterRat) {
			removeCellWall("right", i, j);
			return true;
		}
		return false;
	}
	if (cells[i][j].getBottom() && cY - radius < 0) {
		if (mMonsterRat) {
			removeCellWall("bottom", i, j);
			return true;
		}
		return false;
	}
	if (cells[i][j].getTop() && cY + radius > 1) {
		if (mMonsterRat) {
			removeCellWall("top", i, j);
			return true;
		}
		return false;
	}
	// bottom right corner check
	if (cX + radius > 1 && cY - radius < 0) {
		return false;
	}
	// top left corner check
	if (cY + radius > 1 && cX - radius < 0) {
		return false;
	}
	// bottom left corner check
	if (cY - radius < 0 && cX - radius < 0) {
		return false;
	}
	// top right corner check
	if (cY + radius > 1 && cX + radius > 1) {
		return false;
	}
	return true;
}

void Maze::addEntranceAndExit()
{
	cells[0][0].setBottom(false);
	cells[M-1][N-1].setTop(false);
}

void Maze::removeCellWall(std::string placement, int x, int y)
{
	if (placement == "top") {
		Cell* neighbor = &cells[x][y + 1];
		cells[x][y].removeWall(placement, neighbor);
	}
	else if (placement == "bottom") {
		Cell* neighbor = &cells[x][y - 1];
		cells[x][y].removeWall(placement, neighbor);
	}
	else if (placement == "right") {
		Cell* neighbor = &cells[x+1][y];
		cells[x][y].removeWall(placement, neighbor);
	}
	else if (placement == "left") {
		Cell* neighbor = &cells[x-1][y];
		cells[x][y].removeWall(placement, neighbor);
	}
}

void Maze::addCellWall(std::string placement, int x, int y)
{
	if (placement == "top") {
		Cell* neighbor = &cells[x][y + 1];
		cells[x][y].addWall(placement, neighbor);
	}
	else if (placement == "bottom") {
		Cell* neighbor = &cells[x][y - 1];
		cells[x][y].addWall(placement, neighbor);
	}
	else if (placement == "right") {
		Cell* neighbor = &cells[x+1][y];
		cells[x][y].addWall(placement, neighbor);
	}
	else if (placement == "left") {
		Cell* neighbor = &cells[x-1][y];
		cells[x][y].addWall(placement, neighbor);
	}
}

void Maze::toggleCellWall(std::string placement, int x, int y)
{
	bool toggle;
	if (placement == "top") {
		toggle = getCell(x, y).getTop();
	}
	else if (placement == "bottom") {
		toggle = getCell(x, y).getBottom();
	}
	else if (placement == "right") {
		toggle = getCell(x, y).getRight();
	}
	else if (placement == "left") {
		toggle = getCell(x, y).getLeft();
	}
	if (toggle) {
		removeCellWall(placement, x, y);
	}
	else {
		addCellWall(placement, x, y);
	}
}
