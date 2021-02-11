Class = require "class"
local images = require "images"
local screen = require "screen"
local settings = require "settings"
local keyboard = require "keyboard"
Character = Class {}

function Character:init()
  self.width = images.character:getWidth()
  self.height = images.character:getHeight()

  self.x = (screen.Virtual.Width / 2) - (self.width / 2)
  self.y = screen.Virtual.Height

  self.dy = 0
end

function Character:render()
  love.graphics.draw(images.character, self.x, self.y)
end

function Character:update(dt)
  self.dy = self.dy + settings.Gravity * dt
  if love.keyboard.isDown(keyboard.Bindings.Jump) then
    self.dy = -settings.Character.Jump
  end
  self.y = self.y + self.dy
  if self.y > screen.Virtual.Height - self.height - 16 then
    self.y = screen.Virtual.Height - self.height - 16
  end

  if love.keyboard.isDown(keyboard.Bindings.Right) then
    self.x = self.x + settings.Character.Movement
  end

  if love.keyboard.isDown(keyboard.Bindings.Left) then
    self.x = self.x - settings.Character.Movement
  end

  if self.x < 16 then
    self.x = 16
  elseif self.x > screen.Virtual.Width - self.width - 16 then
    self.x = screen.Virtual.Width - self.width - 16
  end
end
