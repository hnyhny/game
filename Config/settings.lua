local keys = require "Input.keys"

local settings = {
    GameInfo = {
        Name = "the floor becomes lava"
    },
    Game = {
        Gravity = 100,
        Character = {
            Jump = 25,
            Movement = 15
        }
    },
    Screen = {
        Window = {
            Height = 512,
            Width = 256
        },
        Virtual = {
            Height = 512,
            Width = 256
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
