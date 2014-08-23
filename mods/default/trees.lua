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
        local hight = pr:next(4, 5)
        for tree_h = 0, hight-1 do  -- add the trunk
                local area_t = a:index(pos.x, pos.y+tree_h, pos.z)  --set area for tree
                        if data[area_t] ~= c_air then    --sets if not air
                                data[area_t] = c_tree    --add tree now
                        end
                end
        end
        for x_area = -2, 2 do
        for y_area = -1, 2 do
        for z_area = -2, 2 do
                if pr:next(1,10) ~= 3 then  --randomize leaves
                        local area_l = a:index(pos.x+x_area, pos.y+tree_h+y_area, pos.z+z_area)  --sets area for leaves
                        if data[area_l] ~= c_air or data[area_l] ~= c_ignore then    --sets if not air or ignore
                                if is_apple_tree == true and pr:next(1, 100) <=  10 then  --randomize apples
                                        data[area_l] = c_apple  --add apples now
                                else 
                                        data[area_l] = c_leaves    --add leaves now
                                end
                        end
                end       
        end
        end
        end

        --[[
        local pr = PseudoRandom(seed)
        local th = pr:next(4, 9)
        local x, y, z = pos.x, pos.y, pos.z
        local ln = 30
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
                if th == 5 then
                        leaves_a = VoxelArea:new{MinEdge={x=-2, y=-2, z=-2}, MaxEdge={x=2, y=2, z=2}}
                elseif th == 4 then
                        leaves_a = VoxelArea:new{MinEdge={x=-2, y=-1, z=-2}, MaxEdge={x=2, y=2, z=2}}
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
end]]--

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
	local c_actree = minetest.get_content_id("default:acaciatree_gen")  --trunk
	local c_actree2 = minetest.get_content_id("default:acaciatree_t")  --limbs
	local c_acleaf = minetest.get_content_id("default:acacialeaves")  --leaves
	local xa = pos.x
	local ya = pos.y
	local za = pos.z

	for j = -3, 9 do  --j is the y axis level of the tree
                local pr = PseudoRandom(seed)
                local th = pr:next(0, 2)  --adds 0-2 to the hight of the tree
                if j > 7 + th then return end  --if y is not in the trees range 
                if j == 7 + th then  --the top layer of leaves
                        for i = -3, 3 do  --sets size of the layer
                        for k = -3, 3 do  --sets size of the layer
                                if math.abs(i) + math.abs(k) ~= 6 then --makes the corners rounded off
                                        if math.random(15) ~= 11 then  --adds leaves at random
                                                local vil = a:index(xa + i, ya + j + th, za + k) --set area for leaves
                                                if data[vil] == c_air or data[vil] == c_ignore then  --set only if air or ignore
                                                        data[vil] = c_acleaf  --add leaves now
                                                end
                                        end
                                end
                        end
                        end
		elseif j == 6 + th then  --second layer of leaves
			for i = -5, 5 do  --sets size of the layer
			for k = -5, 5 do  --sets size of the layer
                                if math.abs(i) + math.abs(k) ~= 10 and math.abs(i) + math.abs(k) ~= 9 then  --makes the corners rounded off
                                        if math.random(15) ~= 2 then  --adds leaves at random
                                                local vil1 = a:index(xa + i, ya + j +th, za + k)  --set area for leaves
                                                if data[vil1] == c_air or data[vil1] == c_ignore then  --set only if air or ignore
                                                        data[vil1] = c_acleaf  --add leaves now
                                                end
                                        end
                                end
			end
			end
		elseif j == 5 +th then  --first layer of wood third of leaves
			for i = -6, 6 do  --sets size of the layer
			for k = -6, 6 do  --sets size of the layer
                        for i2 = -2, 2, 4 do  --sets size of the layer-wood
                        for k2 = -2, 2, 4 do  --sets size of the layer-wood
                        for i3 = -3, 3, 6 do  --sets size of the layer-wood
                        for k3 = -3, 3, 6 do  --sets size of the layer-wood
                                if math.abs(i) == 6 and math.abs(i) + math.abs(k) ~= 12 and math.abs(i) + math.abs(k) ~= 11  --makes the outer rim of leaves
                                or math.abs(k) == 6 and math.abs(i) + math.abs(k) ~= 12 and math.abs(i) + math.abs(k) ~= 11  --makes the outer rim of leaves
                                or math.abs(i) == 5 and math.abs(k) == 5  --makes the outer rim of leaves
                                or math.abs(i) == 5 and math.abs(k) == 4  --makes the outer rim of leaves
                                or math.abs(i) == 4 and math.abs(k) == 5 then  --makes the outer rim of leaves
                                        local vil2 = a:index(xa + i, ya + j +th, za + k)  --set area for leaves
                                        if data[vil2] == c_air or data[vil2] == c_ignore then  --set only if air or ignore
                                                data[vil2] = c_acleaf  --add leaves now
                                        end
                                end
				local vit = a:index(xa + i2, ya + j + th, za + k2)  --sets area for wood
                                if data[vit] == c_air or data[vit] == c_ignore or data[vit] == c_acleaf then --set only if air, leaves or ignore
                                        data[vit] = c_actree2  --add wood now
                                end
                                local vit2 = a:index(xa + i3, ya + j + th, za + k3)  --sets area for wood
                                if data[vit2] == c_air or data[vit2] == c_ignore or data[vit2] == c_acleaf then --set only if air, leaves or ignore
                                        data[vit2] = c_actree2  --add wood now
                                end
			end
			end
                        end
                        end
                        end
                        end
		elseif j == 4 + th then  --second layer of wood
			for i = -1, 1 do  --sets size of the layer
			for k = -1, 1 do  --sets size of the layer
				if math.abs(i) + math.abs(k) == 2 then  --makes the patern of wood
					local vit3 = a:index(xa + i, ya + j + th, za + k)  --set area for wood
					if data[vit3] == c_air or data[vit3] == c_ignore or data[vit3] == c_acleaf or data[vit3] then --set only if air, leaves or ignore
                                                data[vit3] = c_actree2  --add wood now
                                        end
				end
			end
			end
		elseif j <= -1  then  --layer for roots
			local vit4 = a:index(xa, ya + j , za)  --set area for wood
                        if data[vit4] ~= c_air then  --sets if not air
                                data[vit4] = c_actree2  --add wood now
                        end
                else
                        for t = 0, th do  --layer for main trunk 
                                local vit5 = a:index(xa, ya + j + t , za)  --set area for wood
                                if data[vit5] == c_air or data[vit5] == c_ignore or data[vit5] == c_acleaf then --set only if air, leaves or ignore
                                        data[vit5] = c_actree  --add wood now
                                end
                        end
		end
	end
end

