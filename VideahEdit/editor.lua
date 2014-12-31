editor = {}
editor.entities = {}
editor.entities.lights = {}
editor.entities.selected = nil

editor.axis = {}

editor.axis.x = 0
editor.axis.y = 0


editor.currentstate = "select"

function editor.load()
	         
	editor.createBotPanel()
	editor.createSidePanel()

end

function editor.draw()

	-- Draw something at every lights position
	-- To give a visual indicator on where they are

	for i=1, #editor.entities.lights do

		local x, y, z = editor.entities.lights[i]:getPosition() -- Why there isn't an easier way of pruning the z axis, I don't know

		love.graphics.rectangle("fill", x - 8, y - 8, 16, 16)

	end

	if editor.entities.selected ~= nil then

		editor.axis.draw()

	end

end

function editor.update(dt)

	editor.axis.update(dt)

end

function editor:setSelected(object)

	editor.entities.selected = object

end

-- Editor Interface --

function editor.createBotPanel()

	-- Bot Panel --

	local botpanel = loveframes.Create("tabs")
	botpanel:SetSize(global.screenWidth - 75, 235)

	local panelwidth, panelheight = botpanel:GetSize()
	botpanel:SetPos(0, global.screenHeight - panelheight)

	-- Tab Panels --

	local toolpanel = loveframes.Create("panel")
    toolpanel.Draw = function()
    end

    local debugpanel = loveframes.Create("panel")

    -- Bot Tabs --

    botpanel:AddTab("Tools", toolpanel)
    botpanel:AddTab("Debug", debugpanel)

    -- Entity Creation [TEMP] --

    local entityform = loveframes.Create("form", toolpanel)
	entityform:SetLayoutType("vertical")
	entityform:SetName("Create")

	local lightbutton = loveframes.Create("button")
	lightbutton:SetSize(50,50)
	lightbutton:SetText("Light")
	lightbutton.OnClick = function(object)

	editor.entities.lights[#editor.entities.lights + 1] = lighting.world:newLight(camera:getPositionX() + global.centerWidth - 75, camera:getPositionY() + global.centerHeight - 75)

	editor:setSelected(editor.entities.lights[#editor.entities.lights])

	end

	entityform:AddItem(lightbutton)

end

function editor.createSidePanel()

	-- Side Panel --

	local sidepanel = loveframes.Create("panel")

	sidepanel:SetSize(75, global.screenHeight)

	local panelwidth, panelheight = sidepanel:GetSize()
	sidepanel:SetPos(global.screenWidth - panelwidth, 0)

	-- Side Panel Buttons --

	local selectbutton = loveframes.Create("button", sidepanel)
	selectbutton:SetSize(75,75)
	selectbutton:SetText("Select")

	selectbutton.OnClick = function(object)
		util.dprint("Switching edit state to 'select'")
		editor.currentstate = "select"
	end

	local movebutton = loveframes.Create("button", sidepanel)
	movebutton:SetSize(75,75)
	movebutton:SetPos(0,75)
	movebutton:SetText("Move")

	movebutton.OnClick = function(object)
		util.dprint("Switching edit state to 'move'")
		editor.currentstate = "move"
	end
	
end


-- Editor Axis --

function editor.axis.draw()

	love.graphics.setColor(0, 0, 255)

	love.graphics.rectangle("fill", editor.axis.x, editor.axis.y, 2, 2)

	love.graphics.setColor(255, 0, 0)

	love.graphics.rectangle("fill", editor.axis.x + 2, editor.axis.y, 64, 2)

	love.graphics.setColor(0, 255, 0)

	love.graphics.rectangle("fill", editor.axis.x, editor.axis.y - 64, 2, 64)

	love.graphics.setColor(255, 255, 255)

end

function editor.axis.setPosition(x, y)

	editor.axis.x, editor.axis.y = x, y

end

function editor.axis.update(dt)

	if editor.entities.selected ~= nil then

		editor.axis.setPosition(editor.entities.selected:getPosition())

		if camera:getMouseX() > editor.axis.x and camera:getMouseX() > editor.axis.y then
			editor.entities.selected:setPosition(camera:getMousePosition())
		end

	end

end