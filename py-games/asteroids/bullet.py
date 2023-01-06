import shape, pygame


class Bullet(shape.Shape):
    def __init__(self, x, y, dx, dy):
        shape.Shape.__init__(self, x, y)
        self.mRadius = 2
        self.mDx = dx
        self.mDy = dy
        self.mDistance = 0

    def recordDistance(self):
        self.mDistance += 1
        if self.mDistance == 35:
            self.mIsAlive = False

    def paint(self, surface):
        if self.mIsAlive:
            pygame.draw.circle(surface, self.mColor,
                               (int(self.mX), int(self.mY)),
                               self.mRadius, self.mBorder)
