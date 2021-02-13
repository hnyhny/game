local keys = require "Input.keys"

local gameInfo = {
    Name = "the floor becomes lava"
}

local game = {
    Gravity = 70,
    Character = {
        Jump = 10,
        Movement = 2
    },
    LevelSize = {
        Height = 512,
        Width = 256,
        Scale = 2
    },
    AnimationSpeed = 15
}

local screen = {
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
}

local bindings = {
    Jump = keys.SPACE,
    Left = keys.LEFT,
    Right = keys.RIGHT,
    Exit = keys.ESCAPE
}

local settings = {
    GameInfo = gameInfo,
    Game = game,
    Screen = screen,
    Bindings = bindings
}

return settings
