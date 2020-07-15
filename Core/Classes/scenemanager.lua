
local gamera = require("Core.Libraries.gamera")

local class = require(MIDDLECLASS)
SceneManager = class("SceneManager")
    SceneManager.static.SCENE_DIR = 'Game.Scenes.';

    function SceneManager:initialize()
        self.scene_current = nil
        self.scene_last = nil
        self.scene = nil
    end

    function SceneManager:switch(sceneName)
        self.scene_last = self.scene_current
        self.scene_current = SceneManager.static.SCENE_DIR..sceneName
        self.scene = require(self.scene_current)
        print("[SceneManager] - Switched scenes. ('"..tostring(self.scene_last).."' -> '"..tostring(self.scene_current).."')")
        if self.scene and self.scene.load ~= nil then self.scene.load(); end -- call load if scene has one
        print("[SceneManager] - Loaded current scene.")
    end

    function SceneManager:update(dt)
        if self.scene == nil or self.scene.update == nil then return; end
        self.scene.update(dt)
    end

    function SceneManager:draw()
        if self.scene == nil or self.scene.draw == nil then return; end
        self.scene.draw()
    end