Class = require "Libraries.class"
local images = require "Resources.images"
local settings = require "Config.settings"
local userInput = require "Input.userInput"

local modelWidth = images.character:getWidth()
local modelHeight = images.character:getHeight()

local levelSize = settings.Game.LevelSize
local characterConfig = settings.Game.Character

local  Borders = {
    Left = 0.5 * modelWidth,
    Right = levelSize.Width - 1.5 * modelWidth,
    Bottom = levelSize.Height - 1.5 * modelHeight
  }
  local  Start = {
    X = (levelSize.Width - modelWidth) / 2,
    Y = levelSize.Height
  }


Character = Class {}
function Character:init()
  self.x = Start.X
  self.y = Start.Y
  self.yVelocity = 0
  self.xVelocity = 0
  self.inAir = false;
end

function Character:render()
  love.graphics.draw(images.character, self.x, self.y)
end

local jumpedOnce = false

local function updateYVelocity(yVelocity, deltaTime)
  if userInput.isJump() and not jumpedOnce then
    jumpedOnce = true
    return -characterConfig.Jump
  else
    return yVelocity + settings.Game.Gravity * deltaTime
  end
end

 local function moveY(y, yVelocity)
  local newY = y + yVelocity

  if newY  > Borders.Bottom then
    jumpedOnce = false
    return Borders.Bottom
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

  if newX < Borders.Left then
    return Borders.Left
  end

  if newX > Borders.Right then
    return Borders.Right
  end

  return newX
end

function Character:update(deltaTime)
  self.yVelocity = updateYVelocity(self.yVelocity, deltaTime)
  self.y = moveY(self.y, self.yVelocity)
  self.x = moveX(self.x)
end
