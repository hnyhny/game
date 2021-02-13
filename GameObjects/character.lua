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
  Left = 0.5 * width,
  Right = levelSize.Width - 1.5 * width,
  Bottom = levelSize.Height - 1.5 * width
}
local Start = {
  X = (levelSize.Width - width) / 2,
  Y = levelSize.Height
}

Character = Class {}
function Character:init()
  self.Position = {
    X = Start.X,
    Y = Start.Y
  }
  self.Velocity = {
    X = 0,
    Y = 0
  }
end

function Character:render()

  local isRunningRight = self.Velocity.X > 0
  local isRunningLeft = self.Velocity.X < 0

  if isRunningRight then
    texture.Running:draw(self.Position)
  elseif isRunningLeft then
    texture.Running:draw(self.Position, 0, -1, 1, texture.Running.width)
  else
    love.graphics.draw(images.Character.Standing, self.Position.X, self.Position.Y, 0)
  end
end

local jumpedOnce = false
local characterConfig = settings.Game.Character
local function updateYVelocityFromInput(yVelocity)
  if userInput.isJump() and not jumpedOnce then
    jumpedOnce = true
    return -characterConfig.Jump
  end
  return yVelocity
end

local function moveY(y, yVelocity)
  local newY = y + yVelocity

  if newY > Borders.Bottom then
    jumpedOnce = false
    return Borders.Bottom
  else
    return newY
  end
end

local function updateXVelocity()
  if userInput.isMoveRight() then
    return characterConfig.Movement
  elseif userInput.isMoveLeft() then
    return -characterConfig.Movement
  end
  return 0
end

local function moveX(x, xVelocity)
  local newX = x + xVelocity
  if newX < Borders.Left then
    return Borders.Left
  end

  if newX > Borders.Right then
    return Borders.Right
  end

  return newX
end

function Character:update(dt)
  self.Velocity.Y = gravity.apply(self.Velocity.Y, dt)
  self.Velocity.Y = updateYVelocityFromInput(self.Velocity.Y)
  self.Position.Y = moveY(self.Position.Y, self.Velocity.Y)

  self.Velocity.X = updateXVelocity()
  self.Position.X = moveX(self.Position.X, self.Velocity.X)
  texture.Running:UpdateCurrentTime(dt)
end
