push = require 'push'
Class = require 'class'
require 'Character'

local images = require 'images'
local settings = require 'settings'
local background = images.background
local character = Character()

function love.update(dt) -- deltaTime
  character:update(dt)
end

function love.load()
  settings.initialize()
  love.keyboard.keysPressed = {}
end

function love.resize(w,h)
  push:resize(w,h)
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true

  if key == 'escape' then
    love.event.quit()
  end
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end

function love.draw()
  love.graphics.draw(background, 0, 0)
  character:render()
  love.keyboard.keysPressed = {}
  --push:finish()
end

