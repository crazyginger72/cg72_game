local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")
local c_tree = minetest.get_content_id("default:tree_gen")
local c_aleaves = minetest.get_content_id("default:leaves_apple")
local c_leaves = minetest.get_content_id("default:leaves")
local c_apple = minetest.get_content_id("default:apple")

function default.grow_tree(data, a, pos, is_apple_tree, seed)
        --[[
                NOTE: Tree-placing code is currently duplicated in the engine
                and in games that have saplings; both are deprecated but not
                replaced yet
        ]]--
        local pr = PseudoRandom(seed)
        local th = pr:next(4, 8)
        local x, y, z = pos.x, pos.y, pos.z
        local ln = 11
        local leaves_buffer = {}
        local leaves_a = nil
        for yy = y, y+th-1 do
                local vi = a:index(x, yy, z)
                if a:contains(x, yy, z) and (data[vi] == c_air or yy == y) then
                        data[vi] = c_tree
                end
        end
        if is_apple_tree == true then 
                th = 5
                ln = 100
                y = y+th-1 -- (x, y, z) is now last piece of trunk
                leaves_a = VoxelArea:new{MinEdge={x=-3, y=-2, z=-3}, MaxEdge={x=3, y=3, z=3}}
        else
              y = y+th-1 -- (x, y, z) is now last piece of trunk
                leaves_a = VoxelArea:new{MinEdge={x=-2, y=-3, z=-2}, MaxEdge={x=2, y=2, z=2}}
                if th <= 6 then
                        leaves_a = VoxelArea:new{MinEdge={x=-2, y=-2, z=-2}, MaxEdge={x=2, y=2, z=2}}
                end  
        end

        -- Force leaves near the trunk
        local d = 1
        for xi = -d, d do
        for yi = -d, d do
        for zi = -d, d do
                leaves_buffer[leaves_a:index(xi, yi, zi)] = true
        end
        end
        end
        
        -- Add leaves randomly
        for iii = 1, ln do
                local d = 1
                local xx = pr:next(leaves_a.MinEdge.x, leaves_a.MaxEdge.x - d)
                local yy = pr:next(leaves_a.MinEdge.y, leaves_a.MaxEdge.y - d)
                local zz = pr:next(leaves_a.MinEdge.z, leaves_a.MaxEdge.z - d)
                
                for xi = 0, d do
                for yi = 0, d do
                for zi = 0, d do
                        leaves_buffer[leaves_a:index(xx+xi, yy+yi, zz+zi)] = true
                end
                end
                end
        end
        
        -- Add the leaves
        for xi = leaves_a.MinEdge.x, leaves_a.MaxEdge.x do
        for yi = leaves_a.MinEdge.y, leaves_a.MaxEdge.y do
        for zi = leaves_a.MinEdge.z, leaves_a.MaxEdge.z do
                if a:contains(x+xi, y+yi, z+zi) then
                        local vi = a:index(x+xi, y+yi, z+zi)
                        if data[vi] == c_air or data[vi] == c_ignore then
                                if leaves_buffer[leaves_a:index(xi, yi, zi)] then
                                        if is_apple_tree == true and pr:next(1, 40) <=  15 then
                                                data[vi] = c_apple
                                        elseif is_apple_tree ==true then
                                                data[vi] = c_aleaves
                                        else
                                                data[vi] = c_leaves
                                        end
                                end
                        end
                end
        end
        end
        end
end

local c_jungletree = minetest.get_content_id("default:jungletree_gen")
local c_jungleleaves = minetest.get_content_id("default:jungleleaves")

function default.grow_jungletree(data, a, pos, seed)
        --[[
                NOTE: Tree-placing code is currently duplicated in the engine
                and in games that have saplings; both are deprecated but not
                replaced yet
        ]]--
        local pr = PseudoRandom(seed)
        local x, y, z = pos.x, pos.y, pos.z
        for xi = -1, 1 do
        for zi = -1, 1 do
                if pr:next(1, 3) >= 2 then
                        local vi1 = a:index(x+xi, y, z+zi)
                        local vi2 = a:index(x+xi, y-1, z+zi)
                        if a:contains(x+xi, y-1, z+zi) and data[vi2] == c_air then
                                data[vi2] = c_jungletree
                        elseif a:contains(x+xi, y, z+zi) and data[vi1] == c_air then
                                data[vi1] = c_jungletree
                        end
                end
        end
        end
        
        local th = pr:next(11, 23)
        for yy = y, y+th-1 do
                local vi = a:index(x, yy, z)
                if a:contains(x, yy, z) and (data[vi] == c_air or data[vi] == c_jungleleaves or yy == y) then
                        data[vi] = c_jungletree
                end
        end
        y = y+th-1 -- (x, y, z) is now last piece of trunk
        local leaves_a = VoxelArea:new{MinEdge={x=-5, y=-6, z=-5}, MaxEdge={x=5, y=3, z=5}}
        local leaves_buffer = {}
        
        -- Force leaves near the trunk
        local d = 1
        for xi = -d, d do
        for yi = -d, d do
        for zi = -d, d do
                leaves_buffer[leaves_a:index(xi, yi, zi)] = true
        end
        end
        end
        
        -- Add leaves randomly
        for iii = 1, 150 do
                local d = 1
                local xx = pr:next(leaves_a.MinEdge.x, leaves_a.MaxEdge.x - d)
                local yy = pr:next(leaves_a.MinEdge.y, leaves_a.MaxEdge.y - d)
                local zz = pr:next(leaves_a.MinEdge.z, leaves_a.MaxEdge.z - d)
                
                for xi = 0, d do
                for yi = 0, d do
                for zi = 0, d do
                        leaves_buffer[leaves_a:index(xx+xi, yy+yi, zz+zi)] = true
                end
                end
                end
        end
        
        -- Add the leaves
        for xi = leaves_a.MinEdge.x, leaves_a.MaxEdge.x do
        for yi = leaves_a.MinEdge.y, leaves_a.MaxEdge.y do
        for zi = leaves_a.MinEdge.z, leaves_a.MaxEdge.z do
                if a:contains(x+xi, y+yi, z+zi) then
                        local vi = a:index(x+xi, y+yi, z+zi)
                        if data[vi] == c_air or data[vi] == c_ignore then
                                if leaves_buffer[leaves_a:index(xi, yi, zi)] then
                                        data[vi] = c_jungleleaves
                                end
                        end
                end
        end
        end
        end
