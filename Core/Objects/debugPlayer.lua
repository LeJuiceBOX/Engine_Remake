local UserInput = require("Core.Libraries.userinput")
local Vector2 = require("Core.Classes.vector2")
require("Core.Components.transform")
require("Core.Components.collider")
require("Core.Components.basicRenderer")


local class = require(MIDDLECLASS)
DebugPlayer = class("DebugPlayer")

    function DebugPlayer:initialize(pos)
        self.transform =    Transform(self,pos)
        self.renderer =     BasicRenderer(self,self.transform)
        self.collider =     Collider(self,self.transform)

        self.speed = 500
    end

    function DebugPlayer:update(dt)
        if UserInput.keyboard:key('w') then self.transform.position = self.transform.position + Vector2(0,-self.speed) *dt end  --// Move UP
        if UserInput.keyboard:key('a') then self.transform.position = self.transform.position + Vector2(-self.speed,0) *dt end  --// Move LEFT
        if UserInput.keyboard:key('s') then self.transform.position = self.transform.position + Vector2(0,self.speed)  *dt end  --// Move DOWN
        if UserInput.keyboard:key('d') then self.transform.position = self.transform.position + Vector2(self.speed,0)  *dt end  --// Move RIGHT
    end

    function DebugPlayer:draw()
        self.renderer:draw()
    end

    function DebugPlayer:HandleCollisions(objects)
        local collisions = {}
        for i,v in pairs(objects) do
            if v.transform ~= nil and v.transform ~= self.transform then
                local collided, mtv, face = self.collider:checkMTV(v.transform)
                if collided then collisions[#collisions+1] = {mtv,face}; end
            end
        end

        if #collisions < 1 then return; end

        for i,v in pairs(collisions) do
            local mtv = v[1]
            self.transform.position = self.transform.position + mtv
        end      
    end