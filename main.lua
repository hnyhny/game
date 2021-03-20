local enviroment = require "Config.enviroment"
require "GameObjects.character"
require "GameObjects.background"
require "GameObjects.platform"
require "GameObjects.lava"

local wf = require "Libraries.windfield"
local userInput = require "Input.userInput"
local settings = require "Config.settings"
local background = Background()
local character = Character()
local lavaImage = Lava()
local level = settings.Game.LevelSize
local levelData = require "Level.thefloorbecomeslavatestlevel"
local leveltilesCoordinates = levelData.layers.data

local function CreatePlatform(x, y, amount, collisionClass)
  collisionClass = collisionClass or "floor"
  local height = 4
  local width = 32 * amount
  local platformTop = world:newRectangleCollider(x + 1, y, width - 1, height)
  platformTop:setType("static")
  platformTop:setCollisionClass(collisionClass)

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

local function tablelength(T)
  local count = 0
  for _ in T do count = count + 1 end
  return count
end

local function loadPlattformsFromTable(levelTable)

  local maxIndex = tablelength(levelTable)
  local xCoordinate = level.Height
  local yCoordinate = 0
  for currentIndex = 0,maxIndex do
      if levelTable[currentIndex] == 2 then
        gamePlatforms[currentIndex] = CreatePlatform(xCoordinate,yCoordinate,1,"plat_ceiling")
      end
      if yCoordinate == level.Width then
        yCoordinate = 0
      else yCoordinate = yCoordinate + 1
      end
  end
  return gamePlatforms
end

local seed = os.time()
function love.load()
  if(false) then
  seed = tonumber(arg[0])
  end
  enviroment.initialize()
  world = wf.newWorld(0, 0, true)
  world:setGravity(0, 2000)

  playerBox = world:newRectangleCollider((level.Width - 50) / 2, level.Height - 16, 16, 16)
  playerBox:setRestitution(0.8)
  playerBox:setFixedRotation(true)
  wall_left = world:newRectangleCollider(0, 0, 8, level.Height)
  wall_right = world:newRectangleCollider(level.Width - 8, 0, 8, level.Height)
  ground = world:newRectangleCollider(0, level.Height - 8, level.Width, 8)
  lava = world:newRectangleCollider(0, level.Height + 100, level.Width, 8)

  world:addCollisionClass("plat_wall")
  world:addCollisionClass("floor")
  world:addCollisionClass("ground")
  world:addCollisionClass("plat_ceiling")
  world:addCollisionClass("win")

  world:addCollisionClass("wall")
  world:addCollisionClass("top")

  world:addCollisionClass("lava", {ignores = {"wall", "top", "plat_ceiling", "plat_wall", "floor"}})

  ground:setType("static")
  wall_left:setType("static")
  wall_right:setType("static")
  lava:setType("static")

  ground:setCollisionClass("ground")
  wall_left:setCollisionClass("wall")
  wall_right:setCollisionClass("wall")

  lava:setCollisionClass("lava")

  wall_left:setFriction(0)
  wall_right:setFriction(0)

  --[[gamePlatforms = {
    CreatePlatform(50, level.Height - 85, 2),
    CreatePlatform(20, level.Height - 165, 1),
    CreatePlatform(80, level.Height - 230, 2),
    CreatePlatform(180, level.Height - 300, 2),
    CreatePlatform(120, level.Height - 370, 2),
    CreatePlatform(0, level.Height - 450, 4),
    CreatePlatform(150, level.Height - 520, 1),
    CreatePlatform(0, level.Height - 590, 3),
    CreatePlatform(120, level.Height - 660, 2),
  }]]
  
  gamePlatforms = loadPlattformsFromTable(leveltilesCoordinates)
  playerBox:setLinearVelocity(0, 0)
end

local jumpedOnce = false
local isInAir = false
local won = false
local dead = false
local movement = 0
local worldspeed = 100

