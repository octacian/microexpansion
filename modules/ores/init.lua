-- ores/init.lua

local me = microexpansion

-- [register] Incranium Ore
me.register_node("incranium", {
  description = "Incranium Ore",
  tiles = { "incranium" },
  is_ground_content = true,
  groups = { cracky=3, stone=1 },
  type = "ore",
  oredef = {
    {
      ore_type = "blob",
      wherein = "default:stone",
      clust_scarcity = 4*4*4,
      clust_num_ores = 4,
      clust_size = 3,
      y_min = -300,
      y_max = -90,
    },
  },
  disabled = true,
})

-- "Supernatet", pronounced "Super-nat-et" is Latin for "float", this ore will
-- float up if there are no blocks above it, so be careful!
-- Supernatet ore will be used to craft wings of flight
me.register_node("supernatet", {
  description = "Supernatant Ore",
  tiles = { "default_stone.png^microexpansion_ore_supernatet.png" },
  is_ground_content = true,
  type = "ore",
  groups = { cracky=3, stone=1 },
  oredef = {
    ore_type = "blob",
    wherein = "default:stone",
    clust_scarcity = 4*4*4,
    clust_num_ores = 4,
    clust_size = 3,
    y_min = -300,
    y_max = -90,
  },
  status = "unstable",
})
