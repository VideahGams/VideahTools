editor = {}
editor.entities = {}
editor.entities.lights = {}

function editor.load()
	         
	local botpanel = loveframes.Create("tabs")
	botpanel:SetSize(global.screenWidth, 235)

	local panelwidth, panelheight = botpanel:GetSize()
	botpanel:SetPos(0, global.screenHeight - panelheight)

	local panel = loveframes.Create("panel")
    panel.Draw = function()
    end

    local debugpanel = loveframes.Create("panel")

    botpanel:AddTab("Test", panel, "Test")
    botpanel:AddTab("Debug", debugpanel)

end

function editor.draw()

end

function editor.update(dt)

end