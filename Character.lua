Character = Class{}
local images = require 'images'
local screen = require 'screen'
local GRAVITY = 100

function Character:init()
    self.image = images.character
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = (screen.Virtual.Width / 2) - (self.width / 2)
    self.y = screen.Virtual.Height

    self.dy = 0
end

function Character:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Character:update(dt)
  self.dy = self.dy + GRAVITY * dt
  if love.keyboard.wasPressed('space') then
    self.dy = -25
  end
  self.y = self.y + self.dy
  if self.y > screen.Virtual.Height - self.height - 16 then
    self.y = screen.Virtual.Height - self.height - 16
  end

  if love.keyboard.isDown('right') then
    self.x = self.x + 15
  end

  if love.keyboard.isDown('left') then
    self.x = self.x - 15
  end

  if self.x < 16 then
    self.x = 16
  elseif self.x > screen.Virtual.Width - self.width - 16 then
    self.x = screen.Virtual.Width - self.width - 16
  end
end
