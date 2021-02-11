local keyboard = require "keyboard"

local userInput = {}

function userInput.isJump()
    return love.keyboard.isDown(keyboard.Bindings.Jump)
end
function userInput.isMoveRight()
    return love.keyboard.isDown(keyboard.Bindings.Right)
end

function userInput.isMoveLeft()
    return love.keyboard.isDown(keyboard.Bindings.Left)
end

return userInput
