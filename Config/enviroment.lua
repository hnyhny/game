local push = require "Libraries.push"

local enviroment = {}

local function setGraphicConfig()
    love.graphics.setDefaultFilter("nearest", "nearest")
end

local function initializeWindow()
    love.window.setTitle("Cooles Game")
    push:setupScreenWithDefaults()
end

function enviroment.initialize()
    initializeWindow()
    setGraphicConfig()
end

return enviroment
