local beds_list = {
	{ "Red Bed", "red"},
	{ "Orange Bed", "orange"},	
	{ "Yellow Bed", "yellow"},
	{ "Green Bed", "green"},
	{ "Blue Bed", "blue"},
	{ "Violet Bed", "violet"},
	{ "Black Bed", "black"},
	{ "Grey Bed", "grey"},
	{ "White Bed", "white"},
}

for i in ipairs(beds_list) do
	local beddesc = beds_list[i][1]
	local colour = beds_list[i][2]

	minetest.register_node("default:bed_bottom_"..colour, {
		description = beddesc,
		drawtype = "nodebox",
		tiles = {"beds_bed_top_bottom_"..colour..".png", "default_wood.png",  "beds_bed_side_"..colour..".png",  "beds_bed_side_"..colour..".png",  "beds_bed_side_"..colour..".png",  "beds_bed_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,bed=1},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, -0.125, -0.5, 0.5, 0.3125, 0.5},
						
						-- legs
						{-0.5, -0.5, -0.5, -0.375, 0.0, -0.375},
						{0.375, 0.0, -0.375, 0.5, -0.5, -0.5},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, -0.125, -0.5, 0.5, 0.3125, 1.5},
						
						-- legs
						{-0.5, -0.5, -0.5, -0.375, 0.0, -0.375},
						{0.375, 0.0, -0.375, 0.5, -0.5, -0.5},
						{-0.375, 0.0, 1.375, -0.5, -0.5, 1.5},
						{0.5, -0.5, 1.5, 0.375, 0.0, 1.375},
					}
		},
		after_place_node = function(pos, placer, itemstack)
			local node = minetest.get_node(pos)
			local pos2 = {x=pos.x, y=pos.y-1, z=pos.z}
			local param2 = node.param2
			node.name = "default:bed_top_"..colour
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			local pos3 = {x=pos.x, y=pos.y-1, z=pos.z}
			local node2 = minetest.get_node(pos2)
			local node3 = minetest.get_node(pos3)
			if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
				if minetest.get_item_group(node2.name, "bed") > 0 then
					if minetest.get_item_group(node3.name, "bed") > 1 then
						minetest.set_node(pos, node)
					else
						minetest.remove_node(p)
						return true
					end
				else
					minetest.set_node(pos, node)
				end
			else
				minetest.remove_node(p)
				return true
			end
		end,
			
		on_destruct = function(pos)
			local node = minetest.get_node(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "default:bed_top_"..colour ) then
				if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
					minetest.remove_node(pos)
				end	
			end
		end,
		on_leftclick = function(pos, node, clicker)
		local node = minetest.get_node(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+0.5
			elseif param2 == 1 then
				pos.x = pos.x+0.5
			elseif param2 == 2 then
				pos.z = pos.z-.05
			elseif param2 == 3 then
				pos.x = pos.x-0.5
			end
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
			clicker:set_hp(20)
		end
	})
	
	minetest.register_node("default:bed_top_"..colour, {
		drawtype = "nodebox",
		tiles = {"beds_bed_top_top_"..colour..".png", "default_wood.png",  "beds_bed_side_top_r_"..colour..".png",  "beds_bed_side_top_l_"..colour..".png",  "beds_bed_top_front.png",  "beds_bed_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		pointable = false,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,bed=1},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, -0.125, -0.5, 0.5, 0.3125, 0.5},
						{-0.375, 0.3125, 0.1, 0.375, 0.375, 0.5},
						
						-- legs
						{-0.375, 0.0, 0.375, -0.5, -0.5, 0.5},
						{0.5, -0.5, 0.5, 0.375, 0.0, 0.375},
					}
		},
	})
	
	minetest.register_node("default:bed_bottom_bunk_"..colour, {
		drawtype = "nodebox",
		tiles = {"beds_bed_top_bottom_"..colour..".png", "default_wood.png",  "beds_bed_side_"..colour.."_r.png",  "beds_bed_side_"..colour.."_l.png",  "beds_bed_side_"..colour.."_top.png",  "beds_bed_side_"..colour.."_top.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,bed=1},
		sounds = default.node_sound_wood_defaults(),
		drop = { items = { { items = {'default:bed_bottom_'..colour}, }, }, },
		node_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, -0.125, -0.5, 0.5, 0.3125, 0.5},
						
						-- legs
						{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375},
						{0.375, -0.5, -0.375, 0.5, 0.5, -0.5},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, -0.125, -0.5, 0.5, 0.3125, 1.5},
						
						-- legs
						{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375},
						{0.375, 0.5, -0.375, 0.5, -0.5, -0.5},
						{-0.375, 0.5, 1.375, -0.5, -0.5, 1.5},
						{0.5, -0.5, 1.5, 0.375, 0.5, 1.375},
					}
		},	
		on_destruct = function(pos)
			local node = minetest.get_node(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "default:bed_top_bunk_"..colour ) then
				if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
					minetest.remove_node(pos)
				end	
			end
		end,
		on_leftclick = function(pos, node, clicker)
		local node = minetest.get_node(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+0.5
			elseif param2 == 1 then
				pos.x = pos.x+0.5
			elseif param2 == 2 then
				pos.z = pos.z-.05
			elseif param2 == 3 then
				pos.x = pos.x-0.5
			end
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
			clicker:set_hp(20)
		end
	})
	
	minetest.register_node("default:bed_top_bunk_"..colour, {
		drawtype = "nodebox",
		tiles = {"beds_bed_top_top_"..colour..".png", "default_wood.png",  "beds_bed_side_top_bunk_r_"..colour..".png",  "beds_bed_side_top_bunk_l_"..colour..".png",  "beds_bed_top_bunk_front.png",  "beds_bed_side_"..colour.."_top.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		pointable = false,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,bed=1},
		sounds = default.node_sound_wood_defaults(),
		{ items = { { items = {''}, }, }, },
		node_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, -0.125, -0.5, 0.5, 0.3125, 0.5},
						{-0.375, 0.3125, 0.1, 0.375, 0.375, 0.5},
						
						-- legs
						{-0.375, 0.5, 0.375, -0.5, -0.5, 0.5},
						{0.5, -0.5, 0.5, 0.375, 0.5, 0.375},
					}
		},
	})

	minetest.register_alias("bed_"..colour, "default:bed_bottom_"..colour)
	
	minetest.register_craft({
		output = "default:bed_"..colour,
		recipe = {
			{"default:wool"..colour, "defalut:wool"..colour, "default:woolwhite", },
			{"group:stick", "", "group:stick", }
		}
	})
	
	minetest.register_craft({
		output = "default:bed_king_"..colour,
		recipe = {
			{"default:bed_"..colour, "default:bed_"..colour, "default:bed_"..colour, },
		}
	})

