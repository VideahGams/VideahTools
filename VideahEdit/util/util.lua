-- Some functions I find useful for things

util = {}

function util.getTimestamp()

  return os.date("%x_%X"):gsub("[/:]", "-")

end

function util.getDistance( x1, y1, x2, y2)

	local dx = x1 - x2
	local dy = y1 - y2
	return math.sqrt( dx * dx ), math.sqrt( dy * dy)

end

function util.getDistanceX( x1, y1, x2, y2)

	local dx = x1 - x2
	local dy = y1 - y2
	return math.sqrt( dx * dx )

end

function util.getDistanceY( x1, y1, x2, y2)

	local dx = x1 - x2
	local dy = y1 - y2
	return math.sqrt( dy * dy )

end

function util.dprint(string)
	if global.debug then
		print("[DEBUG]:" .. string)
	end
end

function util.round(num)
	return math.floor(num + 0.5)
end

-- Pretty bad triangle function
-- Needs rethinking, as positioning isn't exactly xy based.

function util.drawTriangle(direction, x, y, width, height)

	if direction == "up" then

		love.graphics.polygon('fill', x, y, x + width, y, x + (width / 2), y - height)

	elseif direction == "down" then

		love.graphics.polygon('fill', x, y, x + width, y, x + (width / 2), y + height)

	elseif direction == "right" then

		love.graphics.polygon('fill', x, y, x, y + height, x + width, y + (height / 2))

	elseif direction == "left" then

		love.graphics.polygon('fill', x, y, x, y + height, x - width, y + (height / 2))

	end

end