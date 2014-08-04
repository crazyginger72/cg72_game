local sofa_list = {
	{ "Red Sofa", "red"},
	{ "Orange Sofa", "orange"},	
	{ "Yellow Sofa", "yellow"},
	{ "Green Sofa", "green"},
	{ "Blue Sofa", "blue"},
	{ "Violet Sofa", "violet"},
	{ "Black Sofa", "black"},
	{ "Grey Sofa", "grey"},
	{ "White Sofa", "white"},
	{ "Magenta Sofa", "magenta"},
}

for i in ipairs(sofa_list) do
	local sofadesc = sofa_list[i][1]
	local colour = sofa_list[i][2]

	minetest.register_node("default:sofa_right_"..colour, {
		description = sofadesc.." Right",
		drawtype = "nodebox",
		tiles = {"lrfurn_sofa_right_top_"..colour..".png", "lrfurn_coffeetable_back.png",  "lrfurn_sofa_right_front_"..colour..".png",  "lrfurn_sofa_back_"..colour..".png",  "lrfurn_sofa_left_side_"..colour..".png",  "lrfurn_sofa_right_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=1},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4375, -0.5, -0.4375, -0.375, -0.375, -0.375},
				{0.375, -0.5, -0.4375, 0.4375, -0.375, -0.375},
				{-0.5, -0.375, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, -0.5, -0.3125, 0.5, 0.5},
				{-0.3125, 0, -0.5, 0.5, 0.25, -0.3125},
			}
		},	
		on_rightclick = function(pos, node, clicker)
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
			clicker:set_hp(20)
		end
	})

	minetest.register_node("default:sofa_middle_"..colour, {
		description = sofadesc.." Middle",
		drawtype = "nodebox",
		tiles = {"lrfurn_longsofa_middle_top_"..colour..".png", "lrfurn_coffeetable_back.png",  "lrfurn_longsofa_middle_front_"..colour..".png",  "lrfurn_sofa_back_"..colour..".png",  "lrfurn_sofa_left_side_"..colour..".png",  "lrfurn_sofa_right_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=1},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4375, -0.5, -0.03125, -0.375, -0.375, 0.03125},
				{0.375, -0.5, -0.03125, 0.4375, -0.375, 0.03125},
				{-0.5, -0.375, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, -0.5, -0.3125, 0.5, 0.5},
			}
		},
		on_rightclick = function(pos, node, clicker)
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
			clicker:set_hp(20)
		end
	})
	
	minetest.register_node("default:sofa_left_"..colour, {
		description = sofadesc.." Left",
		drawtype = "nodebox",
		tiles = {"lrfurn_sofa_left_top_"..colour..".png", "lrfurn_coffeetable_back.png",  "lrfurn_sofa_left_front_"..colour..".png",  "lrfurn_sofa_back_"..colour..".png",  "lrfurn_sofa_left_side_"..colour..".png",  "lrfurn_sofa_right_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=1},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4375, -0.5, 0.375, -0.375, -0.375, 0.4375},
				{0.375, -0.5, 0.375, 0.4375, -0.375, 0.4375},
				{-0.5, -0.375, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, -0.5, -0.3125, 0.5, 0.5},
				{-0.3125, 0, 0.3125, 0.5, 0.25, 0.5},
			}
		},
		on_rightclick = function(pos, node, clicker)
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
			clicker:set_hp(20)
		end
	})

	minetest.register_node("default:sofa_corner_"..colour, {
		description = sofadesc.." Corner",
		drawtype = "nodebox",
		tiles = {"lrfurn_sofa_right_top_"..colour..".png", "lrfurn_coffeetable_back.png",  "lrfurn_sofa_right_front_"..colour..".png",  "lrfurn_sofa_back_"..colour..".png",  "lrfurn_sofa_left_side_"..colour..".png",  "lrfurn_sofa_right_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=1},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4375, -0.5, -0.4375, -0.375, -0.375, -0.375},
				{0.375, -0.5, -0.4375, 0.4375, -0.375, -0.375},
				{-0.5, -0.375, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, -0.5, -0.3125, 0.5, 0.5},
				{-0.3125, 0, -0.5, 0.5, 0.5, -0.3125},
			}
		},	
		on_rightclick = function(pos, node, clicker)
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
			clicker:set_hp(20)
		end
	})
	
	minetest.register_craft({
		output = "default:sofa_right_"..colour,
		recipe = {
			{"default:slab_wool"..colour, "default:wool"..colour, "default:wool"..colour, },
			{"default:slab_wood",         "default:slab_wood",    "default:slab_wood", },
			{"group:stick",               " ",                    "group:stick", }
		}
	})

	minetest.register_craft({
		output = "default:sofa_middle_"..colour,
		recipe = {
			{"default:wool"..colour, "default:wool"..colour, "default:wool"..colour, },
			{"default:slab_wood",    "default:slab_wood",    "default:slab_wood", },
			{"group:stick",          " ",                    "group:stick", }
		}
	})

	minetest.register_craft({
		output = "default:sofa_left_"..colour,
		recipe = {
			{"default:wool"..colour, "default:wool"..colour, "default:slab_wool"..colour, },
			{"default:slab_wood",    "default:slab_wood",    "default:slab_wood", },
			{"group:stick",          " ",                    "group:stick", }
		}
	})

	minetest.register_craft({
		output = 'default:sofa_corner_'..colour..' 2',
		recipe = {
			{"default:sofa_middle_"..colour, "default:sofa_middle_"..colour,  },
	})

end

