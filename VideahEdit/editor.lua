editor = {}
editor.entities = {}
editor.entities.lights = {}

function editor.load()

	local botpanel = loveframes.Create("frame")
	botpanel:SetSize(500, 300)
	botpanel:SetPos(global.screenWidth - 500, global.screenHeight - 300)
	         
	local botpaneltabs = loveframes.Create("tabs", botpanel)
	botpaneltabs:SetPos(5, 30)
	botpaneltabs:SetSize(490, 265)

end

function editor.draw()

end

function editor.update(dt)

end