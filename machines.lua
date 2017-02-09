-- microexpansion/machines.lua

local function chest_formspec(start_id, listname, page_max, query)
	local list
	local page_number = ""
	local query = query or ""
	if not listname then
		list = "label[3,2;" .. minetest.colorize("red", "No cell!") .. "]"
	else
		list = "list[current_name;" .. listname .. ";0,0.3;8,4;" .. (start_id - 1) .. "]"
	end
	if page_max then
		page_number = "label[6.05,4.5;" .. math.floor((start_id / 32)) + 1 ..
			"/" .. page_max .."]"
	end
	return "size[9,10]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	list ..
	"list[current_name;cells;8,1.8;1,1;]" ..
	"list[current_player;main;0,5.5;8,1;]" ..
	"list[current_player;main;0,6.73;8,3;8]" ..
	"button[5.4,4.35;0.8,0.9;prev;<]" ..
	"button[7.25,4.35;0.8,0.9;next;>]" ..
	"field[0.3,4.6;2.2,1;filter;;" .. query .. "]" ..
	"button[2.1,4.5;0.8,0.5;search;?]" ..
	"button[2.75,4.5;0.8,0.5;clear;X]" ..
	"tooltip[search;Search]" ..
	"tooltip[clear;Reset]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	"field_close_on_enter[filter;false]" ..
	page_number ..
	default.get_hotbar_bg(0,5.50)
end

-- ME chest
minetest.register_node("microexpansion:cell_accces", {
	description = "ME Cell Access\nCan interact with ME storage cells",
	tiles = {
		"microexpansion_cell_access_top.png",
		"microexpansion_cell_access_top.png",
		"microexpansion_cell_access_side.png",
		"microexpansion_cell_access_side.png",
		"microexpansion_cell_access_side.png",
		"microexpansion_cell_access_front.png",
	},
	is_ground_content = false,
	groups = { cracky = 1 },
	paramtype = "light",
	paramtype2 = "facedir",

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", chest_formspec(1))
		meta:set_string("inv_name", "none")
		meta:set_int("page", 1)
		local inv = meta:get_inventory()
		inv:set_size("cells", 1)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname == "main" then
			return stack:get_count()
		elseif listname == "cells" then
			if minetest.get_item_group(stack:get_name(), "microexpansion_cell") ~= 0 then
				return 1
			else
				return 0
			end
		else
			return 0
		end
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname == "main" then
			local inv = minetest.get_meta(pos):get_inventory()
			inv:remove_item(listname, stack)
			inv:add_item(listname, stack)
		elseif listname == "cells" then
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local items = minetest.deserialize(stack:get_meta():get_string("items"))
			local size = microexpansion.get_cell_size(stack:get_name())
			local page_max = math.floor(size / 32) + 1
			inv:set_size("main", size)
			if items then
				inv:set_list("main", items)
			end
			meta:set_string("inv_name", "main")
			meta:set_string("formspec", chest_formspec(1, "main", page_max))
		end
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local inv = minetest.get_meta(pos):get_inventory()
		if listname == "search" then
			inv:remove_item("main", stack)
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if listname == "cells" then
			local t = minetest.get_us_time()
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local tab = {}
			local new_stack = inv:get_stack(listname, 1)
			local item_meta = new_stack:get_meta()
			for i = 1, inv:get_size("main") do
				if inv:get_stack("main", i):get_name() ~= "" then
					tab[#tab + 1] = inv:get_stack("main", i):to_string()
				end
			end
			item_meta:set_string("items", minetest.serialize(tab))
			inv:set_stack(listname, 1, new_stack)
			inv:set_size("main", 0)
			meta:set_int("page", 1)
			meta:set_string("formspec", chest_formspec(1))
			return new_stack:get_count()
		end
		return stack:get_count()
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		local page = meta:get_int("page")
		local inv_name = meta:get_string("inv_name")
		local inv = meta:get_inventory()
		local page_max = math.floor(inv:get_size("main") / 32) + 1
		local cell_stack = inv:get_stack("cells", 1)
		if inv_name == "none" then
			return
		end
		if fields.next then
			if page + 32 > inv:get_size(inv_name) then
				return
			end
			meta:set_int("page", page + 32)
			meta:set_string("formspec", chest_formspec(page + 32, inv_name, page_max))
		elseif fields.prev then
			if page - 32 < 1 then
				return
			end
			meta:set_int("page", page - 32)
			meta:set_string("formspec", chest_formspec(page - 32, inv_name, page_max))
		elseif fields.search or fields.key_enter_field == "filter" then
			inv:set_size("search", 0)
			if fields.filter == "" then
				meta:set_int("page", 1)
				meta:set_string("inv_name", "main")
				meta:set_string("formspec", chest_formspec(1, "main", page_max))
			else
				local tab = {}
				for i = 1, microexpansion.get_cell_size(cell_stack:get_name()) do
					local match = inv:get_stack("main", i):get_name():find(fields.filter)
					if match then
						tab[#tab + 1] = inv:get_stack("main", i)
					end
				end
				inv:set_list("search", tab)
				meta:set_int("page", 1)
				meta:set_string("inv_name", "search")
				meta:set_string("formspec", chest_formspec(1, "search", page_max, fields.filter))
			end
		elseif fields.clear then
			inv:set_size("search", 0)
			meta:set_int("page", 1)
			meta:set_string("inv_name", "main")
			meta:set_string("formspec", chest_formspec(1, "main", page_max))
		end
	end,
})
