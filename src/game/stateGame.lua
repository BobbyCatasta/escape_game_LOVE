local class = require('middleclass')
local state_game = class('state_game')

local itemClass = require('item')
local ui_itemClass = require('ui_item')

local inventory = {}

function state_game:load()
    local item = itemClass:new('Pisello',"circleKey.png")
    local uielement = ui_itemClass:new(300,150,item)
    table.insert(inventory,uielement)
    item = itemClass:new('Figa',"key.png")
    uielement = ui_itemClass:new(150,150,item)
    table.insert(inventory,uielement)   
    item = itemClass:new('Figa',"circleKey.png")
    uielement = ui_itemClass:new(600,600,item)
    table.insert(inventory,uielement)   
end

function state_game:update(dt)
    for _, item in ipairs(inventory) do
        item:update(dt)
    end
end

function state_game:draw()
    for _, item in ipairs(inventory) do
        item:draw()
    end
end

function state_game:mousepressed(x,y,mouseBtn)
    for _, item in ipairs(inventory) do
        item:mousepressed(x,y,mouseBtn)
    end
end

function state_game:mousereleased(x,y,mouseBtn)
    for _, item in ipairs(inventory) do
        item:mousereleased(x,y,mouseBtn)
    end
end
return state_game