minetest.register_node("default:mycena", {
	description = "Mycena sp",
	drawtype = "plantlike",
	tiles = { "default_mycena.png" },
	inventory_image = "default_mycena.png",
	wield_image = "default_mycena.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3, flammable=0, flower=0, 
		  flora=1, attached_node=1, color_green=1},
	sounds = default.node_sound_leaves_defaults(),
	light_source = 5,
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("default:mushie_1", {
	description = "Mushie 1",
	drawtype = "plantlike",
	tiles = { "default_mushie_1.png" },
	inventory_image = "default_mushie_1.png",
	wield_image = "default_mushie_1.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3, flammable=0, flower=0, 
		  flora=1, attached_node=1, color_green=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("default:mushie_2", {
	description = "Mushie 2",
	drawtype = "plantlike",
	tiles = { "default_mushie_2.png" },
	inventory_image = "default_mushie_2.png",
	wield_image = "default_mushie_2.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3, flammable=0, flower=0, 
		  flora=1, attached_node=1, color_green=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})


