local gamera = require("Core.Libraries.gamera")

local class = require(MIDDLECLASS)
Camera = class("Camera")

    function Camera:initialize()
        self.gamera = gamera.new(love.graphics.getPixelWidth(),love.graphics.getPixelHeight(), love.graphics.getPixelWidth()*2,love.graphics.getPixelHeight()*2)    
    end

    --//draw calling
    function Camera:draw(calls)
        self.gamera.draw(function(l,t,w,h)
            for i,v in pairs(calls) do if v.draw ~= nil then v:draw(l,t,w,h); end end
        end)
    end