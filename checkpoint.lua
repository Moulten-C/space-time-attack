local checkpoint = {}
local ship = require("ship")

windowDimensions = {}
windowDimensions.width = love.graphics.getWidth()
windowDimensions.height = love.graphics.getHeight()

checkpoint.img = love.graphics.newImage("")
checkpoint.ox = checkpoint.img:getWidth() / 2
checkpoint.oy = checkpoint.img:getHeight() / 2
checkpoint.x = 0
checkpoint.y = 0
checkpoint.r = 0

return checkpoint
