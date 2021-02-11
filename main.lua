local enviroment = require "enviroment"

require "character"
require "background"

local background = Background()
local character = Character()

function love.update(dt) -- deltaTime
  character:update(dt)
  love.keyboard.keysPressed = {}
end

function love.load()
  enviroment.initialize()
  love.keyboard.keysPressed = {}
end

function love.resize(w, h)
  enviroment.window.resizeTo(w, h)
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true

  if key == "escape" then
    love.event.quit()
  end
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end

function love.draw()
  background:render()
  character:render()
end
