require("Core.Objects.camera")

local class = require(MIDDLECLASS)
Workspace = class("Workspace")

    function Workspace:initialize(camera)
        self.world = {}
        self.currentCamera = camera
        self.debugMode = true
    end

    function Workspace:__call()
        return self.world;
    end

    function Workspace:NewInstance(tag,object)
        if not tag then error("Workspace:NewInstance requires a tag.") return; end 
        if not object then error("Workspace:NewInstance requires an object.") return; end 

        local duplicates = 1
        -- Get all duplicate tags
        for w_tag,w_object in pairs(self.world) do if w_tag == tag then duplicates = duplicates + 1; end end
        -- If found, add a number to make it unique
        if duplicates > 1 then tag = tag..tostring(duplicates) end

        self.world[tag] = object
        self:dPrint("Created a new "..tostring(object)..".")
        return self.world[tag];
    end

    function Workspace:Destroy(tag)
        local obj = self.world[tag]
        if not obj then error("The tag '"..tag.."' doesnt exist."); end
        self:dPrint("Destroyed an "..tostring(obj)..".")
        self.world[tag] = nil
    end

    function Workspace:print()
        print("\n[ Workspace ]")
        for i,v in pairs(self.world) do print("|- "..i.. " \t("..tostring(v)..")"); end
        print("\n")
    end

    function Workspace:ObjectHasComponent(object,component)
        for var,val in pairs(object) do
            if tostring(val) == "Class "..component then return true; end
        end
        return false;
    end

    function Workspace:GetObjectsWithComponent(component,exclude)
        local objs = {}
        for tag,object in pairs(self.world) do
            if object ~= exclude then
                if self:ObjectHasComponent(object,component) then objs[tag] = object; end
            end
        end
        return objs
    end

    function Workspace:GetObjectsOfClass(class)
        local objs = {}
        for tag,object in pairs(self.world) do
            if tostrinh(object) == "Class "..class then objs[tag] = object; end
        end
        return objs;
    end

    function Workspace:getTags(tagString,useStringFind)
        local objs = {}
        for tag,obj in pairs(self.world) do
            if useStringFind then
                if string.find(tag,tagString) then objs[tag] = obj; end
            else
                if tag == tagString then objs[tag] = obj; end
            end
        end
        return objs
    end

    function Workspace:draw()
        for tag,obj in pairs(self.world) do
            if obj.draw ~= nil then obj:draw(); end
        end
     end

    function Workspace:update(dt)
        for tag,obj in pairs(self.world) do
            if obj.update ~= nil then obj:update(dt); end
        end
    end

    function Workspace:dPrint(msg)
        if self.debugMode then OBJ_PRINT(Workspace,msg); end
    end