local path = "/images/"

local function newImage(name)
    return love.graphics.newImage(path .. name)
end

local images = {
    Background = newImage("background.png"),
    Platform = newImage("platform01.png"),
    Character = {
        Running = newImage("char_run.png"),
        Standing = newImage("char_stand.png")
    }
}

return images
