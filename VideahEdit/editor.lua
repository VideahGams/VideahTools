editor = {}
editor.entities = {}
editor.entities.lights = {}

editor.currentstate = "select"

function editor.load()
	         
	editor.createBotPanel()
	editor.createSidePanel()

end

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

	editor.entities.lights[#editor.entities.lights + 1] = lighting.world:newLight()

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

function editor.draw()

	-- Draw something at every lights position
	-- To give a visual indicator on where they are

	for i=1, #editor.entities.lights do

		local x, y, z = editor.entities.lights[i]:getPosition()

		love.graphics.rectangle("fill", x - 10, y - 10, 20, 20)
		
	end

end

function editor.update(dt)

end