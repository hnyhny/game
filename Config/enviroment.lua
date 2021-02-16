local settings = require "Config.settings"
local enviroment = {}

local function setGraphicConfig()
    love.graphics.setDefaultFilter("nearest", "nearest")
end

local function initializeWindow()
    love.window.setTitle(settings.GameInfo.Name)
    love.window.setMode(settings.Screen.Window.Width, settings.Screen.Window.Height)
end

function enviroment.initialize()
    initializeWindow()
    setGraphicConfig()
end

return enviroment
