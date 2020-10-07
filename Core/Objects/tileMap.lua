require("Core.Components.transform")

local class = require(MIDDLECLASS)
TileMap = class("TileMap")

    function TileMap:initialize(pos)
        self.transform = Transform(self,pos or Vector2(0,0))

        self.colliderMap = {1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0};

        self.tileMap = {
            map = {1,1,1,1,0,1,1,1,1,1,2,2,2,2,2,0,2,2,2,2,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4};
            colliders = {};
            size = Vector2(10,10);
        }

        self.tileSet = {
            path = "Game/Assets/Graphics/tiles.png";
            image = nil;
            size = 128;
            tiles = {};
        }

        self:makeTileset(self.tileSet.image,4,Vector2(128,128))
    end

    function TileMap:initColliders(workspace)
        
    end

    function TileMap:makeColliders(map)
        for i,v in pairs(map) do
            if v.Solid then 
                local tilePos = v.Position
                local tileSize = self.tileSet.size
                local absPos = self.transform.position*Vector2(tileSize,tileSize)
                print(absPos)
                self.colliders[#self.colliders+1] = makeCollider(absPos.x,absPos.y,tileSize.x,tileSize.y)
            end
        end
    end

    function TileMap:makeTileset(image,expectedTiles,size) -- Turns tile set image into individual quads
        self.tileSet.image = love.graphics.newImage(self.tileSet.path)
        local x,y = 0,0
        for i = 1, expectedTiles do
            local dist = size.x*x -- 0,0 -> cur tile
            local width = self.tileSet.image:getWidth()
            if dist >= width then y=y+1; x=0; end
            self.tileSet.tiles[i] = love.graphics.newQuad(size.x*x, size.y*y, size.x, size.y, self.tileSet.image)
            x=x+1
        end
    end

    function TileMap:draw()
        if #self.tileSet.tiles < 1 then print("Setup tiles."); return; end
        local x,y = 0,0
        for i,v in pairs(self.tileMap.map) do
            if y > self.tileMap.size.y then return; end
            if v ~= 0 then love.graphics.draw(self.tileSet.image,self.tileSet.tiles[v],x*self.tileSet.size,y*self.tileSet.size); end
            x=x+1;
            if x >= self.tileMap.size.x then x=0; y=y+1; end
        end
    end