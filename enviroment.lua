local push = require "push"

local settings = {}

local function SetGraphicConfig()
    love.graphics.setDefaultFilter("nearest", "nearest")
end

local function initializeWindow()
    love.window.setTitle("Cooles Game")
    push:setupScreenWithDefaults()
end

function settings.initialize()
    initializeWindow()
    SetGraphicConfig()
end
settings.window = {}

function settings.window:resizeTo(width, height)
    push:resize(width, height)
end

return settings
