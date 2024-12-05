function AddPackagePaths()
    -- Lista di directory da cui caricare i moduli
    local directories = {
        "./",
        "src/user_interface/",                
        "src/states/",                          
        "src/user_interface/menu/",             
        "src/game/",
        "src/data/",
        "src/core/",
        "src/utils/",
        "libs/",
    }

    for _, dir in ipairs(directories) do
        package.path = package.path .. ";" .. dir .. "?.lua"
        package.path = package.path .. ";" .. dir .. "*/?.lua"  
        package.path = package.path .. ";" .. dir .. "*/**/?.lua" 
    end
end


AddPackagePaths() --Add Path for require/()

-- Variables
local class = require("middleclass")

local state_game = require('stateGame')

local flux = require('flux')

gDebug = false
currentState = state_game:new()

-- Methods
function love.load(args)
    if arg[#arg] == "-debug" and gDebug then
        require("mobdebug").start()
    end
    currentState:load()
end

function love.draw()
    currentState:draw(dt)
end

function love.update(dt)
    currentState:update(dt)
    flux.update(dt)
end

function love.mousepressed(x,y,mouseBtn)
   currentState:mousepressed(x,y,mouseBtn) 
end

function love.mousereleased(x,y,mouseBtn)
   currentState:mousereleased(x,y,mouseBtn) 
end



