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
    local hight = math.random(4, 9)
    if is_apple_tree == true then
        hight = 5   
        for x_area = -3, 3 do
        for y_area = -2, 3 do
        for z_area = -3, 3 do
            if math.random(1,30) < 23 and math.abs(x_area) + math.abs(z_area) ~= 6 and math.abs(x_area) + math.abs(y_area) ~= 6 and math.abs(z_area) + math.abs(y_area) ~= 6 then  --randomize leaves
                local area_l = a:index(pos.x+x_area, pos.y+hight+y_area-1, pos.z+z_area)  --sets area for leaves
                if data[area_l] ~= c_air or data[area_l] ~= c_ignore then    --sets if not air or ignore
                    if math.random(1, 30) <=  10 then  --randomize apples
                        data[area_l] = c_apple  --add apples now
                    else 
                        data[area_l] = c_aleaves    --add leaves now
                    end
                end
            end       
        end
        end
        end
    else
        for x_area = -2, 2 do
        for y_area = -1, 2 do
        for z_area = -2, 2 do
            if math.random(1,30) < 23 then  --randomize leaves
                local area_l = a:index(pos.x+x_area, pos.y+hight+y_area-1, pos.z+z_area)  --sets area for leaves
                if data[area_l] ~= c_air or data[area_l] ~= c_ignore then    --sets if not air or ignore 
                    data[area_l] = c_leaves    --add leaves now
                end
            end       
        end
        end
        end
    end
    for tree_h = 0, hight-1 do  -- add the trunk
        local area_t = a:index(pos.x, pos.y+tree_h, pos.z)  --set area for tree
        if data[area_t] == c_air or data[area_t] == c_leaves or data[area_t] == c_aleaves or data[area_t] == c_apple then    --sets if air
            data[area_t] = c_tree    --add tree now
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
    local hight = math.random(11, 23)
    for x_area = -5, 5 do
    for y_area = -6, 4 do
    for z_area = -5, 5 do
        if math.random(1,30) < 23 then  --randomize leaves
            local area_l = a:index(pos.x+x_area, pos.y+hight+y_area-1, pos.z+z_area)  --sets area for leaves
            if data[area_l] ~= c_air or data[area_l] ~= c_ignore then    --sets if not air or ignore
                data[area_l] = c_jungleleaves    --add leaves now
            end
         end       
    end
    end
    end
    for tree_h = 0, hight-1 do  -- add the trunk
        local area_t = a:index(pos.x, pos.y+tree_h, pos.z)  --set area for tree
        if data[area_t] == c_air or data[area_t] == c_jungleleaves then    --sets if air
            data[area_t] = c_jungletree    --add tree now
        end
    end
    for roots_x = -1, 1 do
    for roots_z = -1, 1 do
        if math.random(1, 3) >= 2 then  --randomize roots
            if a:contains(pos.x+roots_x, pos.y-1, pos.z+roots_z) and data[a:index(pos.x+roots_x, pos.y-1, pos.z+roots_z)] == c_air then
                data[a:index(pos.x+roots_x, pos.y-1, pos.z+roots_z)] = c_jungletree
            elseif a:contains(pos.x+roots_x, pos.y, pos.z+roots_z) and data[a:index(pos.x+roots_x, pos.y, pos.z+roots_z)] == c_air then
                data[a:index(pos.x+roots_x, pos.y, pos.z+roots_z)] = c_jungletree
            end
        end
    end
    end
end

function default.grow_acaciatree(data, a, pos, seed) --watershed_acaciatree(x, y, z, area, data)
	local c_actree = minetest.get_content_id("default:acaciatree_gen")  --trunk
	local c_actree2 = minetest.get_content_id("default:acaciatree_t")  --limbs
	local c_acleaf = minetest.get_content_id("default:acacialeaves")  --leaves
    local pr = PseudoRandom(seed)
	local xa = pos.x
	local ya = pos.y
	local za = pos.z
	for j = -3, 9 do  --j is the y axis level of the tree
                local th = pr:next(0, 2)  --adds 0-2 to the hight of the tree
                if j > 7 + th then return end  --if y is not in the trees range 
                if j == 7 + th then  --the top layer of leaves
                        for i = -3, 3 do  --sets size of the layer
                        for k = -3, 3 do  --sets size of the layer
                                if math.abs(i) + math.abs(k) ~= 6 then --makes the corners rounded off
                                        if pr:next(15) ~= 11 then  --adds leaves at random
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
                                        if pr:next(15) ~= 2 then  --adds leaves at random
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

