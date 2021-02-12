local enviroment = require "Application.enviroment"
require "GameObjects.character"
require "GameObjects.background"
local push = require "Application.push"
local userInput = require "Input.userInput"

local background = Background()
local character = Character()

function love.update(dt) -- deltaTime
  character:update(dt)
end

function love.load()
  enviroment.initialize()
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  if userInput.IsExit() then
    love.event.quit()
  end
end

function love.draw()
  background:render()
  character:render()
end
