



local coloured_glass = {}

coloured_glass.dyes = {
	{"white",      "White",      nil},
	{"grey",       "Grey",       "basecolor_grey"},
	{"black",      "Black",      "basecolor_black"},
	{"red",        "Red",        "basecolor_red"},
	{"yellow",     "Yellow",     "basecolor_yellow"},
	{"green",      "Green",      "basecolor_green"},
	{"cyan",       "Cyan",       "basecolor_cyan"},
	{"blue",       "Blue",       "basecolor_blue"},
	{"magenta",    "Magenta",    "basecolor_magenta"},
	{"orange",     "Orange",     "excolor_orange"},
	{"violet",     "Violet",     "excolor_violet"},
	{"brown",      "Brown",      "unicolor_dark_orange"},
	{"pink",       "Pink",       "unicolor_light_red"},
	{"dark_grey",  "Dark Grey",  "unicolor_darkgrey"},
	{"dark_green", "Dark Green", "unicolor_dark_green"},
	{"dark_blue", "Dark Blue", "unicolor_dark_blue"},
}

for _, row in ipairs(coloured_glass.dyes) do
	local name = row[1]
	local desc = row[2]
	local craft_color_group = row[3]

	minetest.register_node("default:coloured_glass"..name, {
		description = desc.." coloured glass",
		drawtype = "glasslike",
		paramtype = "light",
		light_source = 1,
		sunlight_propagates = true,
		tiles = {"default_glass_"..name..".png"},
		use_texture_alpha = true,
		groups = {cracky=3,oddly_breakable_by_hand=3},
		sounds = default.node_sound_glass_defaults(),
	})

	if craft_color_group then

		minetest.register_craft({
			type = "shapeless",
			output = 'default:coloured_glass'..name,
			recipe = {'group:dye,'..craft_color_group, 'default:glass'},
		})
	end


local load_time_start = os.clock()
local function connect_glass(node, img)
	local tmp = minetest.registered_nodes[node]
		tmp.tiles = img
		tmp.drawtype = "glasslike_framed"
	minetest.register_node(":"..node, tmp)
end


local d_glass_list = {
	{"glass", {"default_glass.png", "connected_textures_glass_stripes.png"}},
	{"obsidian_glass", {"default_obsidian_glass.png", "connected_textures_invisible.png"}},
	{"coloured_glass"..name, {"coloured_glass"..name..".png", "connected_textures_invisible.png"}}
}

for _,i in ipairs(d_glass_list) do
	connect_glass("default:"..i[1], i[2])
end
end
----------------------------------------------------
-------------moreblocks glass support---------------
if minetest.get_modpath("moreblocks") then

	local m_glass_list = {
		{"iron_glass", {"moreblocks_iron_glass.png", "connected_textures_iron_glass_stripes.png"}},
		{"coal_glass", {"moreblocks_coal_glass.png", "connected_textures_coal_glass_stripes.png"}},
		{"clean_glass", {"moreblocks_clean_glass.png", "connected_textures_invisible.png"}},
		{"trap_glass", {"moreblocks_trap_glass.png", "connected_textures_glass_stripes.png"}},
		{"super_glow_glass", {"moreblocks_super_glow_glass.png", "connected_textures_glow_glass_stripes.png"}},
	}

	for _,i in ipairs(m_glass_list) do
		connect_glass("moreblocks:"..i[1], i[2])
	end

end


minetest.register_node(":default:ice", {
	description = "Ice",
	tiles = {"connected_textures_ice.png"},
	is_ground_content = true,
	use_texture_alpha = true,
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
})

print(string.format("[connected_textures] loaded after ca. %.2fs", os.clock() - load_time_start))