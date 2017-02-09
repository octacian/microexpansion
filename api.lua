-- microexpansion/api.lua
local BASENAME = "microexpansion"

-- [local function] register recipe
local function register_recipe(output, recipe)
  local function isint(n)
    return n==math.floor(n)
  end

  local function getAmount()
    if isint(recipe[2][1]) then
      local q = recipe[2][1]
      recipe[2][1] = nil
      return q
    else return 1 end
  end

  local function register(amount, recipe)
    minetest.register_craft({
      output = output.." "..amount,
      recipe = recipe,
    })
  end

  local function single()
    register(getAmount(), recipe[2])
  end

  local function multiple()
    for i, item in ipairs(recipe) do
      if i == 0 then return end
      register(getAmount(), recipe[i])
    end
  end

  -- check type
  if recipe[1] == "single" then single()
  elseif recipe[1] == "multiple" then multiple()
  else return microexpansion.log("invalid recipe for definition "..output..". "..dump(recipe[2])) end
end

-- [function] register item
function microexpansion.register_item(itemstring, def)
  -- usedfor
  if def.usedfor then
    def.description = def.description .. "\nfor " .. def.usedfor
  end

  -- register craftitem
  minetest.register_craftitem(BASENAME..":"..itemstring, {
    description = def.description,
    inventory_image = BASENAME.."_"..def.inventory_image..".png",
  })

  -- if recipe, register recipe
  if def.recipe then
    register_recipe(BASENAME..":"..itemstring, def.recipe)
  end
end

-- [function] register cell
function microexpansion.register_cell(itemstring, def)
  if not def.inventory_image then
    def.inventory_image = itemstring
  end

  -- register craftitem
  minetest.register_craftitem(BASENAME..":"..itemstring, {
    description = def.description,
    inventory_image = BASENAME.."_"..def.inventory_image..".png",
    microexpansion = {
      drive = {
        capacity = def.capacity or 5000,
      },
    },
  })

  -- if recipe, register recipe
  if def.recipe then
    -- if recipe, register recipe
    if def.recipe then
      register_recipe(BASENAME..":"..itemstring, def.recipe)
    end
  end
end
