-- ctrl.lua
--[[
WARNING: this is the MAIN power controller, be very careful when making changed.
]]

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
  groups = { cracky = 1 },
  status = "no",
})
