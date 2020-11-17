Label = Object:extend()

function Label:new(text, x, y, width, color, align)
    self.text = text or ""

    self.x = x
    self.y = y
    self.width = width

    self.alignment = align or "center"
    self.color = color or love.graphics.getColor()

    self.visible = true
end

function Label:reset()
end

function Label:update(dt)
end

function Label:draw()
  if (self.visible) then
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4] or 1.0)
    love.graphics.printf(self.text, self.x, self.y, self.width, self.alignment)
  end
end