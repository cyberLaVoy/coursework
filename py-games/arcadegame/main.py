import pygame, math, game_mouse

import pong, paddle

class PygameStarter(game_mouse.Game):

    def __init__(self, width, height, fps):
        game_mouse.Game.__init__(self, "Pygame Starter", width, height, fps)
        self.mPong = pong.Pong(width, height)
        return

    def getScreenW(self):
        return self.mScreenW
    def getScreenH(self):
        return self.mScreenH

    def game_logic(self, keys, newkeys, buttons, newbuttons, mouse_position):
        x = mouse_position[0]
        y = mouse_position[1]

        if pygame.K_k in keys:
            self.mPong.up()
        if pygame.K_j in keys:
            self.mPong.down()
        if pygame.K_h in keys:
            self.mPong.left()
        if pygame.K_l in keys:
            self.mPong.right()

        if 1 in newbuttons:
            print("button clicked")

        return
    
    def paint(self, surface):
        self.mPong.draw(surface)
        self.mPong.animate()
        return

def main():
    screen_width = 900
    screen_height = 600
    fps = 30
    game = PygameStarter(screen_width, screen_height, fps)
    game.main_loop()
    return
    
if __name__ == "__main__":
    main()

