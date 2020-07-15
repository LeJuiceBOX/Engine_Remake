local UserInput = require("Core.Libraries.userinput")
local Vector2 = require("Core.Classes.vector2")
require("Core.Classes.color")
require("Core.Objects.workspace")
require("Core.Objects.debugPlayer")
require("Core.Objects.wall")

local class = require(MIDDLECLASS)

local scene = {}

    function scene.load()
        --// Services
        camera = Camera:new(0,0,love.graphics.getPixelWidth()*2,love.graphics.getPixelHeight())
        workspace = Workspace:new(camera)

        --// Objects
        player = workspace:NewInstance("player",DebugPlayer:new(Vector2(16,16)))
        workspace:NewInstance("wall",Wall:new(Vector2(100,100),Vector2(32,256)))
        workspace:NewInstance("wall",Wall:new(Vector2(200,100),Vector2(64,64)))

        workspace:print()
        print(workspace:ObjectHasComponent(player,"Transform"))
        player.renderer.color = Color:tableRGB(100,150,255)
    end

    function scene.update(dt)
        workspace:update(dt)
        workspace().player:HandleCollisions(workspace:GetObjectsWithComponent("Transform",player))
        --camera:setPosition(player.transform.position.x,player.transform.position.y)
    end
    
    function scene.draw(l,t,w,h)
        workspace:draw(l,t,w,h)
    end

return scene