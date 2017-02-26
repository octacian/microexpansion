minetest.register_node(microexpansion:incranium", {
  description = "Incranium Ore",
  tiles = incranium_ore.png" },
  is_ground_content = true,
  drop = microexpansion:incranium",
  groups = { cracky=3, stone=1 },
})


--Register Incranium Ore
minetest.register_ore({
  ore_type = "blob",
  ore = microexpansion:incranium",
  wherein = "default:stone",
  clust_scarcity = 4*4*4,
  clust_num_ores = 4,
  clust_size = 3,
  y_min = -300,
  y_max = -90,
  --Oregen is very work in progress, and can & will be changed without prior warning
})


--"Supernatet", pronounced "Super-nat-et" is Latin for "float", this ore will float up if there are no blocks above it, so be careful!
--Supernatet ore will be used to craft wings of flight
minetest.register_node(microexpansion:incranium", {
  description = "Supernatant Ore",
  tiles = Supernatet_ore.png" },
  is_ground_content = true,
  drop = microexpansion:incranium",
  groups = { cracky=3, stone=1 },
})



minetest.register_ore({
  ore_type = "blob",
  ore = microexpansion:supernatet_ore",
  wherein = "default:stone",
  clust_scarcity = 4*4*4,
  clust_num_ores = 4,
  clust_size = 3,
  y_min = -300,
  y_max = -90,
  --Oregen is very work in progress, and can & will be changed without prior warning
})
