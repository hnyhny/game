Class = require "Libraries.class"
local images = require "Resources.images"

Platform = Class {}
function Platform:init(x, y, amount)
    self.x = x
    self.y = y
    self.amount = amount
end

function Platform:render()
    if self.amount > 0 then
        local i = 1
        while i <= self.amount do
           love.graphics.draw(images.Platform, self.x+(i*33), self.y)
            i = i+1
        end
    else
        love.graphics.draw(images.Platform, self.x, self.y)
    end
end