end

function default.grow_acaciatree(data, a, pos, seed) --watershed_acaciatree(x, y, z, area, data)
	local c_actree = minetest.get_content_id("default:acaciatree_gen")
	local c_actree2 = minetest.get_content_id("default:acaciatree_t")
	local c_acleaf = minetest.get_content_id("default:acacialeaves")
	local xa = pos.x
	local ya = pos.y
	local za = pos.z

	for j = -3, 9 do
                local pr = PseudoRandom(seed)
                local th = pr:next(0, 2)
                if j > 7 + th then return end
                if j == 7 + th then
                        for i = -3, 3 do 
                        for k = -3, 3 do
                                if math.abs(i) + math.abs(k) ~= 6 then
                                        if math.random(15) ~= 11 then
                                                local vil = a:index(xa + i, ya + j + th, za + k)
                                                if data[vil] == c_air or data[vil] == c_ignore then
                                                        data[vil] = c_acleaf
                                                end
                                        end
                                end
                        end
                        end
		elseif j == 6 + th then
			for i = -5, 5 do
			for k = -5, 5 do
                                if math.abs(i) + math.abs(k) ~= 10 and math.abs(i) + math.abs(k) ~= 9 then 
                                        if math.random(15) ~= 2 then
                                                local vil = a:index(xa + i, ya + j +th, za + k)
                                                if data[vil] == c_air or data[vil] == c_ignore then
                                                        data[vil] = c_acleaf
                                                end
                                        end
                                end
			end
			end
		elseif j == 5 +th then
			for i = -6, 6 do
			for k = -6, 6 do
                        for i2 = -2, 2, 4 do
                        for k2 = -2, 2, 4 do
                        for i3 = -3, 3, 6 do
                        for k3 = -3, 3, 6 do
                                if math.abs(i) == 6 and math.abs(i) + math.abs(k) ~= 12 and math.abs(i) + math.abs(k) ~= 11 
                                or math.abs(k) == 6 and math.abs(i) + math.abs(k) ~= 12 and math.abs(i) + math.abs(k) ~= 11 
                                or math.abs(i) == 5 and math.abs(k) == 5
                                or math.abs(i) == 5 and math.abs(k) == 4
                                or math.abs(i) == 4 and math.abs(k) == 5 then
                                        local vil = a:index(xa + i, ya + j +th, za + k)
                                        if data[vil] == c_air or data[vil] == c_ignore then
                                                data[vil] = c_acleaf
                                        end
                                end
				local vit = a:index(xa + i2, ya + j + th, za + k2)
                                if data[vit] == c_air or data[vit] == c_ignore or data[vit] == c_acleaf then
                                        data[vit] = c_actree2
                                end
                                local vit2 = a:index(xa + i3, ya + j + th, za + k3)
                                if data[vit2] == c_air or data[vit2] == c_ignore or data[vit2] == c_acleaf then
                                        data[vit2] = c_actree2
                                end
			end
			end
                        end
                        end
                        end
                        end
		elseif j == 4 + th then
			for i = -1, 1 do
			for k = -1, 1 do
				if math.abs(i) + math.abs(k) == 2 then
					local vit = a:index(xa + i, ya + j + th, za + k)
					if data[vit] == c_air or data[vit] == c_ignore or data[vit] == c_acleaf or data[vit] then
                                                data[vit] = c_actree2
                                        end
				end
			end
			end
		elseif j <= -1  then 
			local vit = a:index(xa, ya + j , za)
                        if data[vit] ~= c_air then
                                data[vit] = c_actree2
                        end
                else
                        for t = 0, th do 
                                local vit = a:index(xa, ya + j + t , za)
                                if data[vit] == c_air or data[vit] == c_ignore or data[vit] == c_acleaf then
                                        data[vit] = c_actree
                                end
                        end
		end
	end
end

