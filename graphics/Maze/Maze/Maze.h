#pragma once
#include<map>
#include<string>
#include<vector>
#include "main.h"

const int M = 21;
const int N = 21;

class Cell
{
public:
	Cell();
	void setRight(bool visable) { mRight = visable; };
	void setLeft(bool visable) { mLeft = visable; };
	void setTop(bool visable) { mTop = visable; };
	void setBottom(bool visable) { mBottom = visable; };
	bool getRight() { return mRight; };
	bool getLeft() { return mLeft; };
	bool getTop() { return mTop; };
	bool getBottom() { return mBottom; };

	void draw(int i, int j);
	void setVisited(bool visited);
	bool isVisited();
	void removeWall(std::string placement, Cell* neighbor);
	void addWall(std::string placement, Cell* neighbor);


private:
	bool mRight, mLeft, mTop, mBottom;
	bool mVisited;
};

class Maze
{
public:
	Maze();
	~Maze();
	void drawFloor();
	void drawSky();
	void draw();
	std::map<std::string, Cell*> getUnvisitedNeighbors(int i, int j);
	void removeWallsRecursive(int i, int j);
	void removeWalls();
	bool isSafe(double x, double y, double radius);
	void addEntranceAndExit();
	void removeCellWall(std::string orientation, int x, int y);
	void addCellWall(std::string placement, int x, int y);
	void toggleCellWall(std::string placement, int x, int y);
	void setMonsterRat(bool change) { mMonsterRat = change; };
	Cell getCell(int i, int j) { return cells[i][j]; }
private:
	Cell cells[M][N];
	bool mMonsterRat = false;
};


