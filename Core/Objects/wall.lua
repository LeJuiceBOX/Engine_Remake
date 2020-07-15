
local class = require(MIDDLECLASS)
Wall = class("Wall")

    function Wall:initialize(pos,size)
        self.transform = Transform(self)
        self.renderer = BasicRenderer(self, self.transform)

        self.transform.position = pos;
        self.transform.size = size;
    end

    function Wall:draw()
        self.renderer:draw()
    end