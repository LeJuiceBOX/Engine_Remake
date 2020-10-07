local UserInput = require("Core.Libraries.userinput")
local Vector2 = require("Core.Classes.vector2")
require("Core.Classes.color")
require("Core.Objects.workspace")
require("Core.Objects.debugPlayer")
require("Core.Objects.wall")

local class = require(MIDDLECLASS)

local createEnabled = false

local startPos = nil
local endPos = nil

local scene = {}

    function scene.load(cam)
        --// Services
        workspace = Workspace:new(camera)

        --// Objects
        player = workspace:NewInstance("player",DebugPlayer:new(Vector2(love.graphics.getPixelWidth()/2,love.graphics.getPixelHeight()/2)))

        editorCamera = cam
        editorCamera.focus = player
        editorCamera.attached = true
        editorCamera.debugMode = false
        editorCamera.moveBounds = Vector2(1,1)

        player.renderer.color = Color:tableRGB(255,255,255,255)
        player.speed = 750;
    end

    function scene.update(dt)
        workspace:update(dt)
        workspace().player:HandleCollisions(workspace:GetObjectsWithComponent("Transform",player))
        editorCamera:setPosition(player.transform.position)
        if UserInput.keyboard:keyPressed('c') then createEnabled = not createEnabled; end
        if UserInput.mouse:mouseButtonPressed(1) then startPos = UserInput.mouse:position() end
        if UserInput.mouse:mouseButtonReleased(1) then endPos = UserInput.mouse:position() startPos = nil end
    end
    
    function scene.draw()
        love.graphics.print("[C] Create: "..tostring(createEnabled))
        workspace:draw()
    end

return scene;