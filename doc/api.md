# Core API
The core API is composed of several functions to make registering new items, nodes, and recipes for items and nodes more efficient and intuitive. Code for this public API is in `./api.lua`. This documentation is divided up per function.

__Note:__ Any definition table for registering anything using the ME API allow a `disabled` property to be specified. If set to `false`, the node/item will not be registered, if not set, it will.

#### `register_recipe(output, def)`
__Usage:__ `microexpansion.register_recipe(<output (string)>, <recipe (table)>)`

Though this may seem rather complex to understand, this is a very useful timesaving function when registering recipes. It allows registering multiple recipes at once in one table. The output must always remain the same as is specified as the first parameter, while the second parameter should be a table structured like the table below.

__Example:__
```lua
microexpansion.register_recipe("default:steelblock", {
  { 1, {
      { "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
      { "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
      { "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
    },
  },
  { 1, "shapeless", {
      "default:steel_ingot", "default:obsidian_shard", "default:steel_ingot",
    },
  },
})
```

The above registers a two recipes for the item specified. The `1` specifies the output quantity. `shapeless` causes the second recipe to be of the `shapeless` type. After the first one or two definitions (amount, type), the recipe can be specified as normal inside another sub-table. You can have as many recipe sub-tables as you want.

#### `register_oredef(ore, def)`
__Usage:__ `microexpansion.register_oredef(<ore itemstring (string)>, <definition (table)>`

This custom API allows registering multiple ore definitions for a single node in one table. The table structure is quite simple, each definition is placed in an annonymous table in which the normal ore definitions are placed (excluding the ore itemstring). See below for a basic example.

```lua
microexpansion.register_oredef("microexpansion:incranium", {
  {
    ore_type = "blob",
    wherein = "default:stone",
    clust_scarcity = 4*4*4,
    clust_num_ores = 4,
    clust_size = 3,
    y_min = -300,
    y_max = -90,
  },
  ...
})
```

See the [wiki documentation](http://dev.minetest.net/minetest.register_ore) for more information about the accepted or parameters.

#### `register_item(itemstring, def)`
__Usage:__ `microexpansion.register_item(<itemstring (string)>, <item definition (table)>`

This API function accepts the same parameters in the definition table as does `minetest.register_craftitem`, however, it makes several modifications to the parameters before passing them on. A new parameter, `usedfor`, is introduced, which if provided is appened on a new line in grey to the item description, a good way to specify what the item does or include more information about it. The `inventory_image` parameter is modified to enforce the naming style adding `microexpansion_` to the beginning of the specified path, and `.png` to the end. If not `inventory_image` is provided, the itemstring is used and then undergoes the above modification. This allows shortening and even removing the `inventory_image` code, while passing everything else (aside from `usedfor`) on to `minetest.register_craftitem`. One final extra parameter is `status`, which if set to `no` the description is red, if set to `unstable` the description is `orange`, and if anything else the description is red. The recipe can be automatically registered and defined right in the item definition with the `recipe` table. See `microexpansion.register_recipe` for more information.

#### `register_node(itemstring, def)`
__Usage:__ `microexpansion.register_node(<itemstring (string)>, <item definition (table)>`

This API function accepts the same parameters in the definition table as does `minetest.register_craftitem`, however, it makes several modifications to the parameters before passing them on. A new parameter, `usedfor`, is introduced, which if provided is appened on a new line in grey to the item description, a good way to specify what the item does or include more information about it. The `tiles` table is modified so as to simplify the definition when registering the node. Each texture in the `tiles` table has `microexpansion_` added to the beginning and `.png` to the end. This means that rather than specifying something like `microexpansion_chest_top.png`, only `chest_top` is required. __Note:__ the texture path "autocomplete" functionality can be disabled by settings `auto_complete` to `false` in the definition (useful if using textures from another mod). One final extra parameter is `status`, which if set to `no` the description is red, if set to `unstable` the description is `orange`, and if anything else the description is red. The recipe can be automatically registered and defined right in the item definition with the `recipe` table. See `microexpansion.register_recipe` for more information. You can also automatically register ore definitions for the current node with `microexpansion.register_oredef`.