Class = require "Libraries.class"
local images = require "Resources.images"

Platform = Class {}
function Platform:init(x, y, amount)
    self.x = x
    self.y = y
    self.amount = amount
end

function Platform:render()
    for index = 0,self.amount - 1 do
       love.graphics.draw(images.Platform, self.x + (index * 33), self.y)
    end
end