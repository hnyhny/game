push = require 'push'

Class = require 'class'

require 'Character'

local background = love.graphics.newImage('background.png')

WINDOW_HEIGHT = 900
WINDOW_WIDTH = 500

VIRTUAL_HEIGHT = 800
VIRTUAL_WIDTH = 400

local character = Character()

function love.load()
  love.graphics.setDefaultFilter('nearest','nearest')

  love.window.setTitle('Cooles Game')

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })

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

function love.update(dt) -- deltaTime
  character:update(dt)
end

function love.draw()
  --push:start()
  --love.graphics.scale(1, 1)
  love.graphics.draw(background, 0, 0)
  character:render()
  love.keyboard.keysPressed = {}
  --push:finish()
end
