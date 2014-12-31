camera = {}
camera.x = 0
camera.y = 0

camera.scale = 2
camera.rotation = 0
camera.type = "unlocked"
camera.speed = 500

print("Loaded camera system ...")

function camera:set()

  --  Sets the scene by rotating and changing position of the camera.

  love.graphics.push()
  love.graphics.scale(self.scale)
  love.graphics.translate(-self.x, -self.y)
  love.graphics.rotate(-self.rotation)

end

function camera.update(dt)

  if camera.type == "unlocked" then

    camera.unlockedControls(dt)

  end


end

function camera.unlockedControls(dt)

  if input.isDown("camera.forward") then camera:move(0, math.floor(-camera.speed) * dt) end
  if input.isDown("camera.backward") then camera:move(0, math.floor(camera.speed) * dt) end
  if input.isDown("camera.left") then camera:move(-camera.speed * dt, 0) end
  if input.isDown("camera.right") then camera:move(camera.speed * dt, 0)  end

end

function camera:unset()
  love.graphics.pop()
end

function camera:move(dx, dy)
  self.x = util.round(self.x + (dx or 0))
  self.y = util.round(self.y + (dy or 0))
end

function camera:rotate(dr)
  self.rotation = self.rotation + dr
end

function camera:setScale(sx)
  sx = sx or 1
  self.scale = sx
end

function camera:setPosition(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

function camera:lookAt(x, y)
  self.x = x - (global.centerWidth) / self.scale or self.x
  self.y = y - (global.centerHeight) / self.scaleY or self.y
end

function camera:setScale(s)
  self.scale = s or self.scale
end

function camera:getPosition()
  return self.x, self.y
end

function camera:getPositionX()
  return self.x
end

function camera:getPositionY()
  return self.y
end

function camera:getScale()
  return self.scale
end

function camera:getMousePosition()
  return love.mouse.getX() / self.scale + self.x, love.mouse.getY() / self.scale + self.y
end

function camera:getMouseX()
  return love.mouse.getX() / self.scale + self.x
end

function camera:getMouseY()
  return love.mouse.getY() / self.scale + self.y
end

function camera:setType(type)
  self.type = type
end

function camera:getType()
  return self.type
end

function camera:shake(stype, intensity, fade, fadeduration)

  if stype == "lock" then

    self.shaking = true
    self.intensity = intensity or 0
    self.shaketype = "lock"

    self.shakeX, self.shakeY = camera:getPosition()


  elseif stype == "player" then

    self.shaking = true
    self.intensity = intensity or 0
    self.shaketype = "player"


  elseif stype == "hybrid" then

    self.shaking = true
    self.intensity = intensity or 0
    self.shaketype = "hybrid"

  else

    self.shaking = true
    self.intensity = intensity or 0
    self.shaketype = "lock"

    self.shakeX, self.shakeY = camera:getPosition()

  end

  self.fade = fade or false
  self.fadeduration = fadeduration or 0

end

function camera:unshake()

  self.shaking = false

end
