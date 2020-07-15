
Vector2 = require("Core.Classes.vector2")

local class = require(MIDDLECLASS)
Collider = class("Collider")

    function Collider:initialize(parentObj,transform)
        self.parent = parentObj
        self.transform = transform or parentObj.transform or error("Collider needs a transform.");
    end

	function Collider:checkMTV(other)
		local pos1 = self.transform.position
		local pos2 = other.position
		local size1 = self.transform.size
		local size2 = other.size

		local collided = ( (pos1.x < pos2.x + size2.x and pos1.x + size1.x > pos2.x) and (pos1.y < pos2.y + size2.y and pos1.y + size1.y > pos2.y) )
		local face = nil
		local mtv = Vector2()
		if collided then
			local edgeDiff = {
				{ pos1.x - (pos2.x + size2.x), 0, "left" },	-- left
				{ (pos1.x + size1.x) - pos2.x, 0, "right" },	-- right
				{ 0, pos1.y - (pos2.y + size2.y), "top" },	-- bottom
				{ 0, (pos1.y + size1.y) - pos2.y, "bottom" }	-- top
			}
			table.sort( edgeDiff, function(a,b) return math.sqrt(a[1]^2+a[2]^2) < math.sqrt(b[1]^2+b[2]^2); end )
			mtv = Vector2(edgeDiff[1][1],edgeDiff[1][2])
			mtv.x = -mtv.x
			mtv.y = -mtv.y
			face = edgeDiff[1][3]
		end

		return collided or false, mtv or Vector2(0,0), face or nil
    end
