Class = require "Libraries.class"
local images = require "Resources.images"
local settings = require "Config.settings"
local userInput = require "Input.userInput"

local width,height = images.Character.Standing:getDimensions()

local levelSize = settings.Game.LevelSize
local characterConfig = settings.Game.Character

local  Borders = {
    Left = 0.5 * width,
    Right = levelSize.Width - 1.5 * width,
    Bottom = levelSize.Height - 1.5 * height
  }
  local  Start = {
    X = (levelSize.Width - width) / 2,
    Y = levelSize.Height
  }

local imageRun = love.graphics.newQuad(0,0,16,16,  images.Character.Running)

Character = Class {}
function Character:init()
  self.x = Start.X
  self.y = Start.Y
  self.yVelocity = 0
  self.xVelocity = 0
end

function Character:render()
  if self.xVelocity > 0 then
  love.graphics.draw(images.Character.Running, imageRun, self.x, self.y, 0)
  elseif self.xVelocity < 0 then
    love.graphics.draw(images.Character.Running, imageRun, self.x + width, self.y, 0, -1, 1)
  else
    love.graphics.draw(images.Character.Standing, self.x, self.y)  
  end
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

local function updateXVelocity()
if userInput.isMoveRight() then
  return  characterConfig.Movement
elseif userInput.isMoveLeft() then
  return - characterConfig.Movement
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

function Character:update(deltaTime)
  self.yVelocity = updateYVelocity(self.yVelocity, deltaTime)
  self.y = moveY(self.y, self.yVelocity)
  self.xVelocity = updateXVelocity()
  self.x = moveX(self.x, self.xVelocity)
end
