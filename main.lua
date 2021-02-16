local enviroment = require "Config.enviroment"
require "GameObjects.character"
require "GameObjects.background"
require "GameObjects.platform"

local wf = require "Libraries.windfield"
local userInput = require "Input.userInput"
local settings = require "Config.settings"
local background = Background()
local character = Character()
local level = settings.Game.LevelSize

local function CreatePlatform(x, y, amount)
  local height = 4
  local width = 32 * amount
  local platformTop = world:newRectangleCollider(x + 1, y, width - 1, height)
  platformTop:setType("static")
  platformTop:setCollisionClass("floor")

  local platformBottom = world:newRectangleCollider(x + 1, y + height, width - 1, height)
  platformBottom:setType("static")
  platformBottom:setCollisionClass("plat_ceiling")

  local platformLeft = world:newRectangleCollider(x, y, 1, 2 * height)
  platformLeft:setType("static")
  platformLeft:setCollisionClass("plat_wall")
  platformLeft:setFriction(0)
  
  local platformRight = world:newRectangleCollider(x + width, y, 1, 2 * height)
  platformRight:setType("static")
  platformRight:setCollisionClass("plat_wall")
  platformRight:setFriction(0)
  local platform = Platform()
  platform.x = x
  platform.y = y
  platform.amount = math.floor(width / 32)

  return platform
end
local gamePlatforms = {}
function love.load()
  enviroment.initialize()
  world = wf.newWorld(0, 0, true)
  world:setGravity(0, 2000)

  box = world:newRectangleCollider((level.Width - 50) / 2, level.Height - 16, 16, 16)
  box:setRestitution(0.8)
  box:setFixedRotation(true)
  top = world:newRectangleCollider(0, 0, level.Width, 8)
  ground = world:newRectangleCollider(0, level.Height - 8, level.Width, 8)
  wall_left = world:newRectangleCollider(0, 0, 8, level.Height)
  wall_right = world:newRectangleCollider(level.Width - 8, 0, 8, level.Height)

  world:addCollisionClass("plat_wall")
  world:addCollisionClass("floor")
  world:addCollisionClass("plat_ceiling")

  world:addCollisionClass("wall")

  world:addCollisionClass("top")

  ground:setType("static")
  wall_left:setType("static")
  wall_right:setType("static")
  top:setType("static")

  ground:setCollisionClass("floor")
  wall_left:setCollisionClass("wall")
  wall_right:setCollisionClass("wall")
  top:setCollisionClass("top")

  wall_left:setFriction(0)
  wall_right:setFriction(0)

  gamePlatforms = {
    CreatePlatform(level.Width - 130, level.Height - 85, 1),
    CreatePlatform(20, level.Height - 165, 1),
    CreatePlatform(80, level.Height - 240, 2),
    CreatePlatform(180, level.Height - 320, 2),
    CreatePlatform(180, level.Height - 400, 2),
    CreatePlatform(0, level.Height - 480, 4)
  }
end

local isInAir = false
local won = false;
function love.update(dt)
  if won then
    box:setLinearVelocity(0,0)
    return
  end
  local x, y = box:getLinearVelocity()

  local speed = 200
  if userInput.isMoveLeft() then
    box:setLinearVelocity(-speed, y)
    character:update(dt, -speed, y)
  elseif userInput.isMoveRight() then
    box:setLinearVelocity(speed, y)
    character:update(dt, speed, y)
  else
    box:setLinearVelocity(0, y)
    character:update(dt, 0, y)
  end

  if userInput.isJump() and not isInAir then
    box:applyLinearImpulse(0, -300)
    isInAir = true
  end

  if box:enter("floor") then
    local x, y = box:getLinearVelocity()
    box:setLinearVelocity(x, 0)
    isInAir = false
  end

  if box:enter("top") then
    won = true
  end
 
  world:update(dt)
end
function love.draw()
  love.graphics.push()
  love.graphics.scale(settings.Game.LevelSize.Scale)
  background:render()
  character:render(box:getPosition())
  -- world:draw()
  if won then
    love.graphics.print( "YOU WON", settings.Game.LevelSize.Width / 2 - 100, settings.Game.LevelSize.Height / 2 - 30, 0, 3, 3)
  end
  for index, value in ipairs(gamePlatforms) do
    value:render()
  end
  love.graphics.pop()
end
