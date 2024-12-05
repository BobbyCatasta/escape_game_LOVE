local class = require('middleclass')

local itemClass = require('item')
local ui_Item = class('ui_Item')

local ui_Item = class('ui_Item')
local item = require('item')

local hoveredScale = {width = 1.5, height = 1.5}
local unhoveredScale = {width = 1, height = 1}

local flux = require('flux')

local enterAnim

function ui_Item:initialize(x,y,item,fn)
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
    self.hoverAnim = nil
    self.selectedAnim = nil
    self.selected = false
    self.clicked = false
    self.rot = 0
end

function ui_Item:update(dt)
    self:HoverAnimation()
end

function ui_Item:mousereleased(x,y,mousebtn)
    if self.clicked then
        if self:IsHovered(x,y) then
            if not self.selected then
                self.selected = true
                self:SelectedAnim()
            else
                self.selectedAnim:stop()
                self.rot = 0
                self.selected = false
            end
        end
    end
    self.clicked = false
end

function ui_Item:mousepressed(x,y,mousebtn)
    if self:IsHovered(x,y) and mousebtn == 1 then
        self.clicked = true
    end
end


function ui_Item:IsHovered(x,y)
    local width = self.sprite:getWidth()*self.xScale
    local height = self.sprite:getHeight()*self.yScale

    return x >= self.x - width / 2 and x <= self.x + width / 2 and
           y >= self.y - height / 2 and y <= self.y + height / 2
end

function ui_Item:HoverAnimation()
    local x,y = love.mouse.getPosition()
    if self:IsHovered(x,y) and not self.hasHovered  then
        self:EnterHoverAnimation()
    else 
        if not self:IsHovered(x,y) and self.hasHovered then
            self:ExitHoverAnimation()
        end
    end
end


function ui_Item:draw()
    if self.selected then
        love.graphics.setColor(1,0.64,0)
    else
        if self.clicked then
            love.graphics.setColor(0.5,0.5,0.5)
        else
            love.graphics.setColor(1,1,1)
        end
    end
    
    if(self.rot ~= 0 and not self.selected) then
        self.rot = 0
    end
    love.graphics.draw(self.sprite, self.x, self.y, self.rot, self.xScale, self.yScale, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
end

function ui_Item:SelectedAnim()
    if not self.selected then
        return
    end
    self.rot = 0
    self.selectedAnim = flux.to(self,0.05,{rot = -0.03})
    :ease("sineinout")
    :oncomplete(function() if self.selected then self.selectedAnim = flux.to(self,0.05,{rot = 0.03}):ease("sineinout") end end)
    :oncomplete(function() self:SelectedAnim() end)
end

function ui_Item:EnterHoverAnimation()
    if self.hoverAnim then
        self.hoverAnim:stop()
    end
    self.hasHovered = true
    self.hoverAnim = flux.to(self,0.15,{xScale = 1.3,yScale = 1.3})
    :oncomplete(function () self.currentAnim = flux.to(self,0.1,{xScale = 1.2,yScale = 1.2}) end):ease("circout")
end

function ui_Item:ExitHoverAnimation()
    if self.hoverAnim then
        self.hoverAnim:stop()
    end
    self.hasHovered = false
    self.hoverAnim = flux.to(self,0.15,{xScale = 1,yScale = 1})
end

return ui_Item