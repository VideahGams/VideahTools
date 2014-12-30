---------------------------------------------------------------------------------------------------
-- Imports

require 'util/audio'
require 'util/input'

require 'util/debug'
LIP = require 'util/LIP' 

require 'util/util'

m_math 		= require 'util/math'
m_collide 	= require 'util/collide'
socket = require 'socket'

require 'fonts'
require 'map'
require 'camera'
require 'state'
require 'splash'
require 'panel'
require 'lighting'
require 'global'
require 'input'
require 'options'
require 'editor'

---------------------------------------------------------------------------------------------------
-- Libraries

require 'libs/LoveFrames'

sti = require 'libs/STI'
jumper = require 'libs/Jumper'
flux = require 'util/flux'
LightWorld = require 'libs/lightworld'


---------------------------------------------------------------------------------------------------
-- Main

function love.load()

	lighting.load()

	options.load()

	global.debug = options.settings.settings.debug

	love.mouse.setGrabbed(true)	

	love.graphics.setBackgroundColor(35, 65, 85)

	editor.load()

	map.load()

	splash.load()

	panel.load()

	font.load()
	
	input.load()

	print("Welcome to VideahEdit " .. global.version .. " !")

end

function love.draw()

	if state:isStateEnabled("editor") then

		lighting.world:setTranslation(-camera.x * camera.scale, -camera.y * camera.scale, camera.scale)

		camera:set()

		lighting.world:draw(function()

		love.graphics.setColor(0, 0, 0)

		love.graphics.rectangle("fill", camera.x, camera.y, global.screenWidth, global.screenHeight )

		love.graphics.setColor(255, 255, 255)

		map.draw()

		end)

		editor.draw()

		camera:unset()

		loveframes.draw()

	end

	if state:isStateEnabled("splash") then

		splash.draw()

	end

	global.fps = love.timer.getFPS()

	panel.draw()

end

function love.update(dt)

	global.update(dt)

	flux.update(dt)

	love.audio.update()

	if state:isStateEnabled("editor") then

		map.update(dt)
		camera.update(dt)
		lighting.update(dt)
		editor.update(dt)
		loveframes.update(dt)
		
	end

	if state:isStateEnabled("quit") then

		love.event.quit()

	end

	input.update(dt)

end

function love.keypressed(key, isrepeat)

	if state:isStateEnabled("splash") == false then
		if key == "escape" then

			love.event.quit()

		end
	end

	if state:isStateEnabled("splash") then
		splash.keypressed(key, isrepeat)
	end

	loveframes.keypressed(key, isrepeat)

end

function love.mousepressed(x, y, button)
 
    -- your code
 
    input.mousepressed(x, y, button)

    loveframes.mousepressed(x, y, button)
 
end
 
function love.mousereleased(x, y, button)
 
    -- your code
 
    loveframes.mousereleased(x, y, button)
 
end
 
function love.keyreleased(key)
 
    -- your code
 
    loveframes.keyreleased(key)
 
end

function love.textinput(text)
             
    -- your code
 
    loveframes.textinput(text)
 
end

function love.quit()

	print("Shutting down ...")

end
