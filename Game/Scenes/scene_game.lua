local UserInput = require("Core.Libraries.userinput")
local StalkerCamera = require("Core.Libraries.stalker-x")
local Vector2 = require("Core.Classes.vector2")
require("Core.Classes.color")
require("Core.Objects.workspace")
require("Core.Objects.debugPlayer")
require("Core.Objects.wall")

local class = require(MIDDLECLASS)

local scene = {}

    function scene.load(cam)
        --// Services
        workspace = Workspace:new(camera)
        --// Objects
        player = workspace:NewInstance("player",DebugPlayer:new(Vector2(love.graphics.getPixelWidth()/2,love.graphics.getPixelHeight()/2)))
        workspace:NewInstance("wall",Wall:new(Vector2(100,100),Vector2(32,256)))
        workspace:NewInstance("wall",Wall:new(Vector2(200,100),Vector2(1024,32)))

        Camera = StalkerCamera()
        Camera:setFollowLerp(0.2)
        Camera:setFollowStyle("TOPDOWN_TIGHT")

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