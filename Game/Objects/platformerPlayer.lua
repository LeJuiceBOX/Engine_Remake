local UserInput = require("Core.Libraries.userinput")
local Vector2 = require("Core.Classes.vector2")
require("Core.Components.transform")
require("Core.Components.collider")
require("Core.Components.basicRenderer")
require("Core.Components.physics")


local class = require(MIDDLECLASS)
PlatformerPlayer = class("PlatformerPlayer")

    function PlatformerPlayer:initialize()
        self.transform =    Transform(self)
        self.renderer =     BasicRenderer(self,self.transform)
        self.collider =     Collider(self,self.transform)
        self.physics =      Physics(self,self.transform)

        self.acceleration = 1000
        self.jumpPower = 50
    end

    function PlatformerPlayer:update(dt)
        -- handle direction
        if UserInput.keyboard:key('a') then 
            self.physics.direction = -1; 
            self.physics.velocity.x = self.physics.velocity.x + self.acceleration *dt; 
        elseif UserInput.keyboard:key('d') then 
            self.physics.direction = 1;
            self.physics.velocity.x = self.physics.velocity.x + self.acceleration *dt; 
        end

        if UserInput.keyboard:key('w') then 
            self.physics.velocity.Y = self.jumpPower
        end  --// Move UP
        

        if UserInput.keyboard:key('s') then 
            self.transform.position = self.transform.position + Vector2(0,self.speed)  *dt 
        end  --// Move DOWN

        self.physics:update(dt)
    end

    function PlatformerPlayer:draw()
        self.renderer:draw()
    end