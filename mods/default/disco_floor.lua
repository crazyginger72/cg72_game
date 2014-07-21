
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
})
