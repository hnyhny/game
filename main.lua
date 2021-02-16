local enviroment = require "Config.enviroment"
require "GameObjects.character"
require "GameObjects.background"
require "GameObjects.platform"
local push = require "Libraries.push"
local userInput = require "Input.userInput"
local settings = require "Config.settings"
local background = Background()
local character = Character()

-- Code um eine Testplattform anzulegen
local levelSize = settings.Game.LevelSize
local platform = Platform(levelSize.Width-120,levelSize.Height-20,2)

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
  platform:render()
  character:render()
love.graphics.pop()
end
