local class = require('middleclass')
local item = class('item')


function item:initialize(name,spriteName)
  self.name = name
  self.sprite = love.graphics.newImage("assets/images/"..spriteName)
end

function item:GetSprite()
  return self.sprite
end

return item