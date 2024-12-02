local class = require('middleclass')
local ui_Item = class('ui_Item')
local item = require('item')

local hoveredScale = {width = 1.5, height = 1.5}
local unhoveredScale = {width = 1, height = 1}

local flux = require('flux')

local currentAnim

function ui_Item:initialize(x,y,item)
    self.x = x
    self.y = y
    self.item = item
    self.name = item.name
    self.sprite = self.item:GetSprite()
    self.hasHovered = false
    self.xScale = 1
    self.yScale = 1
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

function ui_Item:update(dt)
    flux.update(dt)
    self:HoverAnimation()
end

function ui_Item:draw()
    love.graphics.draw(self.sprite, self.x, self.y, 0, self.xScale, self.yScale, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
end


function love.mousepressed(x,y,mousebtn)
end



function ui_Item:IsHovered(x,y) 
    return x>=self.x - self.sprite:getWidth()/2 and x<=self.x - self.sprite:getHeight()/2 + self.width and
           y>= self.y - self.sprite:getHeight()/2 and y<=self.y - self.sprite:getHeight()/2 + self.height 
end

function ui_Item:HoverAnimation()
    local x,y = love.mouse.getPosition()
    if self:IsHovered(x,y) then
        self:EnterHoverAnimation()
    else
        self:ExitHoverAnimation()
    end
end


function ui_Item:EnterHoverAnimation()
    if currentAnim then 
        currentAnim:stop()
    end
    currentAnim = flux.to(self,0.2,{xScale = 1.3,yScale = 1.3})
end

function ui_Item:ExitHoverAnimation()
    self.hasHovered = false
    if currentAnim then 
        currentAnim:stop()
    end
    currentAnim = flux.to(self,0.2,{xScale = 1,yScale = 1})
end

return ui_Item