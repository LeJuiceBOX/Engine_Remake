Vector2 = require("Core.Classes.vector2")
ExMath = require("Core.Libraries.math")

local class = require(MIDDLECLASS)
Physics = class("Physics")

    function Physics:initialize(parent,transform)
        self.parent = parent
        self.transform = transform
        self.maxVelocity = Vector2(9999,9999)
        self.velocity = Vector2(10,100) -- x: horizontal vel
        self.gravity = 0
        self.surfaceDrag = 500
        self.airDrag = 4
        self.direction = 1
    end

    function Physics:update(dt)
        self.transform.position.x = self.transform.position.x + (self.velocity.x*self.direction) *dt
        print(self.velocity)
        if self.velocity.x > 0 then self.velocity.x = self.velocity.x - self.surfaceDrag *dt; else self.velocity.x = 0; end
        self.velocity.x = math.floor(self.velocity.x)
    end

    --===========================================================================================================================

