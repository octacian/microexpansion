-- microexpansion/api.lua
local BASENAME = "microexpansion"

-- [function] Register Recipe
function microexpansion.register_recipe(output, recipe)
	-- Check if disabled
	if recipe.disabled == true then
		return
	end

	local function isint(n)
		return n==math.floor(n)
	end

	local function get_amount(_)
		if isint(recipe[_][1]) then
			return recipe[_][1]
		else return 1 end
	end

	local function get_type(_)
		if type(recipe[_][2]) == "string" then
			return recipe[_][2]
		end
	end

	local function register(_)
		local def = {
			type   = get_type(_),
			output = output.." "..tostring(get_amount(_)),
			recipe = recipe[_][3] or recipe[_][2]
		}
		minetest.register_craft(def)
	end

	for _, i in ipairs(recipe) do
		-- Check if disabled
		if recipe.disabled == true then
			return
		end

		register(_)
	end
end

-- [function] Register oredef
function microexpansion.register_oredef(ore, def)
	-- Check if disabled
	if def.disabled == true then
		return
	end

	local function register(_)
		local def = def[_]
		def.ore = "microexpansion:"..ore
		minetest.register_ore(def)
	end

	for _, i in ipairs(def) do
		-- Check if disabled
		if def.disabled == true then
			return
		end

		register(_)
	end
end

-- [local function] Choose description colour
local function desc_colour(status, desc)
	if status == "unstable" then
		return minetest.colorize("orange", desc)
	elseif status == "no" then
		return minetest.colorize("red", desc)
	else
		return minetest.colorize("white", desc)
	end
end

-- [function] Register Item
function microexpansion.register_item(itemstring, def)
	-- Check if disabled
	if def.disabled == true then
		return
	end
	-- Set usedfor
	if def.usedfor then
		def.description = def.description .. "\n"..minetest.colorize("grey", def.usedfor)
	end
	-- Update inventory image
	if def.inventory_image then
		def.inventory_image = BASENAME.."_"..def.inventory_image..".png"
	else
		def.inventory_image = BASENAME.."_"..itemstring..".png"
	end
	-- Colour description
	def.description = desc_colour(def.status, def.description)

	-- Register craftitem
	minetest.register_craftitem(BASENAME..":"..itemstring, def)

	-- if recipe, Register recipe
	if def.recipe then
		microexpansion.register_recipe(BASENAME..":"..itemstring, def.recipe)
	end
end

-- [function] Register Node
function microexpansion.register_node(itemstring, def)
	-- Check if disabled
	if def.disabled == true then
		return
	end
	-- Set usedfor
	if def.usedfor then
		def.description = def.description .. "\n"..minetest.colorize("grey", def.usedfor)
	end
	-- Update texture
	if auto_complete ~= false then
		for _,i in ipairs(def.tiles) do
			if #def.tiles[_]:split("^") <= 1 then
				local prefix = ""
				if def.type == "ore" then
					prefix = "ore_"
				end

				def.tiles[_] = BASENAME.."_"..prefix..i..".png"
			end
		end
	end
	-- Colour description
	def.description = desc_colour(def.status, def.description)
	-- Update connect_sides
	if def.connect_sides == "nobottom" then
		def.connect_sides = { "top", "front", "left", "back", "right" }
	elseif def.connect_sides == "machine" then
		def.connect_sides = { "top", "bottom", "left", "back", "right" }
	end

	-- Register node
	minetest.register_node(BASENAME..":"..itemstring, def)

	-- if recipe, Register recipe
	if def.recipe then
		microexpansion.register_recipe(BASENAME..":"..itemstring, def.recipe)
	end

	-- if oredef, Register oredef
	if def.oredef then
		microexpansion.register_oredef(BASENAME..":"..itemstring, def.oredef)
	end
end
