local path = "/images/"

local function newImage(name)
    return love.graphics.newImage(path .. name)
end

local images = {}

images.background = newImage("background.png")
images.character = newImage("char_stand.png")

return images
