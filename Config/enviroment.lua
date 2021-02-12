local push = require "Libraries.push"

local enviroment = {}

local function SetGraphicConfig()
    love.graphics.setDefaultFilter("nearest", "nearest")
end

local function initializeWindow()
    love.window.setTitle("Cooles Game")
    push:setupScreenWithDefaults()
end

function enviroment.initialize()
    initializeWindow()
    SetGraphicConfig()
end
return enviroment
