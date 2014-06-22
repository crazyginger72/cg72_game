minetest.register_node("default:bed_foot", {
	description = "Bed (foot region)",
	--drawtype = "nodebox",
	tiles = {"cottages_beds_bed_top_bottom.png", "default_wood.png",  "cottages_beds_bed_side.png",  "cottages_beds_bed_side.png",  "cottages_beds_bed_side.png",  "cottages_beds_bed_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	--[[node_box = {
		type = "fixed",
		fixed = {
					-- bed
					{-0.5, 0.0, -0.5, 0.5, 0.3, 0.5},
					
					-- stützen
					--{-0.5, -0.5, -0.5, -0.4, 0.5, -0.4},
				--	{  0.4,-0.5, -0.5, 0.5,  0.5, -0.4},
                               
                                        -- Querstrebe
					--{-0.4,  0.3, -0.5, 0.4, 0.5, -0.4}
				}
	},]]--
	--selection_box = {
	--	type = "fixed",
		--fixed = {
				--	{-0.5, -0.5, -0.5, 0.5, 0.3, 0.5},
			--	}
	--},
})

-- the bed is split up in two parts to avoid destruction of blocks on placement
minetest.register_node("default:bed_head", {
	description = "Bed (head region)",
	drawtype = "nodebox",
	tiles = {"cottages_beds_bed_top_top.png", "default_wood.png",  "cottages_beds_bed_side_top_r.png",  "cottages_beds_bed_side_top_l.png",  "default_wood.png",  "cottages_beds_bed_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					-- bed
					{-0.5, 0.0, -0.5, 0.5, 0.3, 0.5},
					
					-- stützen
					{-0.5,-0.5, 0.4, -0.4, 0.5, 0.5},
					{ 0.4,-0.5, 0.4,  0.5, 0.5, 0.5},

                                        -- Querstrebe
					{-0.4,  0.3,  0.4, 0.4, 0.5,  0.5}
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.3, 0.5},
				}
	},
})
