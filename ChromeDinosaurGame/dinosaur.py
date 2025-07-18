import pygame
from constants import RUNNING, DUCKING, JUMPING

class Dinosaur():
    X_POS = 80
    Y_POS = 310
    Y_POS_DUCK = 340
    JUMP_VAL = 8.5

    def __init__(self):
        self.duck_img = DUCKING
        self.run_img = RUNNING
        self.jump_img = JUMPING

        self.dino_duck = False
        self.dino_run = True
        self.dino_jump = False

        self.step_index = 0
        self.jump_val = self.JUMP_VAL
        self.image = self.run_img[0]
        self.dino_rect = self.image.get_rect()
        self.dino_rect.x = self.X_POS
        self.dino_rect.y = self.Y_POS

    def update(self, userInput):
        if self.dino_duck:
            self.duck()
        if self.dino_run:
            self.run()
        if self.dino_jump:
            self.jump()

        if self.step_index >= 10:
            self.step_index = 0

        # 공룡이 동작 됨을 테스트 할 때 다시 와서 볼 조건문들
        # 키보드의 입력과 공룡의 현 상태에 따른 동작을 제어하는 코드
        if userInput[pygame.K_UP] and not self.dino_jump:
            self.dino_duck = False
            self.dino_jump = True
            self.dino_run = False
        elif userInput[pygame.K_DOWN] and not self.dino_jump:
            self.dino_duck = True
            self.dino_jump = False
            self.dino_run = False
        elif not (self.dino_jump or userInput[pygame.K_DOWN]):
            self.dino_duck = False
            self.dino_jump = False
            self.dino_run = True

    def duck(self):
        self.image = self.duck_img
        self.dino_rect = self.image.get_rect()
        self.dino_rect.x = self.X_POS
        self.dino_rect.y = self.Y_POS_DUCK
        self.step_index += 1

    def run(self):
        self.image = self.run_img[self.step_index // 5]
        self.dino_rect = self.image.get_rect()
        self.dino_rect.x = self.X_POS
        self.dino_rect.y = self.Y_POS
        self.step_index += 1

    def jump(self):
        self.image = self.jump_img
        if self.dino_jump:
            self.dino_rect.y -= self.jump_val * 4
            self.jump_val -= 0.8
        if self.jump_val < - self.JUMP_VAL:
            self.dino_jump = False
            self.jump_val = self.JUMP_VAL

    def draw(self, SCREEN):
        SCREEN.blit(self.image, (self.dino_rect.x, self.dino_rect.y))