--[[minetest.register_node("default:bed_king_bottom_"..colour, {
		description = beddesc,
		drawtype = "nodebox",
		tiles = {"beds_bed_top_bottom_"..colour..".png", "default_wood.png",  "beds_bed_side_"..colour..".png",  "beds_bed_side_"..colour..".png",  "beds_bed_side_"..colour..".png",  "beds_bed_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
						-- bed
						{-0.5, 0.0, -0.5, 0.5, 0.3125, 0.5},
						
						-- legs
						{-0.5, -0.5, -0.5, -0.375, 0.0, -0.375},
						{0.375, 0.0, -0.375, 0.5, -0.5, -0.5},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{-0.5, -0.5, -0.5, 0.5, 0.3125, 1.5},
					}
		},

})
]]--

	minetest.register_node("default:bed_king_"..colour, {
		description = "King size bed",
		tiles = {"bed_t.png","bed_bt.png","bed_s.png","bed_s.png","bed_bt.png","bed_s.png"},
		inventory_image = "bed_king.png",
		weild_image = "bed_king.png",
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = true,
		is_ground_content = true,
		groups = {crumbly=3},
		sounds = default.node_sound_defaults(),
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-1.5, -0.125, -0.5, 1.5, 0.3125, 1.5}, -- NodeBox1
				{-1.5, 0.3125, 1.49999, 1.5, 0.75, 1.5}, -- NodeBox2
				{1.3125, -0.5, -0.5, 1.5, -0.125, -0.3125}, -- NodeBox3
				{-1.5, -0.5, -0.5, -1.3125, -0.125, -0.3125}, -- NodeBox4
				{-1.5, -0.5, 1.3125, -1.3125, -0.125, 1.5}, -- NodeBox5
				{1.3125, -0.5, 1.3125, 1.5, -0.125, 1.5}, -- NodeBox6
				},
			},
		on_leftclick = function(pos, node, clicker)
		local node = minetest.get_node(pos)
			local param2 = node.param2
			node.name = "default:bed_top_"..colour
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
			clicker:set_hp(20)
		end
	})
	
	minetest.register_abm({	
		nodenames = {"default:bed_bottom_"..colour},
		neighbors = {"group:bed"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			local over = {x=pos.x, y=pos.y+1, z=pos.z}
			local here = minetest.get_node(over)
			local p2 = here.param2
			local facedir = minetest.facedir_to_dir(node.param2)
			local toppos = {x=pos.x+facedir.x, y=pos.y, z=pos.z+facedir.z}
			if minetest.get_item_group(here.name, "bed") > 0 then
				minetest.set_node(pos, {name ="default:bed_bottom_bunk_"..colour, param2=p2})
				minetest.set_node(toppos, {name ="default:bed_top_bunk_"..colour, param2=p2})
			end
		end
	})

	minetest.register_abm({	
		nodenames = {"default:bed_bottom_bunk_"..colour},
		neighbors = {"group:bed"},
		interval = 1,
		chance = 1,
		action = function(pos, node)
			local over = {x=pos.x, y=pos.y+1, z=pos.z}
			local node_o = minetest.get_node(over)
			local here = minetest.get_node(pos)
			local p2 = here.param2
			local facedir = minetest.facedir_to_dir(node.param2)
			local toppos = {x=pos.x+facedir.x, y=pos.y, z=pos.z+facedir.z}
			if minetest.get_item_group(node_o.name, "bed") < 1 then
				minetest.set_node(pos, {name ="default:bed_bottom_"..colour, param2 = p2})
				minetest.set_node(toppos, {name ="default:bed_top_"..colour, param2 = p2})
			end
		end
	})
end
