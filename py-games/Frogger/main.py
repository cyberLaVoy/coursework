import pygame, math, game_mouse

import game

class PygameStarter(game_mouse.Game):

    def __init__(self, width, height, fps):
        game_mouse.Game.__init__(self, "Pygame Starter", width, height, fps)
        self.mGame = game.Game(width, height)
        return

    def getScreenW(self):
        return self.mScreenW
    def getScreenH(self):
        return self.mScreenH

    def game_logic(self, keys, newkeys, buttons, newbuttons, mouse_position):
        x = mouse_position[0]
        y = mouse_position[1]

        if pygame.K_k in keys:
            self.mGame.up()
        if pygame.K_j in keys:
            self.mGame.down()
        if pygame.K_h in keys:
            self.mGame.left()
        if pygame.K_l in keys:
            self.mGame.right()

        if 1 in newbuttons:
            print("button clicked")

        return
    
    def paint(self, surface):
        self.mGame.vehicleLists()
        self.mGame.turtleLists()
        self.mGame.logLists()
        self.mGame.collisions()
        self.mGame.draw(surface)
        self.mGame.animate()
        return

def main():
    screen_width = 500
    screen_height = 50*11
    fps = 30
    game = PygameStarter(screen_width, screen_height, fps)
    game.main_loop()
    return
    
if __name__ == "__main__":
    main()

