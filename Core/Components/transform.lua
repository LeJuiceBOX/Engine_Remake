local Vector2 = require("Core.Classes.vector2")

local class = require(MIDDLECLASS)
Transform = class("Transform")

    function Transform:initialize(parentObj,pos,size,rot)
        self.parent =   parentObj
        self.position = pos or Vector2(0,0) 
        self.size =     size or Vector2(32,32)
        self.rotation = rot or 0
    end 