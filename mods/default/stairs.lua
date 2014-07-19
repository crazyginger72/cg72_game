-- Minetest 0.4 mod: stairs
-- See README.txt for licensing and other information.

stairs = {}

-- Node will be called default:stair_<subname>
function stairs.register_stair(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node("default:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- for replace ABM
	minetest.register_node("default:stair_" .. subname.."upside_down", {
		replace_name = "default:stair_" .. subname,
		groups = {slabs_replace=1},
	})

	minetest.register_craft({
		output = 'default:stair_' .. subname .. ' 4',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- Flipped recipe for the silly minecrafters
	minetest.register_craft({
		output = 'default:stair_' .. subname .. ' 4',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Node will be called default:slab_<subname>
function stairs.register_slab(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node("default:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local n0 = minetest.get_node(p0)
			local n1 = minetest.get_node(p1)
			local param2 = 0

			local n0_is_upside_down = (n0.name == "default:slab_" .. subname and
					n0.param2 >= 20)

			if n0.name == "default:slab_" .. subname and not n0_is_upside_down and p0.y+1 == p1.y then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "default:slab_" .. subname then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				fakestack:set_count(itemstack:get_count())

				pointed_thing.above = slabpos
				local success
				fakestack, success = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if success then
					itemstack:set_count(fakestack:get_count())
				-- Else put old node back
				else
					minetest.set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			-- Upside down slabs
			if p0.y-1 == p1.y then
				-- Turn into full block if pointing at a existing slab
				if n0_is_upside_down  then
					-- Remove the slab at the position of the slab
					minetest.remove_node(p0)
					-- Make a fake stack of a single item and try to place it
					local fakestack = ItemStack(recipeitem)
					fakestack:set_count(itemstack:get_count())

					pointed_thing.above = p0
					local success
					fakestack, success = minetest.item_place(fakestack, placer, pointed_thing)
					-- If the item was taken from the fake stack, decrement original
					if success then
						itemstack:set_count(fakestack:get_count())
					-- Else put old node back
					else
						minetest.set_node(p0, n0)
					end
					return itemstack
				end

				-- Place upside down slab
				param2 = 20
			end

			-- If pointing at the side of a upside down slab
			if n0_is_upside_down and p0.y+1 ~= p1.y then
				param2 = 20
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	-- for replace ABM
	minetest.register_node("default:slab_" .. subname.."upside_down", {
		replace_name = "default:slab_"..subname,
		groups = {slabs_replace=1},
	})

	minetest.register_craft({
		output = 'default:slab_' .. subname .. ' 6',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Replace old "upside_down" nodes with new param2 versions
minetest.register_abm({
	nodenames = {"group:slabs_replace"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		node.name = minetest.registered_nodes[node.name].replace_name
		node.param2 = node.param2 + 20
		if node.param2 == 21 then
			node.param2 = 23
		elseif node.param2 == 23 then
			node.param2 = 21
		end
		minetest.set_node(pos, node)
	end,
})

-- Nodes will be called default:{stair,slab}_<subname>
function stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab, sounds)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair, sounds)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab, sounds)
end

stairs.register_stair_and_slab("wood", "default:wood",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"default_wood.png"},
		"Wooden Stair",
		"Wooden Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("stone", "default:stone",
		{cracky=3},
		{"default_stone.png"},
		"Stone Stair",
		"Stone Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("desertstone", "default:desertstone",
		{cracky=3},
		{"default_desert_stone.png"},
		"Desert Stone Stair",
		"Desert Stone Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("desertstonebrick", "default:desertstonebrick",
		{cracky=3},
		{"default_desert_stone_brick.png"},
		"Desert Stone Brick Stair",
		"Desert Stone Brick Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("cobble", "default:cobble",
		{cracky=3},
		{"default_cobble.png"},
		"Cobble Stair",
		"Cobble Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("brick", "default:brick",
		{cracky=3},
		{"default_brick.png"},
		"Brick Stair",
		"Brick Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("sandstone", "default:sandstone",
		{crumbly=2,cracky=2},
		{"default_sandstone.png"},
		"Sandstone Stair",
		"Sandstone Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("sandstonebrick", "default:sandstonebrick",
		{crumbly=2,cracky=2},
		{"default_sandstone_brick.png"},
		"Sandstone Brick Stair",
		"Sandstone Brick Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("junglewood", "default:junglewood",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"default_junglewood.png"},
		"Junglewood Stair",
		"Junglewood Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("acaciawood", "default:acaciawood",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"default_acaciawood.png"},
		"Acaciawood Stair",
		"Acaciawood Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("cactus", "default:cactus",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"default_cactus_top.png","default_cactus_top.png","default_cactus_side.png"},
		"Cactus Stair",
		"Cactus Slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("stonebrick", "default:stonebrick",
		{cracky=3},
		{"default_stone_brick.png"},
		"Stone Brick Stair",
		"Stone Brick Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("asphalt", "default:asphalt",
		{cracky=3},
		{"default_asphalt.png"},
		"Asphalt Stair",
		"Asphalt Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("concrete", "default:concrete",
		{cracky=3},
		{"default_concrete.png"},
		"Concrete Stair",
		"Concrete Slab",
		default.node_sound_stone_defaults())

stairs.register_stair_and_slab("obsidian_glass", "default:obsidian_glass",
		{cracky=3,oddly_breakable_by_hand=3},
		{"default_obsidian_glass.png"},
		"Obsidian Glass Stair",
		"Obsidian Glass Slab",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("glass", "default:oglass",
		{cracky=3,oddly_breakable_by_hand=3},
		{"default_glass.png"},
		"Glass Stair",
		"Glass Slab",
		default.node_sound_glass_defaults())

stairs.register_stair_and_slab("cloud", "default:cloud",
		{not_in_creative_inventory=1},
		{"default_cloud.png"},
		"loud Stair",
		"loud Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolwhite", "default:woolwhite",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_white.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolgrey", "default:woolgrey",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_grey.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolblack", "default:woolblack",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_black.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolred", "default:woolred",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_red.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolyellow", "default:woolyellow",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_yellow.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolgreen", "default:woolgreen",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_green.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolcyan", "default:woolcyan",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_cyan.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolblue", "default:woolblue",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_blue.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolmagenta", "default:woolmagenta",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_magenta.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolorange", "default:woolorange",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_orange.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolviolet", "default:woolviolet",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_violet.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())	
	
stairs.register_stair_and_slab("woolbrown", "default:woolbrown",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_brown.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("woolpink", "default:woolpink",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_pink.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
				
stairs.register_stair_and_slab("wooldark_grey", "default:wooldark_grey",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_dark_grey.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
		
stairs.register_stair_and_slab("wooldark_green", "default:wooldark_green",
		{snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		{"wool_dark_green.png"},
		"Wool Stair",
		"Wool Slab",
		default.node_sound_defaults())
--lava stairs and slabs

minetest.register_node("default:stair_lava", {
		description = "Lava Stair",
		drawtype = "nodebox",
		tiles = "default_lava.png",
		paramtype = "light",
		lightsource = 11,
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
		sounds = default.node_sound_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local placer_pos = placer:getpos()
			if placer_pos then
				local dir = {
					x = p1.x - placer_pos.x,
					y = p1.y - placer_pos.y,
					z = p1.z - placer_pos.z
				}
				param2 = minetest.dir_to_facedir(dir)
			end

			if p0.y-1 == p1.y then
				param2 = param2 + 20
				if param2 == 21 then
					param2 = 23
				elseif param2 == 23 then
					param2 = 21
				end
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})

	minetest.register_craft({
		output = 'default:stair_lava 4',
		recipe = {
			{"default:lava_source", "", ""},
			{"default:lava_source", "default:lava_source", ""},
			{"default:lava_source", "default:lava_source", "default:lava_source"},
		},
	})

	-- Flipped recipe for the silly minecrafters
	minetest.register_craft({
		output = 'default:stair_lava 4',
		recipe = {
			{"", "", "default:lava_source"},
			{"", "default:lava_source", "default:lava_source"},
			{"default:lava_source", "default:lava_source", "default:lava_source"},
		},
	})

	
minetest.register_node("default:slab_lava", {
		description = Lava Slab,
		drawtype = "nodebox",
		tiles = "default_lava.png",
		paramtype = "light",
		lightsource = 11,
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local n0 = minetest.get_node(p0)
			local n1 = minetest.get_node(p1)
			local param2 = 0

			local n0_is_upside_down = (n0.name == "default:slab_lava" and
					n0.param2 >= 20)

			if n0.name == "default:slab_lava" and not n0_is_upside_down and p0.y+1 == p1.y then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "default:slab_lava" then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				fakestack:set_count(itemstack:get_count())

				pointed_thing.above = slabpos
				local success
				fakestack, success = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if success then
					itemstack:set_count(fakestack:get_count())
				-- Else put old node back
				else
					minetest.set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			-- Upside down slabs
			if p0.y-1 == p1.y then
				-- Turn into full block if pointing at a existing slab
				if n0_is_upside_down  then
					-- Remove the slab at the position of the slab
					minetest.remove_node(p0)
					-- Make a fake stack of a single item and try to place it
					local fakestack = ItemStack(recipeitem)
					fakestack:set_count(itemstack:get_count())

					pointed_thing.above = p0
					local success
					fakestack, success = minetest.item_place(fakestack, placer, pointed_thing)
					-- If the item was taken from the fake stack, decrement original
					if success then
						itemstack:set_count(fakestack:get_count())
					-- Else put old node back
					else
						minetest.set_node(p0, n0)
					end
					return itemstack
				end

				-- Place upside down slab
				param2 = 20
			end

			-- If pointing at the side of a upside down slab
			if n0_is_upside_down and p0.y+1 ~= p1.y then
				param2 = 20
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,
	})
