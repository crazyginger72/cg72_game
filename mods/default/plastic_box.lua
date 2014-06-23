plasticbox = {}
plasticbox.colorlist = {
        {"black", "Black Plastic"},
        {"blue", "Blue Plastic"},
        {"brown", "Brown Plastic"},
        {"cyan", "Cyan Plastic"},
        {"green", "Green Plastic"},
        {"grey", "Grey Plastic"},
        {"magenta", "Magenta Plastic"},
        {"orange", "Orange Plastic"},
        {"pink", "Pink Plastic"},
        {"red", "Red Plastic"},
        {"violet", "Violet Plastic"},
        {"white",  "White Plastic"},
        {"yellow", "Yellow Plastic"},
}



--Register Nodes, assign textures, blah, blah...
minetest.register_node("default:plasticbox", {
	description = "Plain Plastic Box",
	tiles = {"plasticbox.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_black", {
	description = "Black Plastic Box",
	tiles = {"plasticbox_black.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_blue", {
	description = "Blue Plastic Box",
	tiles = {"plasticbox_blue.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_brown", {
	description = "Brown Plastic Box",
	tiles = {"plasticbox_brown.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_cyan", {
	description = "Cyan Plastic Box",
	tiles = {"plasticbox_cyan.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_darkgreen", {
	description = "Dark Green Plastic Box",
	tiles = {"plasticbox_darkgreen.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_darkgrey", {
	description = "Dark Gray Plastic Box",
	tiles = {"plasticbox_darkgrey.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_green", {
	description = "Green Plastic Box",
	tiles = {"plasticbox_green.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_grey", {
	description = "Gray Plastic Box",
	tiles = {"plasticbox_grey.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_magenta", {
	description = "Magenta Plastic Box",
	tiles = {"plasticbox_magenta.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_orange", {
	description = "Orange Plastic Box",
	tiles = {"plasticbox_orange.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_pink", {
	description = "Pink Plastic Box",
	tiles = {"plasticbox_pink.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_red", {
	description = "Red Plastic Box",
	tiles = {"plasticbox_red.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_violet", {
	description = "Violet Plastic Box",
	tiles = {"plasticbox_violet.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_white", {
	description = "White Plastic Box",
	tiles = {"plasticbox_white.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:plasticbox_yellow", {
	description = "Yellow Plastic Box",
	tiles = {"plasticbox_yellow.png"},
	is_ground_content = true,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, level=1},
	sounds = default.node_sound_stone_defaults(),
})


--Register craft for plain box
minetest.register_craft( {
        output = "default:plasticbox 4",
        recipe = {
                { "default:plastic_sheeting", "default:plastic_sheeting", "default:plastic_sheeting" },
                { "default:plastic_sheeting", "", "default:plastic_sheeting" },
                { "default:plastic_sheeting", "default:plastic_sheeting", "default:plastic_sheeting" }
        },
})

--Register crafts for colored boxes
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_black',
     recipe = {default:plasticbox', 'group:basecolor_black'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_blue',
     recipe = {default:plasticbox', 'group:basecolor_blue'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_brown',
     recipe = {default:plasticbox', 'group:basecolor_brown'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_cyan',
     recipe = {default:plasticbox', 'group:basecolor_cyan'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_green',
     recipe = {default:plasticbox', 'group:basecolor_green'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_grey',
     recipe = {default:plasticbox', 'group:basecolor_grey'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_magenta',
     recipe = {'default:plasticbox', 'group:basecolor_magenta'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_orange',
     recipe = {'default:plasticbox', 'group:basecolor_orange'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_pink',
     recipe = {'default:plasticbox', 'group:basecolor_pink'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_red',
     recipe = {'default:plasticbox', 'group:basecolor_red'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_violet',
     recipe = {'default:plasticbox', 'group:basecolor_violet'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_white',
     recipe = {'default:plasticbox', 'group:basecolor_white'},
})
minetest.register_craft({
     type = "shapeless",
     output = 'default:plasticbox_yellow',
     recipe = {'default:plasticbox', 'group:basecolor_yellow'},
})

--ugly below here.

if minetest.get_modpath("moreblocks") then
                        register_stair(
                                "plasticbox",
                                "plasticbox",
                                "'default:plasticbox",
                                { snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2,not_in_creative_inventory=1 },
                                { "plasticbox.png",
                                },
                                "Plastic",
                                "plasticbox",
                                0
                        )
                        register_slab(
                                "plasticbox",
                                "plasticbox",
                                "'default:plasticbox",
                                { snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2,not_in_creative_inventory=1 },
                                { "plasticbox.png",
                                },
                                "Plastic",
                                "plasticbox",
                                0
                        )

                        register_panel(
                                "plasticbox",
                                "plasticbox",
                                "'default:plasticbox",
                                { snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2,not_in_creative_inventory=1 },
                                { "plasticbox.png",
                                },
                                "Plastic",
                                "plasticbox",
                                0
                        )

                        register_micro(
                                "plasticbox",
                                "plasticbox",
                                "'default:plasticbox",
                                { snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2,not_in_creative_inventory=1 },
                                { "plasticbox.png",
                                },
                                "Plastic",
                                "plasticbox",
                                0
                        )
		table.insert(circular_saw.known_stairs, "'default:plasticbox")

end



for i in ipairs(plasticbox.colorlist) do
        local colorname = plasticbox.colorlist[i][1]
        local desc = plasticbox.colorlist[i][2]

		if minetest.get_modpath("moreblocks") then
                        register_stair(
                                "plasticbox",
                                "plasticbox_"..colorname,
                                "'default:plasticbox_"..colorname,
                                { snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2,not_in_creative_inventory=1 },
                                {        "plasticbox_"..colorname..".png",
                                },
                                desc,
                                "plasticbox_"..colorname,
                                0
                        )
                        register_slab(
                                "plasticbox",
                                "plasticbox_"..colorname,
                                "'default:plasticbox_"..colorname,
                                { snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2,not_in_creative_inventory=1 },
                                {        "plasticbox_"..colorname..".png",
                                },
                                desc,
                                "plasticbox_"..colorname,
                                0
                        )

                        register_panel(
                                "plasticbox",
                                "plasticbox_"..colorname,
                                "'default:plasticbox_"..colorname,
                                { snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2,not_in_creative_inventory=1 },
                                {        "plasticbox_"..colorname..".png",
                                },
                                desc,
                                "plasticbox_"..colorname,
                                0
                        )

                        register_micro(
                                "plasticbox",
                                "plasticbox_"..colorname,
                                "'default:plasticbox_"..colorname,
                                { snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2,not_in_creative_inventory=1 },
                                {        "plasticbox_"..colorname..".png",
                                },
                                desc,
                                "plasticbox_"..colorname,
                                0
                        )
		table.insert(circular_saw.known_stairs, "'default:plasticbox_"..colorname)

	end
end
