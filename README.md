# SDropdown
The library creates a simple drop-down interface for Love2d

# How to use 🤔
*Create an SDropdown object*
```lua
local SDropdown = require("sdropdown")

function love.load()
  w, h = love.graphics.getWidth(), love.graphics.getHeight()
  love.window.setMode(w, h, {highdpi = false})
  w, h = love.graphics.getWidth(), love.graphics.getHeight()
  -- the first parameter is the x-axis of the dropdown
  -- the second parameter is the y-axis of the dropdown
  -- 3rd parameter is the width of the dropdown
  -- 4th parameter is the height of the push button
  -- the 5th parameter is the color of the button
  -- the 6th parameter is the color of the dropdown
  -- 7th parameter is the height of the bottom dropdown
  -- 8th parameter is the height of each item
  -- the 9th parameter is the Font of the dropdown
  -- the 10th parameter is the items
  dropdown = SDropdown:new(w / 2 - 200 / 2, 100, 200, 50, {105, 105, 105}, {192, 192, 192}, 100, 40, Font.MC, {"Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"})
end

function love.update(dt)
  dropdown:update()
end

function love.draw()
  love.graphics.setColor(love.math.colorFromBytes(250, 250, 210))
  love.graphics.rectangle("fill", 0, 0, w, h)
  love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
  dropdown:draw()
end

function love.touchpressed(id, x, y)
  dropdown:touchPressed(id, x, y)
end

function love.touchreleased(id, x, y)
  dropdown:touchReleased(id, x, y)
end
```
# Preview 😳
![](https://github.com/lenlenlL6/SDropdown/blob/main/20230707_212946_001.gif)
