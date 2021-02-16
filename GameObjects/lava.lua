Class = require "Libraries.class"
local images = require "Resources.images"

Lava = Class {}
function Lava:init()    
end

function Lava:render(x, y)
    love.graphics.draw(images.Lava, x, y, 0, 1, 1)
end