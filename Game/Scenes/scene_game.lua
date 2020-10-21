local UserInput = require("Core.Libraries.userinput")
local StalkerCamera = require("Core.Libraries.stalker-x")
local Vector2 = require("Core.Classes.vector2")
require("Core.Classes.color")
require("Core.Objects.workspace")
<<<<<<< HEAD
require("Core.Objects.debugPlayer")
require("Core.Objects.tileMap")
=======
>>>>>>> 1caacf5f00029b63ca2bf95b61e4f9853ed863a1
require("Core.Objects.wall")

require("Game.Objects.platformerPlayer")

local class = require(MIDDLECLASS)

local scene = {}

    function scene.load(cam)
        --// Services
        workspace = Workspace:new(camera)
        tilemap = TileMap:new()
        --// Objects
<<<<<<< HEAD
        player = workspace:NewInstance("player",DebugPlayer:new(Vector2(love.graphics.getPixelWidth()/2,love.graphics.getPixelHeight()/2)))
        workspace:NewInstance("wall",Wall:new(Vector2(100,100),Vector2(32,256)))
        workspace:NewInstance("wall1",Wall:new(Vector2(100,356),Vector2(256,32)))

=======
        player = workspace:NewInstance("player",PlatformerPlayer:new())
        workspace:NewInstance("wall",Wall:new(Vector2(0,600),Vector2(1280,32)))
        workspace:NewInstance("wall",Wall:new(Vector2(0,400),Vector2(256,32)))

        Camera = StalkerCamera()
        Camera:setFollowStyle("PLATFORMER")
        Camera:setFollowLerp(0.5)
>>>>>>> 1caacf5f00029b63ca2bf95b61e4f9853ed863a1

        player.renderer.color = Color:tableRGB(100,150,255)
    end

    function scene.update(dt)
        workspace:update(dt)
<<<<<<< HEAD
        workspace().player:HandleCollisions(workspace:GetObjectsWithComponent("Transform",player))
        camera:setPosition(player.transform.position+(player.transform.size/2))
=======
        local pPos = player.transform:center()
        Camera:update(dt)
        Camera:follow(pPos.x,pPos.y)
        if UserInput.keyboard:key("f") then Camera:shake(8, 1, 60, 'XY') end
        --workspace().player:HandleCollisions(workspace:GetObjectsWithComponent("Transform",player))
>>>>>>> 1caacf5f00029b63ca2bf95b61e4f9853ed863a1
    end

    function scene.draw()
<<<<<<< HEAD
        tilemap:draw()
=======
        Camera:attach()
>>>>>>> 1caacf5f00029b63ca2bf95b61e4f9853ed863a1
        workspace:draw()
        Camera:detach()
        Camera:draw()
    end

return scene;