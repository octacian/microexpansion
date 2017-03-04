-- tools/xtremo.lua

-- [register tool] Pickaxe
minetest.register_tool("microexpansion:xtremo_pickaxe", {
  description = "In Xtremo Pickaxe",
  inventory_image = "microexpansion_in_xtremo_pickaxe.png",
  tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.90, [2]=0.90, [3]=0.40}, uses=300, maxlevel=4},
		},
		damage_groups = {fleshy=5},
	},
})

-- [register tool] Axe
minetest.register_tool("microexpansion:xtremo_axe", {
  description = "In Xtremo Axe",
  inventory_image = "microexpansion_in_xtremo_axe.png",
  tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			choppy={times={[1]=2.00, [2]=0.80, [3]=0.40}, uses=300, maxlevel=4},
		},
		damage_groups = {fleshy=7},
	},
})
