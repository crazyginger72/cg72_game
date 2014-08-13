
-- This file supplies dance floor

minetest.register_node("default:dance_floor", {
	description = "Dance floor",
	drawtype = "nodebox",
	tiles = {
		{name="dance_floor_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	paramtype = "light",
	light_source = 11,
	walkable = false,
	buildable_to = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.49, -0.5, 0.5, -0.5, 0.5},
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.49, -0.5, 0.5, -0.5, 0.5},
			},
		},

	after_place_node = function(pos, placer, itemstack)
		local x = pos.x
		local z = pos.z
		if x % 2 == 0 and z % 2 ~= 0 then 
			minetest.set_node(pos, "default:dance_floor2")
		end
	end








})

minetest.register_node("default:dance_floor2", {
	drawtype = "nodebox",
	tiles = {
		{name="dance_floor_animated2.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	paramtype = "light",
	light_source = 11,
	walkable = false,
	buildable_to = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.49, -0.5, 0.5, -0.5, 0.5},
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.49, -0.5, 0.5, -0.5, 0.5},
			},
		},
})