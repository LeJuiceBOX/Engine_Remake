local UserInput = require("Core.Libraries.userinput")
local StalkerCamera = require("Core.Libraries.stalker-x")
local Vector2 = require("Core.Classes.vector2")
require("Core.Classes.color")
require("Core.Objects.workspace")
require("Core.Objects.wall")

require("Game.Objects.platformerPlayer")

local class = require(MIDDLECLASS)

local scene = {}

    function scene.load(cam)
        --// Services
        workspace = Workspace:new(camera)
        --// Objects
        player = workspace:NewInstance("player",PlatformerPlayer:new())
        workspace:NewInstance("wall",Wall:new(Vector2(0,600),Vector2(1280,32)))
        workspace:NewInstance("wall",Wall:new(Vector2(0,400),Vector2(256,32)))

        Camera = StalkerCamera()
        Camera:setFollowStyle("PLATFORMER")
        Camera:setFollowLerp(0.5)

        player.renderer.color = Color:tableRGB(100,150,255)
    end

    function scene.update(dt)
        workspace:update(dt)
        local pPos = player.transform:center()
        Camera:update(dt)
        Camera:follow(pPos.x,pPos.y)
        if UserInput.keyboard:key("f") then Camera:shake(8, 1, 60, 'XY') end
        workspace().player:HandleCollisions(workspace:GetObjectsWithComponent("Transform",player))
    end
    
    function scene.draw()
        Camera:attach()
        workspace:draw()
        Camera:detach()
        Camera:draw()
    end

return scene;