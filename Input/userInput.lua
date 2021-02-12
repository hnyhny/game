local keyboard = require "Input.keyboard"

local userInput = {}
local isDown = love.keyboard.isDown

function userInput.isJump()
    return isDown(keyboard.Bindings.Jump)
end
function userInput.isMoveRight()
    return isDown(keyboard.Bindings.Right)
end

function userInput.isMoveLeft()
    return isDown(keyboard.Bindings.Left)
end

function userInput.IsExit()
    return isDown(keyboard.Bindings.Exit)
end

return userInput
