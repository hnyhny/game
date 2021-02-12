Class = require "Application.class"
local images = require "Resources.images"
local settings = require "settings"
local userInput = require "Input.userInput"

local modelWidth = images.character:getWidth()
local modelHeight = images.character:getHeight()

local level = settings.Screen.Virtual
local gameConfig = settings.Game
local Level = {
  Boarders = {
  Left = 0.5 * modelWidth,
  Right = level.Width - 1.5 * modelWidth,
  Bottom = level.Height - 1.5 * modelHeight
  },
  Start = {
    X = (level.Width -modelWidth) / 2,
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


local function updateYVelocity(yVelocity, deltaTime)
  if userInput.isJump() then
    return -gameConfig.Character.Jump
  else
    return yVelocity + gameConfig.Gravity * deltaTime
  end
end

local function moveY(y, yVelocity)
  local newY = y + yVelocity
  
  if newY > Level.Boarders.Bottom then
    return Level.Boarders.Bottom
  else
    return newY
  end
end


local function moveX(x)
  local newX = x
  if userInput.isMoveRight() then
    newX = newX + gameConfig.Character.Movement
  elseif userInput.isMoveLeft() then
    newX = newX - gameConfig.Character.Movement
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
