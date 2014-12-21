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

require 'menu'
require 'fonts'
require 'map'
require 'camera'
require 'state'
require 'splash'
require 'panel'
require 'hud'
require 'lighting'
require 'global'
require 'input'
require 'options'
require 'cursor'
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

	cursor.load()

	love.mouse.setCursor(cursor.cursor)

	love.graphics.setBackgroundColor(35, 65, 85)

	map.load()

	hud.load()

	splash.load()

	panel.load()

	font.load()
	
	input.load()

	menu.load()

	print("Welcome to VideahEdit " .. global.version .. " !")

end

function love.draw()

	if state:isStateEnabled("editor") then

		lighting.world:setTranslation(-camera.x * camera.scale, -camera.y * camera.scale, camera.scale)

		camera:set()

		lighting.world:draw(function()

		love.graphics.rectangle("fill", camera.x, camera.y, global.screenWidth, global.screenHeight )

		map.draw()

		end)

		camera:unset()

		hud.draw()

	end

	if state:isStateEnabled("splash") then

		splash.draw()

	end

	if state:isStateEnabled("menu") then

		menu.draw()

		loveframes.draw()

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
		hud.update(dt)
		--love.mouse.setVisible(false)
		
	end

	if state:isStateEnabled("multiplayer") then

		map.update(dt)

	end

	if state:isStateEnabled("menu") or state:isStateEnabled("options") then

		menu.update(dt)
		loveframes.update()
		love.mouse.setVisible(true)
		love.mouse.setCursor(cursor.cursor)

	end

	if state:isStateEnabled("options") then

		loveframes.SetState("options")

	end

	if state:isStateEnabled("menu") then

		loveframes.SetState("menu")

	end

	if state:isStateEnabled("quit") then

		love.event.quit()

	end

	input.update(dt)

end

function love.keypressed(key, isrepeat)

	if state:isStateEnabled("splash") == false then
		if key == "escape" then

			state:changeState("menu")

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
