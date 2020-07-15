local gamera = require("Core.Libraries.gamera")
local Vector2 = require("Core.Classes.vector2")
require("Core.Classes.color")

local class = require(MIDDLECLASS)
Camera = class("Camera")

    function Camera:initialize(x,y,w,h)
        self.gamera = gamera.new(x,y,w,h)
        self.focus = nil
        self.attached = true
        self.moveBounds = Vector2(100,100)
        self.debugMode = false
    end

    local centerX = love.graphics.getPixelWidth()/2
    local centerY = love.graphics.getPixelHeight()/2
    function Camera:update(dt)
        if self.focus ~= nil and self.attached then self:setPosition(self.focus.transform.position) end
        self.gamera:toWorld(self.moveBounds.x,self.moveBounds.y)
        if self.focus and not self.attached then
            local pos = self.focus.transform.position
            if pos.x > centerX + self.moveBounds.x or 
            pos.x < centerX - self.moveBounds.x or
            pos.y > centerY + self.moveBounds.y or
            pos.y < centerY - self.moveBounds.y then
                self:setPosition(pos)
            end
        end
    end

    function Camera:debugDraw()
        if self.debugMode then
            Color:fromRGB(255,0,0)
            love.graphics.rectangle('line',centerX-self.moveBounds.x,centerY-self.moveBounds.y,self.moveBounds.x,self.moveBounds.y)
            Color:reset()
        end
    end

    function Camera:setWorld(pos,size) self.gamera:setWorld(pos.x,pos.y,size.x,size.y) end
    function Camera:setPosition(vec) self.gamera:setPosition(vec.x,vec.y) end
    function Camera:translate(amt) self:setPosition(Vector2(self.gamera:getPosition())+amt); end