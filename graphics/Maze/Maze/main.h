#pragma once

void DrawCircle(double x1, double y1, double z1, double radius);
void DrawRectangle(double x1, double y1, double x2, double y2);
void drawWall(double x1, double y1, double x2, double y2);
enum viewtype { top_view, perspective_view, rat_view };
const int num_textures = 4;
extern unsigned int texName[num_textures];
