local push = require "Libraries.push"
local settings = require "settings"
local enviroment = {}

local function setGraphicConfig()
    love.graphics.setDefaultFilter("nearest", "nearest")
end

local function initializeWindow()
    love.window.setTitle(settings.GameInfo.Name)
    push:setupScreenWithDefaults()
end

function enviroment.initialize()
    initializeWindow()
    setGraphicConfig()
end

return enviroment
