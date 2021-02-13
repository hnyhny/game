local keys = require "Input.keys"
local game =  {
    Gravity = 100,
    Character = {
        Jump = 25,
        Movement = 15
    },
    LevelSize = {
        Height = 512,
        Width = 256,
        Scale = 2
    },
}

local settings = {
    GameInfo = {
        Name = "the floor becomes lava"
    },
    Game = game,
    Screen = {
        Window = {
            Height = game.LevelSize.Height * game.LevelSize.Scale,
            Width = game.LevelSize.Width * game.LevelSize.Scale
        },
        Virtual = {
            Height = game.LevelSize.Height * game.LevelSize.Scale,
            Width = game.LevelSize.Width * game.LevelSize.Scale
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
