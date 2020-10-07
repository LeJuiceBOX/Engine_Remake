local UserInput = require("Core.Libraries.userinput")
local Vector2 = require("Core.Classes.vector2")
require("Core.Classes.color")
require("Core.Objects.workspace")
require("Core.Objects.debugPlayer")
require("Core.Objects.tileMap")
require("Core.Objects.wall")

local class = require(MIDDLECLASS)

local scene = {}

    function scene.load(cam)
        --// Services
        workspace = Workspace:new(camera)
        tilemap = TileMap:new()
        --// Objects
        player = workspace:NewInstance("player",DebugPlayer:new(Vector2(love.graphics.getPixelWidth()/2,love.graphics.getPixelHeight()/2)))
        workspace:NewInstance("wall",Wall:new(Vector2(100,100),Vector2(32,256)))
        workspace:NewInstance("wall1",Wall:new(Vector2(100,356),Vector2(256,32)))


        camera = cam
        camera.focus = player
        camera.attached = true
        camera.debugMode = false

        player.renderer.color = Color:tableRGB(100,150,255)
    end

    function scene.update(dt)
        workspace:update(dt)
        workspace().player:HandleCollisions(workspace:GetObjectsWithComponent("Transform",player))
        camera:setPosition(player.transform.position+(player.transform.size/2))
    end

    function scene.draw()
        tilemap:draw()
        workspace:draw()
    end

return scene