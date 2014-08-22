-- Minetest 0.4 mod: farming
-- See README.txt for licensing and other information.

farming = {}

farming.registered_plants = {}

function farming:add_plant(full_grown, names, interval, chance)
	minetest.register_abm({
		nodenames = names,
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.env:get_node(pos).name ~= "default:soil_wet" then
				return
			end
			pos.y = pos.y+1
			if not minetest.env:get_node_light(pos) then
				return
			end
			if minetest.env:get_node_light(pos) < 8 then
				return
			end
			local step = nil
			for i,name in ipairs(names) do
				if name == node.name then
					step = i
					break
				end
			end
			if step == nil then
				return
			end
			local new_node = {name=names[step+1]}
			if new_node.name == nil then
				new_node.name = full_grown
			end
			minetest.env:set_node(pos, new_node)
		end
	})

	table.insert(farming.registered_plants, {
		full_grown = full_grown,
		names = names,
		interval = interval,
		chance = chance,
	})
end

--
-- Soil
--
minetest.register_node("default:soil", {
	description = "Soil",
	tiles = {"farming_soil.png", "default_dirt.png"},
	drop = "default:dirt",
	is_ground_content = true,
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("default:soil_wet", {
	description = "Wet Soil",
	tiles = {"farming_soil_wet.png", "farming_soil_wet_side.png"},
	drop = "default:dirt",
	is_ground_content = true,
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_abm({
	nodenames = {"default:soil", "default:soil_wet"},
	interval = 15,
	chance = 4,
	action = function(pos, node)
		pos.y = pos.y+1
		local nn = minetest.get_node(pos).name
		pos.y = pos.y-1
		if minetest.registered_nodes[nn] and
				minetest.registered_nodes[nn].walkable and
				minetest.get_item_group(nn, "plant") == 0
		then
			minetest.set_node(pos, {name="default:dirt"})
		end
		-- check if there is water nearby
		if minetest.find_node_near(pos, 3, {"group:water"}) then
			-- if it is dry soil turn it into wet soil
			if node.name == "default:soil" then
				minetest.set_node(pos, {name="default:soil_wet"})
			end
		else
			-- turn it back into dirt if it is already dry
			if node.name == "default:soil" then
				-- only turn it back if there is no plant on top of it
				if minetest.get_item_group(nn, "plant") == 0 then
					minetest.set_node(pos, {name="default:dirt"})
				end
				
			-- if its wet turn it back into dry soil
			elseif node.name == "default:soil_wet" then
				minetest.set_node(pos, {name="default:soil"})
			end
		end
	end,
})

--
-- Hoes
--
-- turns nodes with group soil=1 into soil
function farming.hoe_on_use(itemstack, user, pointed_thing, uses)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	
	local under = minetest.get_node(pt.under)
	local p = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
	local above = minetest.get_node(p)
	
	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end
	
	-- check if the node above the pointed thing is air
	if above.name ~= "air" then
		return
	end
	
	-- check if pointing at dirt
	if minetest.get_item_group(under.name, "soil") ~= 1 then
		return
	end
	
	-- turn the node into soil, wear out item and play sound
	minetest.set_node(pt.under, {name="default:soil"})
	minetest.sound_play("default_dig_crumbly", {
		pos = pt.under,
		gain = 0.5,
	})
	itemstack:add_wear(65535/(uses-1))
	return itemstack
end

minetest.register_tool("default:hoe_wood", {
	description = "Wooden Hoe",
	inventory_image = "farming_tool_woodhoe.png",
	
	on_use = function(itemstack, user, pointed_thing)
		return farming.hoe_on_use(itemstack, user, pointed_thing, 30)
	end,
})

minetest.register_tool("default:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "farming_tool_stonehoe.png",
	
	on_use = function(itemstack, user, pointed_thing)
		return farming.hoe_on_use(itemstack, user, pointed_thing, 90)
	end,
})

minetest.register_tool("default:hoe_steel", {
	description = "Steel Hoe",
	inventory_image = "farming_tool_steelhoe.png",
	
	on_use = function(itemstack, user, pointed_thing)
		return farming.hoe_on_use(itemstack, user, pointed_thing, 200)
	end,
})

minetest.register_tool("default:hoe_bronze", {
	description = "Bronze Hoe",
	inventory_image = "farming_tool_bronzehoe.png",
	
	on_use = function(itemstack, user, pointed_thing)
		return farming.hoe_on_use(itemstack, user, pointed_thing, 220)
	end,
})

minetest.register_craft({
	output = "default:hoe_wood",
	recipe = {
		{"group:wood", "group:wood"},
		{"", "group:stick"},
		{"", "group:stick"},
	}
})

minetest.register_craft({
	output = "default:hoe_stone",
	recipe = {
		{"group:stone", "group:stone"},
		{"", "group:stick"},
		{"", "group:stick"},
	}
})

minetest.register_craft({
	output = "default:hoe_steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"", "group:stick"},
		{"", "group:stick"},
	}
})

minetest.register_craft({
	output = "default:hoe_bronze",
	recipe = {
		{"default:bronze_ingot", "default:bronze_ingot"},
		{"", "group:stick"},
		{"", "group:stick"},
	}
})

--
-- Override grass for drops
--
minetest.register_node(":default:grass_1", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_1.png"},
	-- use a bigger inventory image
	inventory_image = "default_grass_3.png",
	wield_image = "default_grass_3.png",
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{items = {'default:seed_wheat'},rarity = 5},
			{items = {'default:grass_1'}},
		}
	},
	groups = {snappy=3,flammable=3,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("default:grass_"..math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:grass_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
})

for i=2,5 do
	minetest.register_node(":default:grass_"..i, {
		description = "Grass",
		drawtype = "plantlike",
		tiles = {"default_grass_"..i..".png"},
		inventory_image = "default_grass_"..i..".png",
		wield_image = "default_grass_"..i..".png",
		paramtype = "light",
		waving = 1,
		walkable = false,
		buildable_to = true,
		is_ground_content = true,
		drop = {
			max_items = 1,
			items = {
				{items = {'default:seed_wheat'},rarity = 5},
				{items = {'default:grass_1'}},
			}
		},
		groups = {snappy=3,flammable=3,flora=1,attached_node=1,not_in_creative_inventory=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
	})
end

minetest.register_node(":default:junglegrass", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	visual_scale = 1.3,
	tiles = {"default_junglegrass.png"},
	inventory_image = "default_junglegrass.png",
	wield_image = "default_junglegrass.png",
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	drop = {
		max_items = 1,
		items = {
			{items = {'default:seed_cotton'},rarity = 8},
			{items = {'default:junglegrass'}},
		}
	},
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

--
-- Place seeds
--
local function place_seed(itemstack, placer, pointed_thing, plantname)
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

--
-- Wheat
--
minetest.register_craftitem("default:seed_wheat", {
	description = "Wheat Seed",
	inventory_image = "farming_wheat_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "default:wheat_1")
	end,
})

minetest.register_craftitem("default:wheat", {
	description = "Wheat",
	inventory_image = "farming_wheat.png",
})

minetest.register_craftitem("default:flour", {
	description = "Flour",
	inventory_image = "farming_flour.png",
})

minetest.register_craftitem("default:bread", {
	description = "Bread",
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "shapeless",
	output = "default:flour",
	recipe = {"default:wheat", "default:wheat", "default:wheat", "default:wheat"}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "default:bread",
	recipe = "default:flour"
})

for i=1,8 do
	local drop = {
		items = {
			{items = {'default:wheat'},rarity=9-i},
			{items = {'default:wheat'},rarity=18-i*2},
			{items = {'default:seed_wheat'},rarity=9-i},
			{items = {'default:seed_wheat'},rarity=18-i*2},
		}
	}
	minetest.register_node("default:wheat_"..i, {
		drawtype = "plantlike",
		tiles = {"farming_wheat_"..i..".png"},
		paramtype = "light",
		waving = 1,
		walkable = false,
		buildable_to = true,
		is_ground_content = true,
		drop = drop,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
		groups = {snappy=3,flammable=2,plant=1,wheat=i,not_in_creative_inventory=1,attached_node=1},
		sounds = default.node_sound_leaves_defaults(),
	})
end

minetest.register_abm({
	nodenames = {"group:wheat"},
	neighbors = {"group:soil"},
	interval = 90,
	chance = 2,
	action = function(pos, node)
		-- return if already full grown
		if minetest.get_item_group(node.name, "wheat") == 8 then
			return
		end
		
		-- check if on wet soil
		pos.y = pos.y-1
		local n = minetest.get_node(pos)
		if minetest.get_item_group(n.name, "soil") < 3 then
			return
		end
		pos.y = pos.y+1
		
		-- check light
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) < 13 then
			return
		end
		
		-- grow
		local height = minetest.get_item_group(node.name, "wheat") + 1
		minetest.set_node(pos, {name="default:wheat_"..height})
	end
})

--
-- Cotton
--
minetest.register_craftitem("default:seed_cotton", {
	description = "Cotton Seed",
	inventory_image = "farming_cotton_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "default:cotton_1")
	end,
})

minetest.register_craftitem("default:string", {
	description = "String",
	inventory_image = "farming_string.png",
})

minetest.register_craft({
	output = "default:white",
	recipe = {
		{"default:string", "default:string"},
		{"default:string", "default:string"},
	}
})

for i=1,8 do
	local drop = {
		items = {
			{items = {'default:string'},rarity=9-i},
			{items = {'default:string'},rarity=18-i*2},
			{items = {'default:string'},rarity=27-i*3},
			{items = {'default:seed_cotton'},rarity=9-i},
			{items = {'default:seed_cotton'},rarity=18-i*2},
			{items = {'default:seed_cotton'},rarity=27-i*3},
		}
	}
	minetest.register_node("default:cotton_"..i, {
		drawtype = "plantlike",
		tiles = {"farming_cotton_"..i..".png"},
		paramtype = "light",
		waving = 1,
		walkable = false,
		buildable_to = true,
		is_ground_content = true,
		drop = drop,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
		groups = {snappy=3,flammable=2,plant=1,cotton=i,not_in_creative_inventory=1,attached_node=1},
		sounds = default.node_sound_leaves_defaults(),
	})
end

minetest.register_abm({
	nodenames = {"group:cotton"},
	neighbors = {"group:soil"},
	interval = 80,
	chance = 2,
	action = function(pos, node)
		-- return if already full grown
		if minetest.get_item_group(node.name, "cotton") == 8 then
			return
		end
		
		-- check if on wet soil
		pos.y = pos.y-1
		local n = minetest.get_node(pos)
		if minetest.get_item_group(n.name, "soil") < 3 then
			return
		end
		pos.y = pos.y+1
		
		-- check light
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) < 13 then
			return
		end
		
		-- grow
		local height = minetest.get_item_group(node.name, "cotton") + 1
		minetest.set_node(pos, {name="default:cotton_"..height})
	end
})

minetest.register_craftitem("default:tomato_seed", {
	description = "Tomato Seeds",
	inventory_image = "farming_tomato_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "default:tomato_1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})

minetest.register_node("default:tomato_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_tomato_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:tomato_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_tomato_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:tomato_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_tomato_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:tomato", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_tomato_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'default:tomato_seed'} },
			{ items = {'default:tomato_seed'}, rarity = 2},
			{ items = {'default:tomato_seed'}, rarity = 5},
			{ items = {'default:tomato_item'} },
			{ items = {'default:tomato_item'}, rarity = 2 },
			{ items = {'default:tomato_item'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("default:tomato_item", {
	description = "Tomato",
	inventory_image = "farming_tomato.png",
	on_use = minetest.item_eat(4),
})

farming:add_plant("default:tomato", {"default:tomato_1", "default:tomato_2", "default:tomato_3"}, 50, 20)
