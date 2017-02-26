--ME Steel Infused Obsidian Ingot
minetest.register_craftitem("microexpansion:steel_infused_obsidian_ingot", {
	description = "Steel Infused Obsidian Ingot",
	inventory_image = "infused_obsidian_ingot.png"
})

minetest.register_craft({
	type = "shapeless",
	output = "microexpansion:steel_infused_obsidian_ingot",
	recipe = {"default:steel_ingot", "default:obsidian_shard", "default:steel_ingot"}
})

minetest.register_craftitem("microexpansion:machine_casing", {
	description = "ME Machine Casing",
	inventory_image = "machine_casing.png"
})


--ME Machine Casing
minetest.register_craftitem("microexpansion:machine_casing", {
	description = "machine_casing",
	inventory_image = "machine_casing.png"
})

minetest.register_craft({
	output = "microexpansion:machine_casing",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:copper_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})
