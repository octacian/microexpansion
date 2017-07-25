-- power/gen.lua

local me = microexpansion

-- [register node] Fuel Fired Generator
me.register_machine("fuel_fired_generator", {
	description = "Fuel-Fired Generator",
	tiles = {
		"machine_sides",
		"machine_sides",
		"machine_sides",
		"machine_sides",
		"machine_sides",
		"machine_sides",
		"fuelgen_front",
	},
	recipe = {
		{ 1, {
				{ "default:steel_ingot", "default:furnace", "default:steel_ingot" },
				{"default:steel_ingot", "microexpansion:machine_casing", "default:steel_ingot" },
				{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
			},
		}
	},
	groups = { cracky = 1 },
	connect_sides = "machine",
	paramtype2 = "facedir",
	status = "unstable",
	machine = {
		type = "provider",
		on_survey = function(pos)
			return 5 -- Generate 5 ME/tick
		end,
	},
})

-- [register node] Super Smelter
me.register_node("super_smelter", {
	description = "Super Smelter",
	tiles = {
		"machine_sides",
		"machine_sides",
		"machine_sides",
		"machine_sides",
		"machine_sides",
		"super_smelter_front",
	},
	recipe = {
		{ 1, {
				{ "default:furnace", "default:furnace", "default:furnace" },
				{ "default:steel_ingot", "microexpansion:machine_casing", "default:steel_ingot" },
				{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
			},
		},
	},
	groups = { cracky = 1, me_connect = 1, },
	connect_sides = "machine",
	paramtype2 = "facedir",
	status = "unstable",
	machine = {
		type = "consumer",
		on_survey = function(pos)
			return 5 -- Consume 5 ME/tick
		end,
	},
})

-- [register item] Geothermal Generator
me.register_node("geo_generator", {
	description = "Geothermal Generator",
	tiles = {
		"machine_sides",
		"machine_sides",
		"machine_sides",
		"machine_sides",
		"machine_sides",
		"geogen_front",
	},
	groups = { cracky = 1, me_connect = 1, },
	connect_sides = "machine",
	paramtype2 = "facedir",
	status = "unstable",
	machine = {
		type = "provider",
		on_survey = function(pos)
			return 10 -- Generate 10 ME/tick
		end,
	},
})
