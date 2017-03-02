-- power/init.lua

local path = microexpansion.get_module_path("power")

-- Power generators, wires, etc...

-- Load Resources

dofile(path.."/ctrl.lua") -- Controller
dofile(path.."/gen.lua") -- Generators
