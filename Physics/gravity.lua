local settings = require "Config.settings"
local gravity = {}

function gravity.apply(yVelocity, deltaTime)
      return yVelocity + settings.Game.Gravity * deltaTime
end

return gravity