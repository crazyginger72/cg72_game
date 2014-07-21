
-- This file supplies glasses

minetest.register_node("default:shotglass", {
	description = "Shotglass",
	drawtype = "nodebox",
	tiles = {
		'glass_top.png', -- top
		'glass_top.png',  -- bottom
		'glass.png',  -- side
		'glass.png',  -- side
		'glass.png',  -- back
		'glass.png',  -- front
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
			{-0.09, -0.35, -0.09, 0.09, -0.3, 0.09},  -- upper
			{-0.08, -0.48, -0.08, 0.08, -0.35, 0.08},  -- body
			{-0.07, -0.5, -0.07, 0.07, -0.48, 0.07},  -- bottom
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.09, -0.35, -0.09, 0.09, -0.3, 0.09},  -- upper
			{-0.08, -0.48, -0.08, 0.08, -0.35, 0.08},  -- body
			{-0.07, -0.5, -0.07, 0.07, -0.48, 0.07},  -- bottom
			},
		},
})

minetest.register_node("default:highball", {
	description = "Highball glass",
	drawtype = "nodebox",
	tiles = {
		'glass_top.png', -- top
		'glass_top.png',  -- bottom
		'glass.png',  -- side
		'glass.png',  -- side
		'glass.png',  -- back
		'glass.png',  -- front
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
			{-0.12, -0.0, -0.12, 0.12, -0.4, 0.12},  -- upper
			{-0.11, -0.45, -0.11, 0.11, -0.4, 0.11},  -- body
			{-0.1, -0.5, -0.1, 0.1, -0.45, 0.1},  -- bottom
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.12, -0.0, -0.12, 0.12, -0.4, 0.12},  -- upper
			{-0.11, -0.45, -0.11, 0.11, -0.4, 0.11},  -- body
			{-0.1, -0.5, -0.1, 0.1, -0.45, 0.1},  -- bottom
			},
		},
})

minetest.register_node("default:pint_glass", {
	description = "Pint glass",
	drawtype = "nodebox",
	tiles = {
		'glass_top.png', -- top
		'glass_top.png',  -- bottom
		'glass.png',  -- side
		'glass.png',  -- side
		'glass.png',  -- back
		'glass.png',  -- front
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
			{-0.13, -0.2, -0.13, 0.13, -0.15, 0.13},  -- lip
			{-0.11, -0.2, -0.11, 0.11, -0.35, 0.11},  -- upper
			{-0.09, -0.45, -0.09, 0.09, -0.35, 0.09},  -- body
			{-0.1, -0.5, -0.1, 0.1, -0.45, 0.1},  -- bottom
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.13, -0.2, -0.13, 0.13, -0.15, 0.13},  -- lip
			{-0.11, -0.2, -0.11, 0.11, -0.35, 0.11},  -- upper
			{-0.09, -0.45, -0.09, 0.09, -0.35, 0.09},  -- body
			{-0.1, -0.5, -0.1, 0.1, -0.45, 0.1},  -- bottom
			},
		},
})

minetest.register_node("default:martini", {
	description = "Martini glass",
	drawtype = "nodebox",
	tiles = {
		'glass_top.png', -- top
		'glass_top.png',  -- bottom
		'glass.png',  -- side
		'glass.png',  -- side
		'glass.png',  -- back
		'glass.png',  -- front
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
			{-0.15, -0.2, -0.15, 0.15, -0.25, 0.15},  -- upper
			{-0.13, -0.3, -0.13, 0.15, -0.25, 0.13},  -- 
			{-0.11, -0.35, -0.11, 0.11, -0.3, 0.11},  -- body
			{-0.01, -0.48, -0.01, 0.01, -0.35, 0.01},  -- 
			{-0.09, -0.5, -0.09, 0.09, -0.48, 0.09},  -- bottom
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.15, -0.2, -0.15, 0.15, -0.25, 0.15},  -- upper
			{-0.13, -0.3, -0.13, 0.15, -0.25, 0.13},  -- 
			{-0.11, -0.35, -0.11, 0.11, -0.3, 0.11},  -- body
			{-0.01, -0.48, -0.01, 0.01, -0.35, 0.01},  -- 
			{-0.09, -0.5, -0.09, 0.09, -0.48, 0.09},  -- bottom
			},
		},
})
