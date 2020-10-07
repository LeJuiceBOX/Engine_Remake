local Vector2 = require("Core.Classes.vector2")

local UserInput = {}

    local key_states = {}

	function UserInput.update(dt)
		for i,v in pairs(key_states) do --// Clears state
			key_states[i] = nil
		end
	end

	function UserInput.hookLoveEvents()
		function love.keypressed(key, scancode, isrepeat)
			key_states[key] = true
		end
		function love.keyreleased(key, scancode)
			key_states[key] = false
		end
		function love.mousepressed(x,y,button,isTouch,clicks)
			key_states[button] = true
		end
		function love.mousereleased(x,y,button,isTouch,clicks)
			key_states[button] = false
		end
	end
	
    --// Keyboard

    UserInput.keyboard = {} 

	    function UserInput.keyboard:key(key) --// Returns current state of key
	        return love.keyboard.isDown(key)
	    end

	    function UserInput.keyboard:keyReleased(key) --// Returns key state THIS frame
	        return key_states[key] == false
	    end

	    function UserInput.keyboard:keyPressed(key)
	        return key_states[key]
	    end

	--// Mouse

	UserInput.mouse = {}

		function UserInput.mouse:position()
			return Vector2:fromTable(love.mouse.getPosition())
		end

		function UserInput.mouse:mouseButtonPressed(button)
			return key_states[button] == true
		end

		function UserInput.mouse:mouseButtonReleased(button)
			return key_states[button] == false
		end

		function UserInput.mouse:button(...)
			return love.mouse.isDown(...)
		end

	--// General

return UserInput