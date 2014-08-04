--[[
PLASMASCREEN
============
Adding a plasma screen TV for Minetest.
This adds a 2x3 plasma screen TV consisting of 6 nodeboxes.
Code and textures are WTFPL. by qwrwed
]]--

local tv_list = {
	{ "1", {-0.5000, -0.5000, 0.4375, 0.5000, 0.5000, 0.5000}, {-0.5000, 0.5000, 0.3750, 0.5000, 0.3125, 0.4375}, {-0.5000, -0.5000, 0.5000, -0.3125, 0.5000, 0.3750} },
	{ "2", {-0.5000, -0.5000, 0.4375, 0.5000, 0.5000, 0.5000}, {-0.5000, 0.5000, 0.3750, 0.5000, 0.3125, 0.4375}, { 0, 0, 0, 0, 0, 0 } },	
	{ "3", {-0.5000, -0.5000, 0.4375, 0.5000, 0.5000, 0.5000}, {-0.5000, 0.5000, 0.3750, 0.5000, 0.3125, 0.4375}, {0.3125, -0.5000, 0.5000, 0.5000, 0.5000, 0.3750} },
	{ "4", {-0.5000, -0.3125, 0.4375, 0.5000, 0.5000, 0.5000}, {-0.5000, -0.3125, 0.3750, 0.5000, -0.1250, 0.4375}, {-0.5000, -0.3125, 0.5000, -0.3125, 0.5000, 0.3750} },
	{ "6", {-0.5000, -0.3125, 0.4375, 0.5000, 0.5000, 0.5000}, {-0.5000, -0.3125, 0.3750, 0.5000, -0.1250, 0.4375}, {0.3125, -0.3125, 0.5000, 0.5000, 0.5000, 0.3750} },
}

minetest.register_node("default:tv_stand", {
	description = "Plasma Screen TV Stand",
	tiles = {"plasmascreen_back.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { 
			{0.5000,-0.5000,0.0625,-0.5000,-0.4375,-0.5000},
			{-0.1875,-0.5000,-0.3750,0.1875,0.1250,-0.1250},
			{-0.5000,-0.2500,-0.5000,0.5000,0.5000,-0.3750},
			{-0.3750,-0.1875,-0.3750,0.3750,0.3125,-0.2500},
		}
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
})

for i in ipairs(tv_list) do
	local number = tv_list[i][1]
	local n_box1 = tv_list[i][2]
	local n_box2 = tv_list[i][3]
	local n_box3 = tv_list[i][4]
	
	minetest.register_node("default:plasma_tv_"..number, {
		description = "Plasma Screen",
		tiles = {
			"plasmascreen_back.png",
			"plasmascreen_back.png",
			"plasmascreen_back.png",
			"plasmascreen_back.png",
			"plasmascreen_back.png",
			"plasmascreen_screen"..number..".png",
		},
		paramtype = "light",
		paramtype2 = "facedir",
		pointable = false,
		drop = "",
		drawtype = "nodebox",
		node_box = {
				type = "fixed",
				fixed = {n_box1, 
					 n_box2,
					 n_box3,} },
		groups = {dig_immediate=1,not_in_creative_inventory=1},
	})
end

minetest.register_craft({
	output = "default:plasma_tv",
	recipe = {
		{'group:glass',         'default:dye_black',             'group:glass'},
		{'default:steel_ingot', 'default:mese_crystal_fragment', 'default:steel_ingot'},
		{'group:glass',         'group:glass',                   'group:glass'},
	}
})

minetest.register_craft({
	output = "default:tv_stand",
	recipe = {
		{'',                         '',                         ''},
		{'default:plastic_sheeting', 'default:plastic_sheeting', 'default:dye_black'},
		{'default:steel_ingot',      'default:steel_ingot',      ''},
	}
})

minetest.register_node("default:plasma_tv", {
	description = "Plasma TV",
	tiles = {
		"plasmascreen_back.png",
		"plasmascreen_back.png",
		"plasmascreen_back.png",
		"plasmascreen_back.png",
		"plasmascreen_back.png",
		"plasmascreen_screen5.png",

	},
	inventory_image = "plasmascreen_tv_inv.png",
	wield_image = "plasmascreen_tv_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5000, -0.3125, 0.4375, 0.5000, 0.5000, 0.5000},
			{-0.5000, -0.3125, 0.3750, 0.5000, -0.1250, 0.4375},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-1.5050, -0.3125, 0.3700, 1.5050, 1.5050, 0.5050}
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
	    
after_place_node = function(pos,placer,itemstack)
	local param2 = minetest.get_node(pos).param2
	local p = {x=pos.x, y=pos.y, z=pos.z}
		if param2 == 0 then
			pos.x = pos.x-1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_4", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.x = pos.x+2
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_6", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.y = pos.y+1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_3", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.x = pos.x-1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_2", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.x = pos.x-1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_1", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
		elseif param2 == 1 then
			pos.z = pos.z+1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
        minetest.set_node(pos,{name="default:plasma_tv_4", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.z = pos.z-2
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_6", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.y = pos.y+1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_3", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.z = pos.z+1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_2", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.z = pos.z+1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_1", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
		elseif param2 == 2 then
			pos.x = pos.x+1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
        minetest.set_node(pos,{name="default:plasma_tv_4", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.x = pos.x-2
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_6", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.y = pos.y+1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_3", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.x = pos.x+1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_2", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.x = pos.x+1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_1", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
		elseif param2 == 3 then
			pos.z = pos.z-1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
        minetest.set_node(pos,{name="default:plasma_tv_4", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.z = pos.z+2
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_6", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.y = pos.y+1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_3", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.z = pos.z-1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_2", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
			pos.z = pos.z-1
		if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="default:plasma_tv_1", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.env:remove_node(p)
			return true
		end
		end
	end,
		
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if oldnode.param2 == 0 then
			pos.x = pos.x-1
		minetest.remove_node(pos)
			pos.x = pos.x+2
		minetest.remove_node(pos)
			pos.y = pos.y+1
		minetest.remove_node(pos)
			pos.x = pos.x-1
		minetest.remove_node(pos)
			pos.x = pos.x-1
		minetest.remove_node(pos)
		elseif oldnode.param2 == 1 then
			pos.z = pos.z+1
        minetest.remove_node(pos)
			pos.z = pos.z-2
		minetest.remove_node(pos)
			pos.y = pos.y+1
		minetest.remove_node(pos)
			pos.z = pos.z+1
		minetest.remove_node(pos)
			pos.z = pos.z+1
		minetest.remove_node(pos)
		elseif oldnode.param2 == 2 then
			pos.x = pos.x+1
        minetest.remove_node(pos)
			pos.x = pos.x-2
		minetest.remove_node(pos)
			pos.y = pos.y+1
		minetest.remove_node(pos)
			pos.x = pos.x+1
		minetest.remove_node(pos)
			pos.x = pos.x+1
		minetest.remove_node(pos)
		elseif oldnode.param2 == 3 then
			pos.z = pos.z-1
        minetest.remove_node(pos)
			pos.z = pos.z+2
		minetest.remove_node(pos)
			pos.y = pos.y+1
		minetest.remove_node(pos)
			pos.z = pos.z-1
		minetest.remove_node(pos)
			pos.z = pos.z-1
		minetest.remove_node(pos)
		end
	end
})