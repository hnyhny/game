local path = "resources/images/"

local function newImageFrom(name)
    return love.graphics.newImage(path .. name)
end

local images = {}

images.background = newImageFrom("background.png")
images.character = newImageFrom("char_stand.png")

return images
