
local gamera = require("Core.Libraries.gamera")
require("Core.Objects.camera")

local class = require(MIDDLECLASS)
SceneManager = class("SceneManager")
    SceneManager.static.SCENE_DIR = 'Game.Scenes.';

    function SceneManager:initialize()
        self.scene_current = nil
        self.scene_last = nil
        self.scene = nil
        self.camera = Camera:new(0,0,2000,2000)
    end

    function SceneManager:switch(sceneName)
        self.scene_last = self.scene_current
        self.scene_current = SceneManager.static.SCENE_DIR..sceneName
        self.scene = require(self.scene_current)
        print("[SceneManager] - Switched scenes. ('"..tostring(self.scene_last).."' -> '"..tostring(self.scene_current).."')")
        if self.scene and self.scene.preload ~= nil then self.scene.preload(self.camera); end
        if self.scene and self.scene.load ~= nil then self.scene.load(self.camera); end -- call load if scene has one
        print("[SceneManager] - Loaded current scene.")
    end

    function SceneManager:update(dt)
        if self.scene == nil or self.scene.update == nil then return; end
        self.scene.update(dt)
        self.camera:update(dt)
    end

    function SceneManager:draw()
        if self.scene == nil or self.scene.draw == nil then return; end
        if self.camera ~= nil then
            self.camera.gamera:draw(function(x,y,w,h) self.scene.draw(x,y,w,h); end)
        else
            self.scene.draw(x,y,w,h)
        end
        self.camera:debugDraw()
    end