-- power/init.lua

local me = microexpansion

local networks = me.networks
local path     = microexpansion.get_module_path("power")

me.power = {}
local power = me.power

-- Load Resources

dofile(path.."/network.lua") -- Network Management
dofile(path.."/register.lua") -- Machine Registration
dofile(path.."/ctrl.lua") -- Controller/wires
dofile(path.."/gen.lua") -- Generators
