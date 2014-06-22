-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- The API documentation in here was moved into doc/lua_api.txt

WATER_ALPHA = 160
WATER_VISC = 1
LAVA_VISC = 7
LIGHT_MAX = 14

-- Definitions made by this mod that other mods can use too
default = {}

-- Load files
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/craftitems.lua")
dofile(minetest.get_modpath("default").."/crafting.lua")
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/player.lua")
dofile(minetest.get_modpath("default").."/trees.lua")
dofile(minetest.get_modpath("default").."/misc.lua")
dofile(minetest.get_modpath("default").."/time_lag.lua")
dofile(minetest.get_modpath("default").."/gender.lua")
dofile(minetest.get_modpath("default").."/extranodes.lua")
dofile(minetest.get_modpath("default").."/sethome.lua")
dofile(minetest.get_modpath("default").."/inbox.lua")
dofile(minetest.get_modpath("default").."/f_ban.lua")
dofile(minetest.get_modpath("default").."/b_names.lua")
dofile(minetest.get_modpath("default").."/b_hammer.lua")
dofile(minetest.get_modpath("default").."/areas.lua")
dofile(minetest.get_modpath("default").."/beds.lua")
dofile(minetest.get_modpath("default").."/tpr.lua")
dofile(minetest.get_modpath("default").."/trapdoors.lua")




----------------------------------------------------------
----------------------------------------------------------
------------------------Admin tools-----------------------
----------------------------------------------------------
----------------------------------------------------------

minetest.register_alias("adminpick", "default:pick_admin")
minetest.register_alias("adminpickaxe", "default:pick_admin")
minetest.register_alias("admin_pick", "default:pick_admin")
minetest.register_alias("admin_pickaxe", "default:pick_admin")
minetest.register_alias("pick_admin", "default:pick_admin")
minetest.register_alias("pickaxe_admin", "default:pick_admin")
minetest.register_alias("pickadmin", "default:pick_admin")
minetest.register_alias("pickaxeadmin", "default:pick_admin")
minetest.register_alias("adminpickdrops", "default:pick_admin_with_drops")
minetest.register_alias("adminpickaxedrops", "default:pick_admin_with_drops")
minetest.register_alias("admin_pick_drops", "default:pick_admin_with_drops")
minetest.register_alias("admin_pickaxe_drops", "default:pick_admin_with_drops")
minetest.register_alias("pick_admin_drops", "default:pick_admin_with_drops")
minetest.register_alias("pickaxe_admin_drops", "default:pick_admin_with_drops")
minetest.register_alias("pickadmindrops", "default:pick_admin_with_drops")
minetest.register_alias("pickaxeadmindrops", "default:pick_admin_with_drops")
minetest.register_alias("superapple", "default:superapple")
minetest.register_alias("pfire", "default:permanent_fire")
minetest.register_alias("ifuel", "default:infinitefuel")

---------------------------------------------------------
------nodes----------------------------------------------
---------------------------------------------------------

minetest.register_node("default:permanent_fire", {
	description = S("Permanent Fire"),
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {{
		name="fire_basic_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "fire_basic_flame.png",
	light_source = 14,
	groups = {unbreakable=1, not_in_creative_inventory=1},
	drop = '',
	sunlight_propagates = true,
	walkable = false,
	damage_per_second = 4,
})

---------------------------------------------------------
------other----------------------------------------------
---------------------------------------------------------

minetest.register_craftitem("default:infinitefuel", {
	description = S("Infinite Fuel"),
	inventory_image = "maptools_infinitefuel.png",
})

minetest.register_node("default:superapple", {
	description = S("Super Apple"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"maptools_superapple.png"},
	inventory_image = "maptools_superapple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3, dig_immediate=3, not_in_creative_inventory=1},
	on_use = minetest.item_eat(20),
	sounds = default.node_sound_defaults(),
})

---------------------------------------------------------
------tools----------------------------------------------
---------------------------------------------------------

minetest.register_tool("default:pick_admin", {
	description = S("Admin Pickaxe"),
	inventory_image = "maptools_adminpick.png",
	groups = {not_in_creative_inventory=1},
	tool_capabilities = {
		full_punch_interval = 0,
		max_drop_level=3,
		groupcaps= {
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			choppy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			bendy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			cracky={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			crumbly={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			snappy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		}
	},
})

minetest.register_tool("default:pick_admin_with_drops", {
	description = S("Admin Pickaxe With Drops"),
	inventory_image = "maptools_adminpick.png",
	groups = {not_in_creative_inventory=1},
	tool_capabilities = {
		full_punch_interval = 0,
		max_drop_level=3,
		groupcaps= {
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			choppy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			bendy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			cracky={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			crumbly={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			snappy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		}
	},
})

minetest.register_on_punchnode(function(pos, node, puncher)
	if puncher:get_wielded_item():get_name() == "default:pick_admin"
	and minetest.env: get_node(pos).name ~= "air" then
		minetest.env:remove_node(pos)
	end
end)


