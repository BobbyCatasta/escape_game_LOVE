require("lldebugger").start() -- Required for debugging in VSCode

function AddPackagePaths()
    -- Lista di directory da cui caricare i moduli
    local directories = {
        "./",
        "src/user_interface/",                
        "src/states/",                          
        "src/user_interface/menu/",             
        "src/game/",
        "src/core/",
        "src/utilities/",
        "libs/",
    }

    for _, dir in ipairs(directories) do
        package.path = package.path .. ";" .. dir .. "?.lua"
        -- package.path = package.path .. ";" .. dir .. "*/?.lua"  
        -- package.path = package.path .. ";" .. dir .. "*/**/?.lua" 
    end
end

-- Global Variables Setups

AddPackagePaths()

gClass = require("middleclass")
gUtils = require("utils")



