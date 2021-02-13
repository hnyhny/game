local settings = require "Config.settings"
local image =  {}
function image.newImage(image)
    local image = {image}
    function image:draw(Position)
        love.graphics.draw(self.image, self.Position.X, self.Position.Y)
    end
    return image
end
return image
