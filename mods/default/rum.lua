
-- This file supplies rum

minetest.register_node("default:rum", {
	description = "Rum",
	drawtype = "nodebox",
	tiles = {
		'red_wine_top.png', -- top
		'red_wine_top.png',  -- bottom
		'rum.png',  -- side
		'rum.png',  -- side
		'rum.png',  -- back
		'rum_label.png',  -- front
	},
	paramtype = "light",
	paramtype2 = "facedir",
	buildable_to = true,
	walkable = false,
	use_texture_alpha = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.07, 0.3, -0.07, 0.07, 0.33, 0.07},  -- lip
			{-0.065, 0, -0.065, 0.065, 0.35, 0.065},  -- stem
			{-0.13, -0.08, -0.13, 0.13, 0, 0.13},  -- taper
			{-0.18, -0.45, -0.18, 0.18, -0.08, 0.18},  -- body
			{-0.15, -0.5, -0.15, 0.15, -0.45, 0.15},  -- bottom
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.07, 0.3, -0.07, 0.07, 0.33, 0.07},  -- lip
			{-0.065, 0, -0.065, 0.065, 0.35, 0.065},  -- stem
			{-0.13, -0.08, -0.13, 0.13, 0, 0.13},  -- taper
			{-0.18, -0.45, -0.18, 0.18, -0.08, 0.18},  -- body
			{-0.15, -0.5, -0.15, 0.15, -0.45, 0.15},  -- bottom
			},
			},
		},
})
