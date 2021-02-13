Class = require "Libraries.class"
local images = require "Resources.images"
local settings = require "Config.settings"
local userInput = require "Input.userInput"

local width, height = images.Character.Standing:getDimensions()
local levelSize = settings.Game.LevelSize

local Borders = {
  Left = 0.5 * width,
  Right = levelSize.Width - 1.5 * width,
  Bottom = levelSize.Height - 1.5 * height
}
local Start = {
  X = (levelSize.Width - width) / 2,
  Y = levelSize.Height
}

Character = Class {}
function Character:init()
  self.x = Start.X
  self.y = Start.Y
  self.yVelocity = 0
  self.xVelocity = 0
end

local imageRun = love.graphics.newQuad(0, 0, width, height, images.Character.Running)
function Character:render()
  if self.xVelocity > 0 then
    love.graphics.draw(images.Character.Running, imageRun, self.x, self.y, 0)
  elseif self.xVelocity < 0 then
    love.graphics.draw(images.Character.Running, imageRun, self.x + width, self.y, 0, -1, 1)
  else
    love.graphics.draw(images.Character.Standing, self.x, self.y, 0)
  end
end

local jumpedOnce = false
local characterConfig = settings.Game.Character
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
local function SetAnimation(animationIndex)
  imageRun = love.graphics.newQuad(animationIndex * width, 0, width, width, images.Character.Running)
end

local counter = 0
local runningAnimationsCount = images.Character.Running:getWidth() / width

local function UpdateAnimation()
  local factor = settings.Game.AnimationSpeed
  local animation = math.floor(counter / factor)
  if animation >= runningAnimationsCount then
    animation = 0
    counter = 0
  end
  SetAnimation(animation)
  counter = counter + 1
end

function Character:update(deltaTime)
  self.yVelocity = updateYVelocity(self.yVelocity, deltaTime)
  self.y = moveY(self.y, self.yVelocity)
  self.xVelocity = updateXVelocity()
  self.x = moveX(self.x, self.xVelocity)
  UpdateAnimation()
end
