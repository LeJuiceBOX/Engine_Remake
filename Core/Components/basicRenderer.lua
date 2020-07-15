local Vector2 = require("Core.Classes.vector2")
require("Core.Classes.color")
require("Core.Components.transform")

local class = require(MIDDLECLASS)
BasicRenderer = class("BasicRenderer")

    function BasicRenderer:initialize(parentObj,transform)
        if not parentObj then error("BasicRenderer needs a transform."); return; end
        self.parent =   parentObj
        self.transform = transform or parentObj.transform;
        self.color = Color:tableRGB(255,255,255)
    end

    function BasicRenderer:draw()
        Color:fromRGB(self.color.r or 255,self.color.g or 255,self.color.b or 255,self.color.v or 1)
        love.graphics.rectangle('fill',self.transform.position.x,self.transform.position.y,self.transform.size.x,self.transform.size.y)
        Color:reset()
    end