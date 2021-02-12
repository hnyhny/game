Class = require "Libraries.class"
local images = require "Resources.images"
local settings = require "Config.settings"
local userInput = require "Input.userInput"

local modelWidth = images.character:getWidth()
local modelHeight = images.character:getHeight()

local level = settings.Screen.Virtual
local characterConfig = settings.Game.Character

local Level = {
  Borders = {
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

  if newY > Level.Borders.Bottom then
    jumpedOnce = false
    return Level.Borders.Bottom
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

  if newX < Level.Borders.Left then
    return Level.Borders.Left
  end

  if newX > Level.Borders.Right then
    return Level.Borders.Right
  end

  return newX
end

function Character:update(deltaTime)
  self.yVelocity = updateYVelocity(self.yVelocity, deltaTime)
  self.y = moveY(self.y, self.yVelocity)
  self.x = moveX(self.x)
end
