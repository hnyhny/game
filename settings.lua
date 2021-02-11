local settings = {}

local function SetGraphicConfig()
    love.graphics.setDefaultFilter('nearest','nearest')
end

local function initializeWindow()
    love.window.setTitle('Cooles Game')
    push:setupScreenWithDefaults()
end

function settings.initialize()
    initializeWindow()
    SetGraphicConfig()
end

return settings