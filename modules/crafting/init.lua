minetest.register_craftitem("microexpansion:obsidian_steel_ingot", {
	description = "Steel infused obsidian",
	inventory_image = "infused_obsidian.png"
})

minetest.register_craft({
	output = "microexpansion:obsidian_steel_ingot 1",
	recipe = {
		{"default:stone", "", ""},
		{"", "", ""},
		{"", "",  ""}
	}
})
