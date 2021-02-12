local settings = require "Config.settings"

local userInput = {}
local isDown = love.keyboard.isDown

function userInput.isJump()
    return isDown(settings.Bindings.Jump)
end
function userInput.isMoveRight()
    return isDown(settings.Bindings.Right)
end

function userInput.isMoveLeft()
    return isDown(settings.Bindings.Left)
end

function userInput.IsExit()
    return isDown(settings.Bindings.Exit)
end

return userInput
