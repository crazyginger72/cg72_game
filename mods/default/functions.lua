-- mods/default/functions.lua

--
-- Sounds
--

function default.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="", gain=1.0}
	table.dug = table.dug or
			{name="default_dug_node", gain=0.25}
	table.place = table.place or
			{name="default_place_node_hard", gain=1.0}
	return table
end

function default.node_sound_stone_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_hard_footstep", gain=0.5}
	table.dug = table.dug or
			{name="default_hard_footstep", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_dirt_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_dirt_footstep", gain=1.0}
	table.dug = table.dug or
			{name="default_dirt_footstep", gain=1.5}
	table.place = table.place or
			{name="default_place_node", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_sand_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_sand_footstep", gain=0.5}
	table.dug = table.dug or
			{name="default_sand_footstep", gain=1.0}
	table.place = table.place or
			{name="default_place_node", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_wood_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_wood_footstep", gain=0.5}
	table.dug = table.dug or
			{name="default_wood_footstep", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_leaves_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_grass_footstep", gain=0.35}
	table.dug = table.dug or
			{name="default_grass_footstep", gain=0.85}
	table.dig = table.dig or
			{name="default_dig_crumbly", gain=0.4}
	table.place = table.place or
			{name="default_place_node", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_glass_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_glass_footstep", gain=0.5}
	table.dug = table.dug or
			{name="default_break_glass", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

--
-- Legacy
--

function default.spawn_falling_node(p, nodename)
	spawn_falling_node(p, nodename)
end

-- Horrible crap to support old code
-- Don't use this and never do what this does, it's completely wrong!
-- (More specifically, the client and the C++ code doesn't get the group)
function default.register_falling_node(nodename, texture)
	minetest.log("error", debug.traceback())
	minetest.log('error', "WARNING: default.register_falling_node is deprecated")
	if minetest.registered_nodes[nodename] then
		minetest.registered_nodes[nodename].groups.falling_node = 1
	end
end

--
-- Global callbacks
--

-- Global environment step function
function on_step(dtime)
	-- print("on_step")
end
minetest.register_globalstep(on_step)

function on_placenode(p, node)
	--print("on_placenode")
end
minetest.register_on_placenode(on_placenode)

function on_dignode(p, node)
	--print("on_dignode")
end
minetest.register_on_dignode(on_dignode)

function on_punchnode(p, node)
end
minetest.register_on_punchnode(on_punchnode)


--
-- Grow trees
--

minetest.register_abm({
	nodenames = {"default:sapling"},
	interval = 10,
	chance = 35,
	action = function(pos, node)
		local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_soil = minetest.get_item_group(nu, "soil")
		if is_soil == 0 then
			return
		end
		
		minetest.log("action", "A sapling grows into a tree at "..minetest.pos_to_string(pos))
		local vm = minetest.get_voxel_manip()
		local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
		local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		local data = vm:get_data()
		default.grow_tree(data, a, pos, math.random(1, 8) == 1, math.random(1,100000))
		vm:set_data(data)
		vm:write_to_map(data)
		vm:update_map()
	end
})

minetest.register_abm({
	nodenames = {"default:sapling_apple"},
	interval = 10,
	chance = 20,
	action = function(pos, node)
		local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_soil = minetest.get_item_group(nu, "soil")
		if is_soil == 0 then
			return
		end
		
		minetest.log("action", "A apple sapling grows into a tree at "..minetest.pos_to_string(pos))
		local vm = minetest.get_voxel_manip()
		local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
		local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		local data = vm:get_data()
		default.grow_tree(data, a, pos, true, math.random(1,100000))
		vm:set_data(data)
		vm:write_to_map(data)
		vm:update_map()
	end
})

minetest.register_abm({
	nodenames = {"default:junglesapling"},
	interval = 10,
	chance = 35,
	action = function(pos, node)
		local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_soil = minetest.get_item_group(nu, "soil")
		if is_soil == 0 then
			return
		end
		
		minetest.log("action", "A jungle sapling grows into a tree at "..minetest.pos_to_string(pos))
		local vm = minetest.get_voxel_manip()
		local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y-1, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
		local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		local data = vm:get_data()
		default.grow_jungletree(data, a, pos, math.random(1,100000))
		vm:set_data(data)
		vm:write_to_map(data)
		vm:update_map()
	end
})

minetest.register_abm({
	nodenames = {"default:acaciasapling"},
	interval = 10,
	chance = 35,
	action = function(pos, node)
		local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_sand = minetest.get_item_group(nu, "sand")
		if is_sand == 0 then
			return
		end
		minetest.remove_node(pos)
		minetest.log("action", "A acacia sapling grows into a tree at "..minetest.pos_to_string(pos))
		local vm = minetest.get_voxel_manip()
		local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y-1, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
		local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		local data = vm:get_data()
		default.grow_acaciatree(data, a, pos, math.random(1,100000))
		vm:set_data(data)
		vm:write_to_map(data)
		vm:update_map()
	end
})

--
-- Lavacooling
--


default.cool_lava_source = function(pos)
	if minetest.find_node_near(pos, 1, "default:water_source")
	or minetest.find_node_near(pos, 1, "default:water_flowing")
	or minetest.find_node_near(pos, 1, "default:mud_source")
	or minetest.find_node_near(pos, 1, "default:mud_flowing")
	or minetest.find_node_near(pos, 1, "default:mud_with_grass_source")
	or minetest.find_node_near(pos, 1, "default:mud_with_grass_flowing") then
		minetest.set_node(pos, {name="default:obsidian_cooled"})
	end
end

default.cool_lava_flowing = function(pos)
	if minetest.find_node_near(pos, 1, "default:water_source") 
	or minetest.find_node_near(pos, 1, "default:mud_source")
	or minetest.find_node_near(pos, 1, "default:mud_with_grass_source") then
		minetest.set_node(pos, {name="default:basalt_cooled"})
	elseif minetest.find_node_near(pos, 1, "default:water_flowing")
	or minetest.find_node_near(pos, 1, "default:mud_flowing") 
	or minetest.find_node_near(pos, 1, "default:mud_with_grass_flowing") then
		minetest.set_node(pos, {name="default:pumice_cooled"})
	end
end

minetest.register_abm({
	nodenames = {"default:lava_flowing"},
	neighbors = {"group:water", "group:mud"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		default.cool_lava_flowing(pos, node, active_object_count, active_object_count_wider)
	end,
})

minetest.register_abm({
	nodenames = {"default:lava_source"},
	neighbors = {"group:water", "group:mud"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		default.cool_lava_source(pos, node, active_object_count, active_object_count_wider)
	end,
})

--
-- Papyrus and cactus growing
--

minetest.register_abm({
	nodenames = {"default:cactus"},
	neighbors = {"group:sand"},
	interval = 50,
	chance = 20,
	action = function(pos, node)
		pos.y = pos.y-1
		local name = minetest.get_node(pos).name
		if minetest.get_item_group(name, "sand") ~= 0 then
			pos.y = pos.y+1
			local height = 0
			while minetest.get_node(pos).name == "default:cactus" and height < 4 do
				height = height+1
				pos.y = pos.y+1
			end
			if height < 4 then
				if minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name="default:cactus"})
				end
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"default:papyrus"},
	neighbors = {"default:dirt", "default:dirt_with_grass"},
	interval = 50,
	chance = 20,
	action = function(pos, node)
		pos.y = pos.y-1
		local name = minetest.get_node(pos).name
		if name == "default:dirt" or name == "default:dirt_with_grass" then
			if minetest.find_node_near(pos, 3, {"group:water"}) == nil then
				return
			end
			pos.y = pos.y+1
			local height = 0
			while minetest.get_node(pos).name == "default:papyrus" and height < 4 do
				height = height+1
				pos.y = pos.y+1
			end
			if height < 4 then
				if minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name="default:papyrus"})
				end
			end
		end
	end,
})
--
--mushrooms growing :D
--[[

minetest.register_abm({
    nodenames = {"default:dirt", "default:dirt_with_grass"},
    interval = 10,
    chance = 1000,
    action = function(pos, node)
        local destnode = { x = pos.x, y = pos.y+1, z = pos.z}
        local name = minetest.get_node(destnode).name       
        local nodedef = minetest.registered_nodes[name]
        
        if not nodedef then
            return
        end

        if minetest.find_node_near(pos, math.random(2, 5), "default:mycena") then
        	 return
        end

        if minetest.find_node_near(destnode, math.random(1, 5), "default:jungletree") then
            if name == "air" then
                minetest.set_node(destnode, {name = "default:mycena"})
            end
        end
    end
})


minetest.register_abm({
    nodenames = {"default:dirt", "default:dirt_with_grass" , "default:sand"},
    interval = 15,
    chance = 700,
    action = function(pos, node)
        local destnode = { x = pos.x, y = pos.y+1, z = pos.z}
        local name = minetest.get_node(destnode).name       
        local nodedef = minetest.registered_nodes[name]
        
        if not nodedef then
            return
        end

        if not minetest.find_node_near(destnode, math.random(1, 3), "default:water_source") then
        	 return
        end

        if not minetest.find_node_near(pos, math.random(10, 20), "default:mushie_1") then
	
            if name == "air" then
                minetest.set_node(destnode, {name = "default:mushie_1"})
            end
        end
    end
})

minetest.register_abm({
    nodenames = {"default:dirt", "default:dirt_with_grass" , "default:sand"},
    interval = 9,
    chance = 700,
    action = function(pos, node)
        local destnode = { x = pos.x, y = pos.y+1, z = pos.z}
        local name = minetest.get_node(destnode).name       
        local nodedef = minetest.registered_nodes[name]
        
        if not nodedef then
            return
        end

        if minetest.find_node_near(pos, math.random(2, 5), "default:mushie_1") then
        	 return
        end

        if minetest.find_node_near(destnode, math.random(1, 3), "default:water_flowing") then
            if name == "air" then
                minetest.set_node(destnode, {name = "default:mushie_1"})
            end
        end
    end
})

minetest.register_abm({
    nodenames = {"default:sand"},
    interval = 30,
    chance = 1000,
    action = function(pos, node)
        local name = minetest.get_node(pos).name
        local nodedef = minetest.registered_nodes[name]
        
        if not nodedef then
            return
        end

        local pos0 = { x = pos.x-3, y = pos.y-3, z = pos.z-3 }
        local pos1 = { x = pos.x+3, y = pos.y+3, z = pos.z+3 }
        local pos2 = { x = pos.x-1, y = pos.y, z = pos.z-1 }
        local pos3 = { x = pos.x+1, y = pos.y, z = pos.z+1 }
        local above = 0
        local above2 = 0
        local count
        local count2
        local count3
        count = minetest.find_nodes_in_area(pos0, pos1, "default:lum_sand")
        count2 = minetest.find_nodes_in_area(pos2, pos3, "default:water_source")
        count3 = minetest.find_nodes_in_area(pos2, pos3, "default:lum_sand")
        if #count == 0 then -- if waterbody not inoculated
            count = minetest.find_nodes_in_area(pos0, pos1, "default:water_source")
            if #count < 9 then -- not enough water
                return
            end
        end

	if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "default:water_source" or minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then 
		above = 1
	   else
 		above = 0	
        end

        if minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "default:water_source" then
		above2 = 1
	   else
 		above2 = 0	
        end
        
	if above == 1 and above2 == 1 and #count2 >= 1 and minetest.find_node_near(pos, 1, "default:water_source") then
        minetest.set_node(pos, {name = "default:lum_sand"})

	end

	if above2 == 1 and #count3 >= 1 and minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "default:water_source" then
        minetest.set_node(pos, {name = "default:lum_sand"})

        end
    end
})]]--



--
-- Leafdecay
--

-- To enable leaf decay for a node, add it to the "leafdecay" group.
--
-- The rating of the group determines how far from a node in the group "tree"
-- the node can be without decaying.
--
-- If param2 of the node is ~= 0, the node will always be preserved. Thus, if
-- the player places a node of that kind, you will want to set param2=1 or so.
--
-- If the node is in the leafdecay_drop group then the it will always be dropped
-- as an item

default.leafdecay_trunk_cache = {}
default.leafdecay_enable_cache = true
-- Spread the load of finding trunks
default.leafdecay_trunk_find_allow_accumulator = 0

minetest.register_globalstep(function(dtime)
	local finds_per_second = 5000
	default.leafdecay_trunk_find_allow_accumulator =
			math.floor(dtime * finds_per_second)
end)

minetest.register_abm({
	nodenames = {"group:leafdecay"},
	neighbors = {"air", "group:liquid"},
	-- A low interval and a high inverse chance spreads the load
	interval = 5,
	chance = 7,
	action = function(p0, node, _, _)
		--print("leafdecay ABM at "..p0.x..", "..p0.y..", "..p0.z..")")
		local do_preserve = false
		local d = minetest.registered_nodes[node.name].groups.leafdecay
		if not d or d == 0 then
			--print("not groups.leafdecay")
			return
		end
		local n0 = minetest.get_node(p0)
		if n0.param2 ~= 0 then
			--print("param2 ~= 0")
			return
		end
		local p0_hash = nil
		if default.leafdecay_enable_cache then
			p0_hash = minetest.hash_node_position(p0)
			local trunkp = default.leafdecay_trunk_cache[p0_hash]
			if trunkp then
				local n = minetest.get_node(trunkp)
				local reg = minetest.registered_nodes[n.name]
				-- Assume ignore is a trunk, to make the thing work at the border of the active area
				if n.name == "ignore" or (reg and reg.groups.tree and reg.groups.tree ~= 0) then
					--print("cached trunk still exists")
					return
				end
				--print("cached trunk is invalid")
				-- Cache is invalid
				table.remove(default.leafdecay_trunk_cache, p0_hash)
			end
		end
		if default.leafdecay_trunk_find_allow_accumulator <= 0 then
			return
		end
		default.leafdecay_trunk_find_allow_accumulator =
				default.leafdecay_trunk_find_allow_accumulator - 1
		-- Assume ignore is a trunk, to make the thing work at the border of the active area
		local p1 = minetest.find_node_near(p0, d, {"ignore", "group:tree"})
		if p1 then
			do_preserve = true
			if default.leafdecay_enable_cache then
				--print("caching trunk")
				-- Cache the trunk
				default.leafdecay_trunk_cache[p0_hash] = p1
			end
		end
		if not do_preserve then
			-- Drop stuff other than the node itself
			itemstacks = minetest.get_node_drops(n0.name)
			for _, itemname in ipairs(itemstacks) do
				if minetest.get_item_group(n0.name, "leafdecay_drop") ~= 0 or
						itemname ~= n0.name then
					local p_drop = {
						x = p0.x - 0.5 + math.random(),
						y = p0.y - 0.5 + math.random(),
						z = p0.z - 0.5 + math.random(),
					}
					minetest.add_item(p_drop, itemname)
				end
			end
			-- Remove node
			minetest.remove_node(p0)
			nodeupdate(p0)
		end
	end
})

minetest.register_abm({
	nodenames = {"group:treedecay"},
	neighbors = {"air", "group:liquid", "group:leaves"},
	interval = 5,
	chance = 2,

	action = function(pos, node, _, _)
		local pos1 = {x=pos.x, y=pos.y-1, z=pos.z}
		local node = minetest.get_node(pos)
		local node_under = minetest.get_node(pos1)
		local decay = minetest.registered_nodes[node.name].groups.treedecay
		local nodes_around = minetest.find_node_near(pos, decay, {"ignore", "group:tree"})
		if not decay or decay == 0 then
			return
		elseif decay ~= 1 and nodes_around then
			return
		else
		if  minetest.get_node(pos1).name == "default:dirt"           or minetest.get_node(pos1).name == "default:dirt_with_grass" or 
			minetest.get_node(pos1).name == "default:dirt_with_snow" or minetest.get_node(pos1).name == "default:sand" or 
			minetest.get_node(pos1).name == "default:tree"           or minetest.get_node(pos1).name == "default:tree_gen" or 
			minetest.get_node(pos1).name == "default:jungletree"     or minetest.get_node(pos1).name == "default:jungletree_gen" or
			minetest.get_node(pos1).name == "default:acaciatree"     or minetest.get_node(pos1).name == "default:acaciatree_gen" or
			minetest.get_node(pos1).name == "default:acaciatree_t"   or 
			minetest.get_node(pos1).name == "default:desert_sand"    or minetest.get_item_group(node_under.name, "tree") > 0 then
			return
		else
			itemstacks = minetest.get_node_drops(node.name)
			for _, itemname in ipairs(itemstacks) do
				if minetest.get_item_group(node.name, "treedecay_drop") ~= 0 or
						itemname ~= node.name then
					local p_drop = {
						x = pos.x - 0.5 + math.random(),
						y = pos.y - 0.5 + math.random(),
						z = pos.z - 0.5 + math.random(),
					}
					minetest.add_item(p_drop, itemname)
				end
			end
			minetest.remove_node(pos)
			nodeupdate(pos)
		end
		end
	end
})

local mossyobjects = {
	{ "cobble", 	 "mossycobble" },
	{ "stonebrick",  "stone_brick_mossy" },
	{ "stone", 		 "stone_mossy" },
	{ "cobble_road", "cobble_road_mossy"},
}


for i in ipairs(mossyobjects) do

minetest.register_alias("gloopblocks:"..mossyobjects[i][2], "default:"..mossyobjects[i][2])

	minetest.register_abm({
		nodenames = { "default"..mossyobjects[i][1] },
		neighbors = {"default:water_source",          "default:water_flowing",
					 "default:mud_source",            "default:mud_flowing",
					 "default:mud_with_grass_source", "default:mud_with_grass_flowing"},
		interval = 120,
		chance = 50,
		action = function(pos, node)
			if minetest.find_node_near(pos, 2, "air") then
				local fdir = node.param2
				minetest.add_node(pos, {name = "default"..mossyobjects[i][2], param2 = fdir})
			end
		end,
	})
end
