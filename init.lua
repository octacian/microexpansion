-- microexpansion/init.lua
microexpansion = {}
microexpansion.modpath = minetest.get_modpath("microexpansion") -- modpath
local modpath = microexpansion.modpath -- modpath pointer

-- logger
function microexpansion.log(content, log_type)
  if not content then return false end
  if log_type == nil then log_type = "action" end
  minetest.log(log_type, "[MicroExpansion] "..content)
end

-- Load API
dofile(modpath.."/api.lua")
