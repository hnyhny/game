Class = require "Libraries.class"
local settings = require "Config.settings"
local userInput = require "Input.userInput"
local gravity = require "Physics.gravity"
local animations = require "Rendering.animations"
local image = require "Rendering.image"
local images = require "Resources.images"

local width = images.Character.Standing:getDimensions()
local animationDuration = 1 / settings.Game.AnimationSpeed
local texture = {
   Running = animations.newAnimation(images.Character.Running, width, animationDuration),
   Standing = image.newImage(images.Character.Standing)
  }

local levelSize = settings.Game.LevelSize

local Borders = {
  Left = 0.2 * width,
  Right = levelSize.Width - 1.2 * width,
  Bottom = levelSize.Height - 1.5 * width
}
local Start = {
  X = (levelSize.Width - width) / 2,
  Y = levelSize.Height
}

Character = Class {}
function Character:init()
  self.yVelocity = 0
  self. xVelocity = 0
end

function Character:render(x, y)

  local isRunningRight = self.xVelocity > 0
  local isRunningLeft = self.xVelocity < 0
  local xWithOffset = x - 8
  local yWithOffset = y - 8
  if isRunningRight then
    texture.Running:draw(xWithOffset, yWithOffset)
  elseif isRunningLeft then
    texture.Running:draw(xWithOffset, yWithOffset, 0, -1, 1, texture.Running.width)
  else
    love.graphics.draw(images.Character.Standing, xWithOffset, yWithOffset, 0)
  end
end
function Character:update(dt, xVelocity, yVelocity)
  self.xVelocity = xVelocity
  self.yVelocity = yVelocity
  texture.Running:UpdateCurrentTime(dt)
end
