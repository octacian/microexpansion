minetest.register_node("microexpansion:builder", {
	description = "Builder/Destroyer",
  tiles = {"texturehere.png"},
  is_ground_content = true,
	groups = {cracky=3, stone=1},
})

minetest.register_craft({
	output = "microexpansion:builder 1",
	recipe = {
		{"default:stone", "obsidian_steel_ingot", "default:stone"},
		{"default:mese_crystal_fragment", "microexpansion:machine_block", "default:mese_crystal_fragment"},
		{"default:obsidian", "microexpansion:mese_energey_cable",  "default:obsidian"}
	}
})
