-- power/ctrl.lua

local me = microexpansion

-- [register node] Controller
me.register_node("ctrl", {
	description = "Power Controller",
	tiles = {
		"ctrl_sides",
		"ctrl_bottom",
		"ctrl_sides",
		"ctrl_sides",
		"ctrl_sides",
		"ctrl_sides"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.375, -0.375, 0.375, 0.375, 0.375}, -- Core
			{0.1875, -0.5, -0.5, 0.5, 0.5, -0.1875}, -- Corner1
			{-0.5, -0.5, -0.5, -0.1875, 0.5, -0.1875}, -- Corner2
			{-0.5, -0.5, 0.1875, -0.1875, 0.5, 0.5}, -- Corner3
			{0.1875, -0.5, 0.1875, 0.5, 0.5, 0.5}, -- Corner4
			{-0.5, -0.4375, -0.5, 0.5, -0.1875, 0.5}, -- Bottom
			{-0.5, 0.1875, -0.5, 0.5, 0.5, -0.1875}, -- Top1
			{0.1875, 0.1875, -0.5, 0.5, 0.5, 0.5}, -- Top2
			{-0.5, 0.1875, -0.5, -0.1875, 0.5, 0.5}, -- Top3
			{-0.5, 0.1875, 0.1875, 0.5, 0.5, 0.5}, -- Top4
			{-0.1875, -0.5, -0.1875, 0.1875, -0.25, 0.1875}, -- Bottom2
		},
	},
	groups = { cracky = 1, me_connect = 1, },
	connect_sides = "nobottom",
	status = "unstable",

	after_place_node = function(pos, player)
		local name = player:get_player_name()
		local meta = minetest.get_meta(pos)
		local id   = power.new_id()

		meta:set_string("infotext", "Network Controller (owned by "..name..")"
			.."\nNetwork ID: "..id)
		meta:set_string("network_id", id)
		meta:set_string("owner", name)

		-- Initialize other meta
		meta:set_int("input", 0)
		meta:set_int("output", 0)
		meta:set_int("storage", 0)

		me.networks[id] = pos

		-- Trace Network
		power.trace(pos)
	end,
	on_destruct = function(pos, player)
		local meta = minetest.get_meta(pos)
		local id   = meta:get_string("network_id")
		me.networks[id] = nil

		-- Remove unit from network
		me.network_remove(pos)
		-- Trace/clear network
		power.trace(pos)
	end,
	machine = {
		type = "transporter",
	},
})

-- [register node] Cable
me.register_machine("cable", {
	description = "ME Cable",
	tiles = {
		"cable",
	},
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed          = {-0.25, -0.25, -0.25, 0.25,  0.25, 0.25},
		connect_top    = {-0.25, -0.25, -0.25, 0.25,  0.5,  0.25}, -- y+
		connect_bottom = {-0.25, -0.5,  -0.25, 0.25,  0.25, 0.25}, -- y-
		connect_front  = {-0.25, -0.25, -0.5,  0.25,  0.25, 0.25}, -- z-
		connect_back   = {-0.25, -0.25,  0.25, 0.25,  0.25, 0.5 }, -- z+
		connect_left   = {-0.5,  -0.25, -0.25, 0.25,  0.25, 0.25}, -- x-
		connect_right  = {-0.25, -0.25, -0.25, 0.5,   0.25, 0.25}, -- x+
	},
	paramtype = "light",
	groups = { crumbly = 1, },
	status = "unstable",
	machine = {
		type = "transporter",
	},
})
