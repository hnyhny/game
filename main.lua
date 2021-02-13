local enviroment = require "Config.enviroment"
require "GameObjects.character"
require "GameObjects.background"
local push = require "Libraries.push"
local userInput = require "Input.userInput"
local settings = require "Config.settings"
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
  if userInput.isExit() then
    love.event.quit()
  end
end

function love.draw()
  love.graphics.push()
  love.graphics.scale(settings.Game.LevelSize.Scale)
  background:render()
  character:render()
love.graphics.pop()
end
