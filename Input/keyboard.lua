local Keys = {
    SPACE = "space",
    LEFT = "left",
    RIGHT = "right",
    ESCAPE = "escape"
}
local Bindings = {
    Jump = Keys.SPACE,
    Left = Keys.LEFT,
    Right = Keys.RIGHT,
    Exit = Keys.ESCAPE
}

local keyboard = {Keys = Keys, Bindings = Bindings}
return keyboard
