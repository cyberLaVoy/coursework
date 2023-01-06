import pygame
import math
import game_mouse
from pong import Pong

class PygameStarter(game_mouse.Game):

    def __init__(self, width, height, fps):

        game_mouse.Game.__init__(self, "Pygame Starter", width, height, fps)
        self.mScreenW = 900
        self.mScreenH = 700
        self.mPong = Pong(self.mScreenW, self.mScreenH)
        return
        
    def game_logic(self, keys, newkeys, buttons, newbuttons, mouse_position):
        x = mouse_position[0]
        y = mouse_position[1]

        if pygame.K_UP in keys:
            self.mPong.up()
        if pygame.K_DOWN in keys:
            self.mPong.down()

        self.mPong.move()

        if 1 in newbuttons:
            print("button clicked")

        return
    
    def paint(self, surface):
        self.mPong.draw(surface)
        return

def main():
    screen_width = 900
    screen_height = 700
    frames_per_second = 30
    game = PygameStarter(screen_width, screen_height, frames_per_second)
    game.main_loop()
    return
    
if __name__ == "__main__":
    main()

