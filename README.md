ow# SDropdown
The library creates a simple drop-down interface for Love2d

# How to use 🤔
*Create an SDropdown object*
```lua
local SDropdown = require("sdropdown")

function love.load()
  w, h = love.graphics.getWidth(), love.graphics.getHeight()
  love.window.setMode(w, h, {highdpi = false})
  w, h = love.graphics.getWidth(), love.graphics.getHeight()
  dropdown = SDropdown:new(w / 2 - 200 / 2, 100, 200, 50, {105, 105, 105}, {192, 192, 192}, 100, 40, Font.MC, {"Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"})
end

function love.update(dt)

end

function love.draw()

end
```
