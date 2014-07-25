minetest.register_on_generated(function(minp, maxp, seed)
	if maxp.y >= 2 and minp.y <= 0 then
		-- Generate flowers
		local perlin1 = minetest.get_perlin(436, 3, 0.6, 100)
		-- Assume X and Z lengths are equal
		local divlen = 16
		local divs = (maxp.x-minp.x)/divlen+1;
		for divx=0,divs-1 do
		for divz=0,divs-1 do
			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)
			-- Determine flowers amount from perlin noise
			local grass_amount = math.floor(perlin1:get2d({x=x0, y=z0}) ^ 3 * 9)
			-- Find random positions for flowers based on this random
			local pr = PseudoRandom(seed+456)
			for i=0,grass_amount do
				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)
				-- Find ground level (0...15)
				local ground_y = nil
				for y=30,0,-1 do
					if minetest.get_node({x=x,y=y,z=z}).name ~= "air" then
						ground_y = y
						break
					end
				end
				
				if ground_y then
					local p = {x=x,y=ground_y+1,z=z}
					local nn = minetest.get_node(p).name
					-- Check if the node can be replaced
					if minetest.registered_nodes[nn] and
						minetest.registered_nodes[nn].buildable_to then
						nn = minetest.get_node({x=x,y=ground_y,z=z}).name
						if nn == "default:dirt_with_grass" then
							local flower_choice = pr:next(1, 110) - pr:next(-5,5)
							local flower
							if flower_choice >= 1 and flower_choice <= 13 then
								flower = "default:tulip"
							elseif flower_choice >= 14 and flower_choice <= 23 then
								flower = "default:rose_bush"
							elseif flower_choice >= 24 and flower_choice <= 26 then
								flower = "default:dandelion_yellow"
							elseif flower_choice >= 27 and flower_choice <= 32 then
								flower = "default:dandelion_white"
							elseif flower_choice >= 32 and flower_choice <= 37 then
								flower = "default:geranium"
							elseif flower_choice >= 38 and flower_choice <= 43 then
								flower = "default:viola"
							elseif flower_choice >= 44 and flower_choice <= 50 then
								flower = "default:dasie"
							elseif flower_choice >= 107 and flower_choice <= 108 then
								flower = "default:clover"
							elseif flower_choice >= 109 and flower_choice <= 110 then
								flower = "default:clover_purple"
							end
							if flower == nil then  --by the odd chance minetest takes a shit on this number it won't crash now!
								print("no flower grew, flower_choice ="..flower_choice)
								return
							end
							minetest.set_node(p, {name=flower})
						end
					end
				end
				
			end
		end
		end
	end
end)




-- :D