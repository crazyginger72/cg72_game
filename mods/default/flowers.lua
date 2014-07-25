-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- Map Generation
dofile(minetest.get_modpath("default").."/flowergen.lua")

-- Aliases for original default mod
minetest.register_alias("default:flower_dandelion_white", "default:dandelion_white")
minetest.register_alias("default:flower_dandelion_yellow", "default:dandelion_yellow")
minetest.register_alias("default:flower_geranium", "default:geranium")
minetest.register_alias("default:flower_rose", "default:rose")
minetest.register_alias("default:flower_tulip", "default:tulip")
minetest.register_alias("default:flower_viola", "default:viola")
--
minetest.register_node("default:dasie", {
	description = "White Dasie",
	drawtype = "plantlike",
	tiles = { "flowers_dasie.png" },
	inventory_image = "flowers_dasie.png",
	wield_image = "flowers_dasie.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_white=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})
--
minetest.register_node("default:dandelion_white", {
	description = "White Dandelion",
	drawtype = "plantlike",
	tiles = { "flowers_dandelion_white.png" },
	inventory_image = "flowers_dandelion_white.png",
	wield_image = "flowers_dandelion_white.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_white=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})
--
minetest.register_node("default:dandelion_yellow", {
	description = "Yellow Dandelion",
	drawtype = "plantlike",
	tiles = { "flowers_dandelion_yellow.png" },
	inventory_image = "flowers_dandelion_yellow.png",
	wield_image = "flowers_dandelion_yellow.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})
--
minetest.register_node("default:geranium", {
	description = "Blue Geranium",
	drawtype = "plantlike",
	tiles = { "flowers_geranium.png" },
	inventory_image = "flowers_geranium.png",
	wield_image = "flowers_geranium.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_blue=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})
----
minetest.register_node("default:rose", {
	description = "Rose",
	drawtype = "plantlike",
	tiles = { "flowers_rose.png" },
	inventory_image = "flowers_rose.png",
	wield_image = "flowers_rose.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_red=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})
--
minetest.register_node("default:tulip", {
	description = "Tulip",
	drawtype = "plantlike",
	tiles = { "flowers_tulip.png" },
	inventory_image = "flowers_tulip.png",
	wield_image = "flowers_tulip.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_orange=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})
--
minetest.register_node("default:viola", {
	description = "Viola",
	drawtype = "plantlike",
	tiles = { "flowers_viola.png" },
	inventory_image = "flowers_viola.png",
	wield_image = "flowers_viola.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_violet=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_abm({
	nodenames = {"group:flora"},
	neighbors = {"default:dirt_with_grass", "default:desert_sand"},
	interval = 50,
	chance = 25,
	action = function(pos, node)
		pos.y = pos.y - 1
		local under = minetest.get_node(pos)
		pos.y = pos.y + 1
		if under.name == "default:desert_sand" then
			minetest.set_node(pos, {name="default:dry_shrub"})
		elseif under.name ~= "default:dirt_with_grass" then
			return
		end
		
		local light = minetest.get_node_light(pos)
		if not light or light < 13 then
			return
		end
		
		local pos0 = {x=pos.x-4,y=pos.y-4,z=pos.z-4}
		local pos1 = {x=pos.x+4,y=pos.y+4,z=pos.z+4}
		if #minetest.find_nodes_in_area(pos0, pos1, "group:flora_block") > 0 then
			return
		end
		
		local flowers = minetest.find_nodes_in_area(pos0, pos1, "group:flora")
		if #flowers > 3 then
			return
		end
		
		local seedling = minetest.find_nodes_in_area(pos0, pos1, "default:dirt_with_grass")
		if #seedling > 0 then
			seedling = seedling[math.random(#seedling)]
			seedling.y = seedling.y + 1
			light = minetest.get_node_light(seedling)
			if not light or light < 13 then
				return
			end
			if minetest.get_node(seedling).name == "air" then
				minetest.set_node(seedling, {name=node.name})
			end
		end
	end,
})

minetest.register_node("default:rose_bush", {
	description = "Rosebush",
	drawtype = "plantlike",
	visual_scale = 1.5,
	inventory_image = "gardening_rosebush.png",
	wield_image = "gardening_rosebush.png",
	tiles = {"gardening_rosebush.png"},
	paramtype = "light",
	drop = {
		items = {
			{ items = {'default:rose 10'}, rarity = 50,},
			{ items = {'default:rose'}, rarity = 4,},
			{ items = {'default:rose'}, rarity = 10,},
			{ items = {'default:rose 2'}, },
				},
			},
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
					},
})

minetest.register_craft({
	output = 'default:rose_bush 2',
	recipe = {
		{'default:rose'},
		{'default:leaves'},
		{'default:rose'},
	},
})

minetest.register_node("default:geranium_cluster", {
	description = "Geranium cluster",
	drawtype = "plantlike",
	visual_scale = 1.1,
	inventory_image = "gardening_geranium_shrub.png",
	wield_image = "gardening_geranium_shrub.png",
	tiles = {"gardening_geranium_shrub.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
	},
})

minetest.register_craft({
	output = 'default:geranium_cluster 2',
	recipe = {
		{'default:geranium'},
		{'default:leaves'},
		{'default:geranium'},
	},
})

minetest.register_node("default:violas_cluster", {
	description = "Violas cluster",
	drawtype = "plantlike",
	visual_scale = 1.1,
	inventory_image = "gardening_violas.png",
	wield_image = "gardening_violas.png",
	tiles = {"gardening_violas.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
	},
})

minetest.register_craft({
	output = 'default:violas_cluster 2',
	recipe = {
		{'default:viola'},
		{'default:leaves'},
		{'default:viola'},
	},
})

minetest.register_node('default:dandelions_cluster', {
	description = "Dandelion cluster",
	drawtype = "plantlike",
	visual_scale = 1.1,
	inventory_image = "gardening_dandelions.png",
	wield_image = "gardening_dandelions.png",
	tiles = {"gardening_dandelions.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
	},
})

minetest.register_craft({
	output = 'default:dandelions_cluster',
	recipe = {
		{'default:dandelion_white', 'default:dandelion_white', 'default:dandelion_white'},
		{'', 'default:leaves', ''},
		{'', '', ''},
	},
})

minetest.register_craft({
	output = 'default:dandelions_cluster',
	recipe = {
		{'default:dandelion_yellow', 'default:dandelion_yellow', 'default:dandelion_yellow'},
		{'', 'default:leaves', ''},
		{'', '', ''},
	},
})

minetest.register_craft({
	output = 'default:dandelions_cluster',
	recipe = {
		{'default:dandelion_yellow', 'default:dandelion_white', 'default:dandelion_white'},
		{'', 'default:leaves', ''},
		{'', '', ''},
	},
})

minetest.register_craft({
	output = 'default:dandelions_cluster',
	recipe = {
		{'default:dandelion_yellow', 'default:dandelion_yellow', 'default:dandelion_white'},
		{'', 'default:leaves', ''},
		{'', '', ''},
	},
})

minetest.register_craft({
	output = 'default:dandelions_cluster',
	recipe = {
		{'default:dandelion_white', 'default:dandelion_yellow', 'default:dandelion_white'},
		{'', 'default:leaves', ''},
		{'', '', ''},
	},
})

minetest.register_craft({
	output = 'default:dandelions_cluster',
	recipe = {
		{'default:dandelion_yellow', 'default:dandelion_white', 'default:dandelion_yellow'},
		{'', 'default:leaves', ''},
		{'', '', ''},
	},
})

minetest.register_craft({
	output = 'default:dandelions_cluster',
	recipe = {
		{'default:dandelion_white', 'default:dandelion_white', 'default:dandelion_yellow'},
		{'', 'default:leaves', ''},
		{'', '', ''},
	},
})

minetest.register_craft({
	output = 'default:dandelions_cluster',
	recipe = {
		{'default:dandelion_white', 'default:dandelion_yellow', 'default:dandelion_yellow'},
		{'', 'default:leaves', ''},
		{'', '', ''},
	},
})

minetest.register_node("default:tulip_cluster", {
	description = "Tulip cluster",
	drawtype = "plantlike",
	visual_scale = 1.1,
	inventory_image = "gardening_tulip_shrub.png",
	wield_image = "gardening_tulip_shhrub.png",
	tiles = {"gardening_tulip_shrub.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
	},
})

minetest.register_craft({
	output = 'default:tulip_cluster',
	recipe = {
		{'default:tulip'},
		{'default:leaves'},
		{'default:tulip'},
	},
})

minetest.register_node("default:dasie_cluster", {
	description = "Dasie cluster",
	drawtype = "plantlike",
	visual_scale = 1.1,
	inventory_image = "gardening_dasies.png",
	wield_image = "gardening_dasies.png",
	tiles = {"gardening_dasies.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
	},
})

minetest.register_craft({
	output = 'default:dasie_cluster',
	recipe = {
		{'default:dasie'},
		{'default:leaves'},
		{'default:dasie'},
	},
})

minetest.register_node("default:clover", {
	description = "Clover",
	drawtype = "nodebox",
	tiles = {'clover_top.png', 'default_grass.png', 'clover_side.png',},
	paramtype = "light",
	buildable_to = true,
	walkable = true,
	sounds = default.node_sound_leaves_defaults(),
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,crumbly=3},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, -- NodeBox1
			{0.125, -0.5, 0.4375, 0.1875, -0.3125, 0.5}, -- NodeBox2
			{-0.375, -0.5, 0.375, -0.3125, -0.3125, 0.4375}, -- NodeBox3
			{-0.0625, -0.5, 0.3125, 0, -0.3125, 0.375}, -- NodeBox4
			{-0.3125, -0.5, 0.25, -0.25, -0.3125, 0.3125}, -- NodeBox5
			{0.3125, -0.5, 0.1875, 0.375, -0.3125, 0.25}, -- NodeBox6
			{0.0625, -0.5, 0.125, 0.125, -0.3125, 0.1875}, -- NodeBox7
			{-0.1875, -0.5, 0.0625, -0.125, -0.3125, 0.125}, -- NodeBox8
			{-0.5, -0.5, 0.0625, -0.4375, -0.3125, 0.125}, -- NodeBox9
			{0.125, -0.5, -0.0625, 0.1875, -0.3125, 0}, -- NodeBox10
			{0.3125, -0.5, -0.125, 0.375, -0.3125, -0.0625}, -- NodeBox11
			{-0.375, -0.5, -0.125, -0.3125, -0.3125, -0.0625}, -- NodeBox12
			{-0.125, -0.5, -0.25, -0.0625, -0.3125, -0.1875}, -- NodeBox13
			{0.0625, -0.5, -0.3125, 0.125, -0.3125, -0.25}, -- NodeBox14
			{-0.25, -0.5, -0.3125, -0.1875, -0.3125, -0.25}, -- NodeBox15
			{-0.4375, -0.5, -0.375, -0.375, -0.3125, -0.3125}, -- NodeBox16
			{0.375, -0.5, -0.4375, 0.4375, -0.3125, -0.375}, -- NodeBox17
			{0.1875, -0.5, -0.4375, 0.25, -0.3125, -0.375}, -- NodeBox18
			{-0.1875, -0.5, -0.5, -0.125, -0.3125, -0.4375}, -- NodeBox19
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
		},
	},
})

minetest.register_node("default:clover_purple", {
	description = "Purple Clover",
	drawtype = "nodebox",
	tiles = {'clover_purple_top.png', 'default_grass.png', 'clover_purple_side.png',},
	paramtype = "light",
	buildable_to = true,
	walkable = true,
	sounds = default.node_sound_leaves_defaults(),
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,crumbly=3},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, -- NodeBox1
			{0.125, -0.5, 0.4375, 0.1875, -0.3125, 0.5}, -- NodeBox2
			{-0.375, -0.5, 0.375, -0.3125, -0.3125, 0.4375}, -- NodeBox3
			{-0.0625, -0.5, 0.3125, 0, -0.3125, 0.375}, -- NodeBox4
			{-0.3125, -0.5, 0.25, -0.25, -0.3125, 0.3125}, -- NodeBox5
			{0.3125, -0.5, 0.1875, 0.375, -0.3125, 0.25}, -- NodeBox6
			{0.0625, -0.5, 0.125, 0.125, -0.3125, 0.1875}, -- NodeBox7
			{-0.1875, -0.5, 0.0625, -0.125, -0.3125, 0.125}, -- NodeBox8
			{-0.5, -0.5, 0.0625, -0.4375, -0.3125, 0.125}, -- NodeBox9
			{0.125, -0.5, -0.0625, 0.1875, -0.3125, 0}, -- NodeBox10
			{0.3125, -0.5, -0.125, 0.375, -0.3125, -0.0625}, -- NodeBox11
			{-0.375, -0.5, -0.125, -0.3125, -0.3125, -0.0625}, -- NodeBox12
			{-0.125, -0.5, -0.25, -0.0625, -0.3125, -0.1875}, -- NodeBox13
			{0.0625, -0.5, -0.3125, 0.125, -0.3125, -0.25}, -- NodeBox14
			{-0.25, -0.5, -0.3125, -0.1875, -0.3125, -0.25}, -- NodeBox15
			{-0.4375, -0.5, -0.375, -0.375, -0.3125, -0.3125}, -- NodeBox16
			{0.375, -0.5, -0.4375, 0.4375, -0.3125, -0.375}, -- NodeBox17
			{0.1875, -0.5, -0.4375, 0.25, -0.3125, -0.375}, -- NodeBox18
			{-0.1875, -0.5, -0.5, -0.125, -0.3125, -0.4375}, -- NodeBox19
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
		},
	},
})

minetest.register_node("default:sunflower_b", {
	description = "Sunflower",
	drawtype = "nodebox",
	tiles = {'sunflower_stalk.png',},
	paramtype = "light",
	walkable = true,
	sounds = default.node_sound_leaves_defaults(),
	groups = {snappy=2,choppy=1,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	drop = { items = { { items = {'default:dye_green'}, }, }, },
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{0, -0.5, 0.125, 0.0625, 0.5, 0.1875},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{0, -0.5, 0.125, 0.0625, 0.5, 0.1875},
		},
	},
})

minetest.register_node("default:sunflower_m", {
	description = "Sunflower",
	drawtype = "nodebox",
	tiles = {'sunflower_stalk.png',},
	paramtype = "light",
	walkable = true,
	sounds = default.node_sound_leaves_defaults(),
	groups = {snappy=2,choppy=1,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	drop = { items = { { items = {'default:dye_green'}, }, }, },
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{0, -0.5, 0.125, 0.0625, 0.5, 0.1875}, -- NodeBox1
				{0.0625, 0.13964, 0.137614, 0.309309, 0.166667, 0.167644}, -- NodeBox2
				{0.1875, 0.125, 0.125, 0.5, 0.1875, 0.1875}, -- NodeBox3
				{0.213213, 0.125, 0.0625, 0.477477, 0.1875, 0.25}, -- NodeBox4
				{0.207207, -0.375, 0.0625, 0.495495, -0.3125, 0.25}, -- NodeBox5
				{0.1875, -0.375, 0.125, 0.5, -0.3125, 0.1875}, -- NodeBox6
				{0.0625, -0.355856, 0.146623, 0.1875, -0.331832, 0.167644}, -- NodeBox7
				{-0.4375, -0.25, 0.125, -0.125, -0.1875, 0.1875}, -- NodeBox8
				{-0.405405, -0.25, 0.0625, -0.147147, -0.1875, 0.25}, -- NodeBox9
				{-0.315315, -0.234, 0.142236, 0.0330331, -0.21, 0.166284}, -- NodeBox10
				{-0.4375, 0.375, 0.125, -0.125, 0.4375, 0.1875}, -- NodeBox11
				{-0.405405, 0.375, 0.0625, -0.141141, 0.4375, 0.25}, -- NodeBox12
				{-0.351351, 0.396, 0.136224, 0.0330331, 0.426, 0.166284}, -- NodeBox13
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{0, -0.5, 0.125, 0.0625, 0.5, 0.1875}, -- NodeBox1
				{0.0625, 0.13964, 0.137614, 0.309309, 0.166667, 0.167644}, -- NodeBox2
				{0.1875, 0.125, 0.125, 0.5, 0.1875, 0.1875}, -- NodeBox3
				{0.213213, 0.125, 0.0625, 0.477477, 0.1875, 0.25}, -- NodeBox4
				{0.207207, -0.375, 0.0625, 0.495495, -0.3125, 0.25}, -- NodeBox5
				{0.1875, -0.375, 0.125, 0.5, -0.3125, 0.1875}, -- NodeBox6
				{0.0625, -0.355856, 0.146623, 0.1875, -0.331832, 0.167644}, -- NodeBox7
				{-0.4375, -0.25, 0.125, -0.125, -0.1875, 0.1875}, -- NodeBox8
				{-0.405405, -0.25, 0.0625, -0.147147, -0.1875, 0.25}, -- NodeBox9
				{-0.315315, -0.234, 0.142236, 0.0330331, -0.21, 0.166284}, -- NodeBox10
				{-0.4375, 0.375, 0.125, -0.125, 0.4375, 0.1875}, -- NodeBox11
				{-0.405405, 0.375, 0.0625, -0.141141, 0.4375, 0.25}, -- NodeBox12
				{-0.351351, 0.396, 0.136224, 0.0330331, 0.426, 0.166284}, -- NodeBox13
		},
	},
})

minetest.register_node("default:sunflower_head", {
	description = "Sunflower",
	drawtype = "nodebox",
	tiles = {'sunflower_t.png','sunflower_bt.png','sunflower_l.png','sunflower_r.png','sunflower_b.png','sunflower_f.png',},
	paramtype = "light",
	walkable = true,
	sounds = default.node_sound_leaves_defaults(),
	groups = {snappy=2,choppy=1,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	drop = {
		items = {
			{ items = {'default:sunflower_seed 10'}, rarity = 50,},
			{ items = {'default:sunflower_seed 2'}, rarity = 4,},
			{ items = {'default:sunflower_seed 4'}, rarity = 10,},
			{ items = {'default:sunflower_seed 5'}, },
		},
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{0, -0.5, 0.125, 0.0625, 0.0625, 0.1875}, -- NodeBox1
				{0.207207, -0.375, 0.0625, 0.495495, -0.3125, 0.25}, -- NodeBox5
				{0.1875, -0.375, 0.125, 0.5, -0.3125, 0.1875}, -- NodeBox6
				{0.0625, -0.355856, 0.146623, 0.1875, -0.331832, 0.167644}, -- NodeBox7
				{-0.4375, -0.25, 0.125, -0.125, -0.1875, 0.1875}, -- NodeBox8
				{-0.405405, -0.25, 0.0625, -0.147147, -0.1875, 0.25}, -- NodeBox9
				{-0.315315, -0.234, 0.142236, 0.0330331, -0.21, 0.166284}, -- NodeBox10
				{-0.0625, 0, 0.0625, 0.125, 0.3125, 0.125}, -- NodeBox17
				{-0.125, 0.0625, 0.0625, 0.1875, 0.25, 0.125}, -- NodeBox18
				{-0.0625, -0.1875, 0.0941392, 0.125, 0.5, 0.112176}, -- NodeBox19
				{-0.3125, 0.0625, 0.0895653, 0.375, 0.25, 0.110587}, -- NodeBox20
				{-0.1875, -0.125, 0.0955714, 0.25, 0.4375, 0.110587}, -- NodeBox21
				{-0.25, -0.0625, 0.0925684, 0.3125, 0.375, 0.110587}, -- NodeBox22
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{0, -0.5, 0.125, 0.0625, 0.0625, 0.1875}, -- NodeBox1
				{0.207207, -0.375, 0.0625, 0.495495, -0.3125, 0.25}, -- NodeBox5
				{0.1875, -0.375, 0.125, 0.5, -0.3125, 0.1875}, -- NodeBox6
				{0.0625, -0.355856, 0.146623, 0.1875, -0.331832, 0.167644}, -- NodeBox7
				{-0.4375, -0.25, 0.125, -0.125, -0.1875, 0.1875}, -- NodeBox8
				{-0.405405, -0.25, 0.0625, -0.147147, -0.1875, 0.25}, -- NodeBox9
				{-0.315315, -0.234, 0.142236, 0.0330331, -0.21, 0.166284}, -- NodeBox10
				{-0.0625, 0, 0.0625, 0.125, 0.3125, 0.125}, -- NodeBox17
				{-0.125, 0.0625, 0.0625, 0.1875, 0.25, 0.125}, -- NodeBox18
				{-0.0625, -0.1875, 0.0941392, 0.125, 0.5, 0.112176}, -- NodeBox19
				{-0.3125, 0.0625, 0.0895653, 0.375, 0.25, 0.110587}, -- NodeBox20
				{-0.1875, -0.125, 0.0955714, 0.25, 0.4375, 0.110587}, -- NodeBox21
				{-0.25, -0.0625, 0.0925684, 0.3125, 0.375, 0.110587}, -- NodeBox22
		},
	},
})

minetest.register_craftitem("default:sunflower_seed", {
	description = "Sunflower Seed",
	inventory_image = "sunflower_seed.png",
	on_use = minetest.item_eat(1),
	on_place = function(itemstack, placer, pointed_thing)
		return plant_seed(itemstack, placer, pointed_thing, "default:sunflower_sprout")
	end,
	sounds = default.node_sound_leaves_defaults(),
})

local function plant_seed(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	
	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)
	
	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end
	
	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return
	end
	
	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return
	end
	
	-- check if pointing at soil
	if minetest.get_item_group(under.name, "soil") <= 1 then
		return
	end
	
	-- add the node and remove 1 item from the itemstack
	minetest.add_node(pt.above, {name=plantname})
	if not minetest.setting_getbool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end

minetest.register_node("default:sunflower_sprout", {
	description = "Sunflower Sprout",
	drawtype = "plantlike",
	tiles = { "sunflower_sprout.png" },
	inventory_image = "sunflower_sprout.png",
	wield_image = "sunflower_sprout.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	drop = { items = { { items = {''}, }, }, },
	groups = {flammable=2,flora=1,snappy=1,choppy=1,oddly_breakable_by_hand=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})


















