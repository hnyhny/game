Class = require "class"
local images = require "images"

Background = Class {}

function Background:render()
    love.graphics.draw(images.background, 0, 0)
end
