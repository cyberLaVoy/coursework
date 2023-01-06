import shape, math, pygame


class Polygon(shape.Shape):
    def __init__(self, x, y, points):
        shape.Shape.__init__(self, x, y)
        self.mPoints = points
        self.mDeltaPoints = []
        self.mRadius = points[0][0]

    def spin(self):
        rot_points = []
        for point_set in self.mPoints:
            x = point_set[0]
            y = point_set[1]
            magnitude = math.sqrt(x ** 2 + y ** 2)
            cur_angle = math.atan2(y, x)
            rot_angle = cur_angle + self.mDirection
            new_x = magnitude * math.cos(rot_angle)
            new_y = magnitude * math.sin(rot_angle)
            rot_points.append((new_x, new_y))
        self.mDeltaPoints = rot_points

    def translate(self, points):
        trans_points = []
        for point_set in points:
            new_x = point_set[0] + self.mX
            new_y = point_set[1] + self.mY
            trans_points.append((new_x, new_y))
        self.mDeltaPoints = trans_points

    def transform(self):
        self.spin()
        self.translate(self.mDeltaPoints)

    def paint(self, surface):
        if self.mIsAlive:
            pygame.draw.polygon(surface, self.mColor, self.mDeltaPoints, self.mBorder)
