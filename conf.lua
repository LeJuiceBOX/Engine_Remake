version = "0.0.0"

settings = {}
settings.title = "Engine-Remake"
settings.developer = "David Hunt"
settings.windowSize = {1024,576}
settings.vsync = false
settings.version = version
settings.console = true

function love.conf(t)
	io.stdout:setvbuf("no") --// Makes console work for sublime
	t.window.title = "[ "..settings.title.." ] - <"..version..">"
	t.window.width = settings.windowSize[1]
	t.window.height = settings.windowSize[2]
	t.window.vsync = settings.vsync
	t.console = settings.console
end

return settings;