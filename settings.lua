local keys = require "Input.keys"

local settings = {
    Game = {
        Gravity = 100,
        Character = {
            Jump = 25,
            Movement = 15
        }
    },
    Screen = {
        Window = {
            Height = 900,
            Width = 500
        },
        Virtual = {
            Height = 800,
            Width = 400
        },
        Settings = {
            vsync = true,
            fullscreen = false,
            resizable = true
        }
    },
    Bindings = {
        Jump = keys.SPACE,
        Left = keys.LEFT,
        Right = keys.RIGHT,
        Exit = keys.ESCAPE
    }
}

return settings
