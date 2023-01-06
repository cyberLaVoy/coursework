from config import *
import pygame, game_mouse, math, ship, rockgenerator

ShipPoints  = [(8, 0), (10, 4), (-10, 15), (-8, 4), (-10, 0), (-8, -4), (-10, -15), (10, -4)]

class PygameStarter(game_mouse.Game):
    def __init__(self):
        game_mouse.Game.__init__(self, "Asteroids", ScrW, ScrH, fps)
        self.mShip = ship.Ship(ScrW / 2, ScrH / 2, ShipPoints)
        self.mBullets = []
        self.mRocks = rockgenerator.generateRocks(17)

    def game_logic(self, keys, newkeys, buttons, newbuttons, mouse_position):
        if pygame.K_SPACE in newkeys:
            b = self.mShip.fire()
            self.mBullets.append(b)

        if pygame.K_UP in keys:
            self.mShip.accelerate()
        if pygame.K_UP not in keys:
            self.mShip.deccelerate()
        if pygame.K_LEFT in keys:
            self.mShip.rotate(-math.pi / 24)
        if pygame.K_RIGHT in keys:
            self.mShip.rotate(math.pi / 24)

        for b in self.mBullets:
            for r in self.mRocks:
                if b.hits(r):
                    r.mIsAlive = False
                    b.mIsAlive = False
        for r in self.mRocks:
            if self.mShip.hits(r):
                self.mShip.mIsAlive = False
                print('You are dead')
                quit()

        for r1 in self.mRocks:
            for r2 in self.mRocks:
                if r1 != r2 and r1.hits(r2):
                    r1.mDx = -r1.mDx
                    r1.mDy = -r1.mDy

        counter = 0
        for r in self.mRocks:
            if not r.mIsAlive:
                counter += 1
        if counter == len(self.mRocks):
            print('You win.')
            quit()

    def paint(self, surface):
        surface.fill((0, 0, 0))
        self.mShip.transform()
        self.mShip.wrap()
        self.mShip.paint(surface)
        for b in self.mBullets:
            b.recordDistance()
            for i in range(18):
                b.move()
            b.wrap()
            b.paint(surface)
        for r in self.mRocks:
            r.wander()
            for i in range(20):
                r.danger()
            r.paint(surface)


def main():
    game = PygameStarter()
    game.main_loop()


if __name__ == "__main__":
    main()
