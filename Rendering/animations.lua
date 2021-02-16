local animations = {}

function animations.newAnimation(image, width, duration)
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


    function animation:UpdateCurrentTime(dt)
        self.currentTime = self.currentTime + dt
        if self.currentTime >= self.duration then
          self.currentTime = self.currentTime - self.duration
      end
    end

    function animation:draw(x, y, r, sx, sy, ox, oy)
       local spriteNum = math.floor(self.currentTime / self.duration * #self.quads)
        love.graphics.draw(self.spriteSheet, self.quads[spriteNum], x, y, r, sx, sy, ox, oy)
    end
    return animation
end

return animations
