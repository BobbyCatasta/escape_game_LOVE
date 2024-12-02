local class = require('middleclass')
local state_game = class('state_game')

local item = require('item')
local ui_item = require('ui_item')

local inventory = {}

function state_game:load()
    local item = item:new('Pisello',"key.png")
    local uielement = ui_item:new(500,500,item)
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

return state_game