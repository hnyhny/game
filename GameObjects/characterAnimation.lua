local animation = {}

function animation.newAnimation(image, width, duration)
    local animation = {}
    animation.spriteSheet = image
    animation.quads = {}
    animation.width = width
    animation.height = image:getHeight()
    local animations = image:getWidth() / width
    for x = 0, animations do
        animation.quads[x] = love.graphics.newQuad(x * width, 0, width, animation.height, image)
    end
    animation.duration = duration or 1
    animation.currentTime = 0

    function animation:draw(spriteNum, position, r, sx, sy, ox, oy)
        love.graphics.draw(self.spriteSheet, self.quads[spriteNum], position.X, position.Y, r, sx, sy, ox, oy)
    end
    return animation
end

return animation
