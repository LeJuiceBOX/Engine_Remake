print("\n///////////////////////////////\n- Author: "..settings.developer.."\n- Title:  "..settings.title.."\n///////////////////////////////\n\n")
--========================
--// Global Variables \\--
--========================
MIDDLECLASS = "Core.middleclass";
OBJ_PRINT = function(class,msg) print("["..class.name.."] - "..msg) end
--================
--// Required \\--
--================
local UserInput = require("Core.Libraries.userinput")
require("Core.Classes.scenemanager")

function love.load()
    showProfiler = false
    love.profiler = require('Core.Profiling.profile') 

    scn_mngr = SceneManager:new()
    scn_mngr:switch("scene_game")
end

love.frame = 0
function love.update(dt)
   
    -- scene managing
    if scn_mngr.scene ~= nil or scn_mngr.scene.update ~= nil then scn_mngr.scene.update(dt); end

    if UserInput.keyboard:keyPressed('q') then love.event.quit(); end
    if UserInput.keyboard:keyPressed('p') then showProfiler = not showProfiler; if showProfiler then love.profiler.start(); else love.profiler.stop(); end end

    UserInput.update(dt)

    if showProfiler then love.frame = love.frame + 1; if love.frame%3000 == 0 then love.report = love.profiler.report(15); love.profiler.reset(); end end
end

function love.draw()
    if scn_mngr.scene ~= nil or scn_mngr.scene.update ~= nil then scn_mngr.scene.draw() end
    if showProfiler then debugProfiler(16,100); debugData(16,16) end
end

UserInput.hookLoveEvents()

function debugData(x,y)
    Color:fromRGB(20,50,100,0.5)
    love.graphics.rectangle("fill",x,y,250,64)
    Color:reset()
    love.graphics.print(
        "FPS: \t"..love.timer.getFPS()..
        "\nAvgDelta:\t"..love.timer.getAverageDelta()..
        "\n"
    ,x+16,y+16)
end

function debugProfiler(x,y)
    Color:fromRGB(20,50,100,0.5)
    love.graphics.rectangle("fill",x,y,700,316)
    Color:reset()
    love.graphics.print(love.report or "Please wait...",x+16,y+8);
end