-- cg72 0.4.XX mod: default
-- See README.txt for licensing and other information.

minetest.register_privilege("admin","Your the shit now son :D")

-- The API documentation in here was moved into doc/lua_api.txt

mud_ALPHA = 255
mud_VISC = 7
WATER_ALPHA = 160
WATER_VISC = 1
LAVA_VISC = 7
LIGHT_MAX = 14

-- Definitions made by this mod that other mods can use too
default = {}

-- Load files
dofile(minetest.get_modpath("default").."/areas.lua")
dofile(minetest.get_modpath("default").."/b_hammer.lua")
dofile(minetest.get_modpath("default").."/b_names.lua")
dofile(minetest.get_modpath("default").."/beds.lua")
dofile(minetest.get_modpath("default").."/bucket.lua")
dofile(minetest.get_modpath("default").."/campfire.lua")
dofile(minetest.get_modpath("default").."/coloured_glass.lua")
--dofile(minetest.get_modpath("default").."/compass.lua") --not compatablie with my game 100% yet
dofile(minetest.get_modpath("default").."/crafting.lua")
dofile(minetest.get_modpath("default").."/craftitems.lua")
dofile(minetest.get_modpath("default").."/creative.lua")
dofile(minetest.get_modpath("default").."/death_msg.lua")
dofile(minetest.get_modpath("default").."/disco_ball.lua")
dofile(minetest.get_modpath("default").."/disco_floor.lua")
dofile(minetest.get_modpath("default").."/doors.lua")
dofile(minetest.get_modpath("default").."/dye.lua")
dofile(minetest.get_modpath("default").."/extlegacy.lua")
dofile(minetest.get_modpath("default").."/extranodes.lua")
dofile(minetest.get_modpath("default").."/f_ban.lua")
dofile(minetest.get_modpath("default").."/farming.lua")
dofile(minetest.get_modpath("default").."/fire.lua")
dofile(minetest.get_modpath("default").."/flowergen.lua")
dofile(minetest.get_modpath("default").."/flowers.lua")
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/gender.lua")
dofile(minetest.get_modpath("default").."/give.lua")
dofile(minetest.get_modpath("default").."/glasses.lua")
dofile(minetest.get_modpath("default").."/homedecor.lua")
dofile(minetest.get_modpath("default").."/inbox.lua")
dofile(minetest.get_modpath("default").."/item_drop.lua") --updated to item_tweak code
dofile(minetest.get_modpath("default").."/legacymt.lua")
dofile(minetest.get_modpath("default").."/markers.lua")
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/misc.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/plastic.lua")
dofile(minetest.get_modpath("default").."/plastic_box.lua")
dofile(minetest.get_modpath("default").."/player.lua")
dofile(minetest.get_modpath("default").."/replacer.lua")
dofile(minetest.get_modpath("default").."/rum.lua")
dofile(minetest.get_modpath("default").."/screwdriver.lua")
dofile(minetest.get_modpath("default").."/selahserver.lua")
dofile(minetest.get_modpath("default").."/sethome.lua")
dofile(minetest.get_modpath("default").."/signs.lua")
dofile(minetest.get_modpath("default").."/stairs.lua")
dofile(minetest.get_modpath("default").."/sofa.lua")
dofile(minetest.get_modpath("default").."/spawn.lua")
dofile(minetest.get_modpath("default").."/time_lag.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/tpr.lua")
dofile(minetest.get_modpath("default").."/trees.lua")
dofile(minetest.get_modpath("default").."/tv.lua")
dofile(minetest.get_modpath("default").."/unified_inventory.lua")
dofile(minetest.get_modpath("default").."/vessels.lua")
dofile(minetest.get_modpath("default").."/wool.lua")
dofile(minetest.get_modpath("default").."/worldedit.lua")
dofile(minetest.get_modpath("default").."/writing.lua")
dofile(minetest.get_modpath("default").."/xban.lua")


----------------------------------------------------------
----------------------------------------------------------
------------------------Admin tools-----------------------
------alias-----------------------------------------------
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
	description = "Permanent Fire",
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
	description = "Infinite Fuel",
	inventory_image = "maptools_infinitefuel.png",
})

minetest.register_node("default:superapple", {
	description = "Super Apple",
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
	description = "Admin Pickaxe",
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
	description = "Admin Pickaxe With Drops",
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

--------------------------------------------------------
------admin pick function-------------------------------
--------------------------------------------------------

minetest.register_on_punchnode(function(pos, node, puncher)
	local plname = puncher:get_player_name()
    local privs = minetest.get_player_privs(plname)
    --[[if not privs.admin then
        minetest.chat_send_player(plname, "Your not an admin!!!!!")
        minetest.log("action", puncher:get_player_name().." tried to use admin pick @"..minetest.pos_to_string(pos))
    	return
    end]]

	if puncher:get_wielded_item():get_name() == "default:pick_admin" or puncher:get_wielded_item():get_name() == "default:pick_admin_with_drops"
	and minetest.env: get_node(pos).name ~= "air" then
		if not privs.admin then
       		minetest.chat_send_player(plname, "Your not an admin!!!!!")
       		minetest.chat_send_player(plname, "I said your not an admin damin it!!!!!")
       		minetest.chat_send_player(plname, "Trash this pick right now!!!!!")
       		minetest.chat_send_player(plname, "Your getting banned!!!!!")
       		--xban.ban_player(plname, "SERVER", nil, "Unauthorized use of an admin pick!!!")
        	minetest.log("action", "[WARNING]"..puncher:get_player_name().." tried to use admin pick @"..minetest.pos_to_string(pos).."and was banned!")
    		return
    	end
		if puncher:get_wielded_item():get_name() == "default:pick_admin" then
			minetest.env:remove_node(pos)
			minetest.log("action", puncher:get_player_name().." used admin-pick to dig block @"..minetest.pos_to_string(pos))
		else
		minetest.log("action", puncher:get_player_name().." used admin-pick to dig block @"..minetest.pos_to_string(pos))
		end
	end
end)