math.randomseed(seed)
local function CreatePlatformAt()
  local randomX = math.random(2, 17) * 10
  local randomElements = 2
  local lastElement = gamePlatforms[#gamePlatforms]
  local newMaxX = (randomX + (randomElements * 32))
  local oldMaxX = (lastElement.x + (32 * lastElement.amount))
  while  (math.abs(newMaxX - oldMaxX ) > 100)
  or (math.abs(randomX - lastElement.x ) > 100)
  or (lastElement.x >= randomX and oldMaxX <= newMaxX)  
  or (newMaxX > 200)
  do     
     randomX = math.random(2, 18) * 10
     randomElements = math.random(1,4)
     newMaxX = (randomX + randomElements * 32) 
     oldMaxX = (lastElement.x + 32 * lastElement.amount)
  end
  table.insert(gamePlatforms, CreatePlatform(randomX, lastElement.y - 70, randomElements))
  if #gamePlatforms % 10 == 0 then
    worldspeed = worldspeed + 5
  end
end

function love.update(dt)
  if jumpedOnce and not won and not dead then
    movement = -worldspeed * dt
    world:translateOrigin(0, movement)
    wall_left:setY(wall_left:getY() + movement)
    wall_right:setY(wall_right:getY() + movement)
    ground:setY(ground:getY() + movement)
    lava:setY(lava:getY() + 1.3 * movement)
  end

  if won or dead then
    playerBox:setLinearVelocity(0, 0)
    return
  end
  local x, y = playerBox:getLinearVelocity()

  local speed = 200
  if userInput.isMoveLeft() then
    playerBox:setLinearVelocity(-speed, y)
    character:update(dt, -speed, y)
  elseif userInput.isMoveRight() then
    playerBox:setLinearVelocity(speed, y)
    character:update(dt, speed, y)
  else
    playerBox:setLinearVelocity(0, y)
    character:update(dt, 0, y)
  end

  if userInput.isJump() and not isInAir then
    playerBox:applyLinearImpulse(0, -300)
    isInAir = true
  end

  if playerBox:enter("floor") then
    jumpedOnce = true
    local x, y = playerBox:getLinearVelocity()
    playerBox:setLinearVelocity(x, 0)
    isInAir = false
  end

  if playerBox:enter("win") then
    won = true
  end
  if playerBox:enter("ground") and not jumpedOnce then
    local x, y = playerBox:getLinearVelocity()
    playerBox:setLinearVelocity(x, 0)
    isInAir = false  end
  if playerBox:enter("ground") and jumpedOnce then
    dead = true
  end
  if (playerBox:getY() - gamePlatforms[#gamePlatforms].y <= 280) then
    CreatePlatformAt()
  end
  world:update(dt)
end

function love.draw()
  love.graphics.push()
  love.graphics.scale(settings.Game.LevelSize.Scale)
  character:render(playerBox:getPosition())

  for index, value in ipairs(gamePlatforms) do
    if not won and not dead then
      value.y = value.y - movement
    end
    value:render()
  end
  background:render()  
  if jumpedOnce then
    lavaImage:render(0, ground:getY() - 32)
  end
  love.graphics.print("Seed: ".. seed, 10, 10, 0, 1, 1)
  -- world:draw()
  if won then
    love.graphics.print(
      "YOU WON",
      settings.Game.LevelSize.Width / 2 - 100,
      settings.Game.LevelSize.Height / 2 - 50,
      0,
      3,
      3
    )
  end
  if dead then
    love.graphics.print(
      "GAME OVER:",
      settings.Game.LevelSize.Width / 2 - 20,
      settings.Game.LevelSize.Height / 2 - 30,
      0,
      1,
      1
    )
    for index, value in ipairs(gamePlatforms) do
        love.graphics.print(
          #gamePlatforms .. " Pts",
          settings.Game.LevelSize.Width / 2 - 20,
          settings.Game.LevelSize.Height / 2 + 10,
          0,
          1,
          1
        )
    end
  end
  love.graphics.pop()
end
