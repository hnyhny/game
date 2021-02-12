Class = require "Application.class"
local images = require "Resources.images"
local settings = require "settings"
local userInput = require "Input.userInput"

local modelWidth = images.character:getWidth()
local modelHeight = images.character:getHeight()

local level = settings.Screen.Virtual
local characterConfig = settings.Game.Character

local Level = {
  Boarders = {
    Left = 0.5 * modelWidth,
    Right = level.Width - 1.5 * modelWidth,
    Bottom = level.Height - 1.5 * modelHeight
  },
  Start = {
    X = (level.Width - modelWidth) / 2,
    Y = level.Height
  }
}

Character = Class {}
function Character:init()
  self.x = Level.Start.X
  self.y = Level.Start.Y
  self.yVelocity = 0
end

function Character:render()
  love.graphics.draw(images.character, self.x, self.y)
end

local Jumped = {
  Once = false,
}

local function updateYVelocity(yVelocity, deltaTime)
  if userInput.isJump() and not Jumped.Once then
    Jumped.Once = true
    return -characterConfig.Jump.First
 
  else
    return yVelocity + settings.Game.Gravity * deltaTime
  end
end

local function moveY(y, yVelocity)
  local newY = y + yVelocity

  if newY > Level.Boarders.Bottom then
    Jumped.Once = false
    return Level.Boarders.Bottom
  else
    return newY
  end
end

local function moveX(x)
  local newX = x
  if userInput.isMoveRight() then
    newX = newX + characterConfig.Movement
  elseif userInput.isMoveLeft() then
    newX = newX - characterConfig.Movement
  end
  if newX < Level.Boarders.Left then
    return Level.Boarders.Left
  end

  if newX > Level.Boarders.Right then
    return Level.Boarders.Right
  end

  return newX
end

function Character:update(deltaTime)
  self.yVelocity = updateYVelocity(self.yVelocity, deltaTime)
  self.y = moveY(self.y, self.yVelocity)
  self.x = moveX(self.x)
end
