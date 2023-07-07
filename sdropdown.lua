local SDropdown = {}

local function setColor(color)
  love.graphics.setColor(love.math.colorFromBytes(unpack(color)))
end

function SDropdown:new(x, y, w, h, color, dropColor, dropH, butH, font, items)
  local d = {}
  setmetatable(d, {__index = self})
  d.x = x
  d.y = y
  d.w = w
  d.h = h
  d.color = color
  d.dropColor = dropColor
  d.dropH = dropH
  d.butH = butH
  d.font = font
  d.items = {}
  local yAdd = 0
  for _, v in ipairs(items) do
    table.insert(d.items, {x = 0, y = yAdd, txt = v, fixedY = yAdd})
    yAdd = yAdd + butH
  end
  d.itemIndex = 1
  if #d.items == 0 then
    d.itemIndex = 0
  end
  d.dropdown = false
  d.canvas = love.graphics.newCanvas(w, dropH)
  return d
end

function SDropdown:update()
  if not self.dropdown then
    return
  end
  for _, v in ipairs(love.touch.getTouches()) do
    local x, y = love.touch.getPosition(v)
    if v == self.sId then
      local yAdd = self.sy - y
      if #self.items > 0 then
        if self.items[1].fixedY - yAdd > 0 then
          yAdd = self.items[1].fixedY - 0
        end
        if (self.items[#self.items].fixedY + self.butH) - yAdd < self.dropH then
          yAdd = (self.items[#self.items].fixedY + self.butH) - self.dropH
        end
      end
      for _, v in ipairs(self.items) do
        v.y = v.fixedY - yAdd
      end
    end
  end
end

function SDropdown:draw()
  setColor(self.color)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  setColor({255, 255, 255})
  local item = nil
  if self.itemIndex == 0 then
    item = ""
  else
    item = self.items[self.itemIndex].txt
  end
  local txt = love.graphics.newText(self.font, item)
  love.graphics.draw(txt, self.x + 10, (self.y + self.h / 2) - self.font:getHeight() / 2)
  -- love.graphics.rectangle("line", self.x, self.y + self.h, self.w, self.dropH)
  if self.dropdown then
    self.canvas:renderTo(function()
      love.graphics.clear()
      setColor(self.dropColor)
      love.graphics.rectangle("fill", 0, 0, self.w, self.dropH)
      setColor({255, 255, 255})
      for _, v in ipairs(self.items) do
        local txt = love.graphics.newText(self.font, v.txt)
        love.graphics.draw(txt, v.x + 10, (v.y + self.butH / 2) - txt:getHeight() / 2)
        love.graphics.rectangle("line", v.x, v.y, self.w, self.butH)
      end
    end)
    love.graphics.draw(self.canvas, self.x, self.y + self.h)
  end
end

function SDropdown:touchPressed(id, x, y)
  if not self.dropdown then
    if x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h then
      self.dropdown = true
    end
    return
  end
  if x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h then
    self.dropdown = false
    return
  end
  if x >= self.x and x <= self.x + self.w and y >= (self.y + self.h) and y <= (self.y + self.h + self.dropH) then
    if not self.sId then
      self.sId = id
      self.sx, self.sy = x, y
    end
    return
  end
  self.dropdown = false
end

function SDropdown:touchReleased(id, x, y)
  if self.sId == id then
    if self.sx == x and self.sy == y then
      local x, y = x - self.x, y - (self.y + self.h)
      for i, v in ipairs(self.items) do
        if x >= v.x and x <= v.x + self.w and y >= v.y and y <= self.y + self.butH then
          self.itemIndex = i
          self.dropdown = false
        end
      end
    end
    self.sId = nil
    self.sx, self.sy = nil, nil
    for _, v in ipairs(self.items) do
      v.fixedY = v.y
    end
  end
end

function SDropdown:getItem()
  if #self.items == 0 then
    return ""
  end
  return self.items[self.itemIndex]
end

return SDropdown
