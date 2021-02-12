Class = require "Libraries.class"
local images = require "Resources.images"

Background = Class {}

function Background:render()
    love.graphics.draw(images.background, 0, 0)
end
