local player_in_bed = 0

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
						{-0.5, -0.5, -0.5, 0.5, 0.3125, 1.5},
					}
		},

		after_place_node = function(pos, placer, itemstack)
			local node = minetest.env:get_node(pos)
			local p = {x=pos.x, y=pos.y, z=pos.z}
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
			pos2 = {x=pos.x, y=pos.y-1, z=pos.z}
			if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
				if minetest.get_item_group(pos2, "bed") >= 0 then
					minetest.env:set_node(pos, {name ="default:bed_top_bunk_"..colour})
				else
					minetest.env:set_node(pos, node)
			end
			else
				minetest.env:remove_node(p)
				return true
			end
		end,
			
		on_destruct = function(pos)
			local node = minetest.env:get_node(pos)
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
			if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).name == "default:bed_top_"..colour ) then
				if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
					minetest.env:remove_node(pos)
				end	
			end
		end,
	})
	
	minetest.register_node("default:bed_top_"..colour, {
		drawtype = "nodebox",
		tiles = {"beds_bed_top_top_"..colour..".png", "default_junglewood.png",  "beds_bed_side_top_r_"..colour..".png",  "beds_bed_side_top_l_"..colour..".png",  "beds_bed_top_front.png",  "beds_bed_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
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
		selection_box = {
			type = "fixed",
			fixed = {
						{0, 0, 0, 0, 0, 0},
					}
		},
	})
	
minetest.register_node("default:bed_bottom_bunk_"..colour, {
		drawtype = "nodebox",
		tiles = {"beds_bed_top_bunk_bottom_"..colour..".png", "default_wood.png",  "beds_bed_side_"..colour.."_r.png",  "beds_bed_side_"..colour.."_l.png",  "beds_bed_side_"..colour.."_top.png",  "beds_bed_side_"..colour.."_top.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,bed=1},
		sounds = default.node_sound_wood_defaults(),
		drop = { items = { { items = {'default:bed_bottom'..colour}, }, }, },
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
						{-0.5, -0.5, -0.5, 0.5, 0.3125, 1.5},
					}
		},

		after_place_node = function(pos, placer, itemstack)
			local node = minetest.env:get_node(pos)
			local p = {x=pos.x, y=pos.y, z=pos.z}
			local param2 = node.param2
			node.name = "default:bed_top_bunk"..colour
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to  then
				minetest.env:set_node(pos, node)
			else
				minetest.env:remove_node(p)
				return true
			end
		end,
			
		on_destruct = function(pos)
			local node = minetest.env:get_node(pos)
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
			if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).name == "default:bed_top_bunk_"..colour ) then
				if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
					minetest.env:remove_node(pos)
				end	
			end
		end,
	})
	
	minetest.register_node("default:bed_top_bunk_"..colour, {
		drawtype = "nodebox",
		tiles = {"beds_bed_top_bunk_top_"..colour..".png", "default_junglewood.png",  "beds_bed_side_top_bunk_r_"..colour..".png",  "beds_bed_side_top_bunk_l_"..colour..".png",  "beds_bed_top_bunk_front.png",  "beds_bed_side_"..colour.."_top.png"},
		paramtype = "light",
		paramtype2 = "facedir",
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
		selection_box = {
			type = "fixed",
			fixed = {
						{0, 0, 0, 0, 0, 0},
					}
		},
	})

	minetest.register_alias("bed_"..colour, "default:bed_bottom_"..colour)
	
	minetest.register_craft({
		output = "default:bed_"..colour,
		recipe = {
			{"wool:"..colour, "wool:"..colour, "wool:white", },
			{"default:stick", "", "default:stick", }
		}
	})
	
	minetest.register_craft({
		output = "default:bed_"..colour,
		recipe = {
			{"wool:white", "wool:"..colour, "wool:"..colour, },
			{"default:stick", "", "default:stick", }
		}
	})
	
end

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

minetest.register_node("default:bed_king", {
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
	selection_box = {
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
})

minetest.register_abm({
	nodenames = {"default:sunflower_sprout"},
	neighbors = {"group:soil"},
	interval = 90,
	chance = 3,
	action = function(pos, node)
	local pos1 = {x=pos.x, y=pos.y+1, z=pos.z}
	local pos2 = {x=pos.x, y=pos.y+2, z=pos.z}
		if minetest.get_node_light(pos1) < 12 then
			return
		end
		if minetest.get_node(pos1).name == "air" and minetest.get_node(pos2).name == "air" then
			minetest.add_node(pos, {name ="default:sunflower_b"})
			minetest.add_node(pos1, {name ="default:sunflower_m"})
			minetest.add_node(pos2, {name ="default:sunflower_head"})
		end
	end
})












--local p2 = minetest.get_node(pos).param2
--minetest.swap_node(pos, {name=replace, param2=p2})