import pygame

class Score:

	def __init__(self, color, string, x, y):
		self.mColor = color
		self.mString = string
		self.mX = x
		self.mY = y
		pygame.font.init()
		self.mFont = pygame.font.SysFont("Arial", 50)

	def plus(self):
		self.mString = int(self.mString)
		self.mString += 1
		self.mString = str(self.mString)
	
	def draw(self, surface):
		text_object = self.mFont.render(self.mString, False, self.mColor)
		text_rect = text_object.get_rect()
		text_rect.center = (self.mX, self.mY)
		surface.blit(text_object, text_rect)
