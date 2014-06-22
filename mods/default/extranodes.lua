minetest.register_node("default:asphalt",{
	description	= "Asphalt",
	tiles	= {"default_asphalt.png"},
	groups	= {cracky=3}
})

minetest.register_node("default:steel_support",{
	description = "Steel support",
	tiles = {"default_support.png"},
	groups = {cracky = 1},
	drawtype = "glasslike_framed",
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
})

minetest.register_node("default:streetlamp_basic_bottom",{
	drop = "",
	description = "Street lamp",
	tiles = {"default_lamps_basic_bottom.png"},
	inventory_image = "default_lamps_basi_inv.png",
	groups = {cracky = 1},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.15,-0.5,-0.15,0.15,0.4,0.15},
			{-0.1,0.4,-0.1,0.1,0.5,0.1}
		}
	},
	pointable = false,
	after_place_node = function(pos,placer,itemstack)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "default:streetlamp_basic_middle"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "default:streetlamp_basic_top_on"})
		-- minetest.set_node({x = pos.x, y = pos.y - 2, z = pos.z},{name = "default:streetlamp_basic_controller"})
	end
})
minetest.register_node("default:streetlamp_basic_middle",{
	drop = "",
	description = "U cheater U",
	groups = {cracky = 1, not_in_creative_inventory = 1},
	tiles = {"default_lamps_basic_middle.png"},
	paramtype = "light",
	drawtype = "nodebox",
	pointable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,0.5,0.1}
		}
	}
})

minetest.register_node("default:streetlamp_basic_top_on",{
	drop = "default:streetlamp_basic_bottom",
	description = "U cheater U",
	groups = {cracky = 1, not_in_creative_inventory = 1},
	tiles = {"default_lamps_basic_top_top.png","default_lamps_basic_top_top.png","default_lamps_basic_top.png","default_lamps_basic_top.png","default_lamps_basic_top.png","default_lamps_basic_top.png"},
	paramtype = "light",
	drawtype = "nodebox",
	light_source = 15,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.1,0.1,-0.4,0.1},
			{-0.3,-0.4,-0.3,0.3,0.5,0.3}
		}
	},
	selection_box = 	{
		type = "fixed",
		fixed = {
			{-0.3,0.5,-0.3,0.3,-2.5,0.3},
		}
	},
	after_dig_node = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z})
		minetest.remove_node({x = pos.x, y = pos.y - 2, z = pos.z})
	end
})

minetest.register_node("default:concrete",{
		description = "Concrete",
		tiles = {"default_concrete.png"},
		groups = {cracky=2}
})
minetest.register_node("default:concrete_wall",{		description = "Conrete wall",
	tiles = {"default_concrete.png"},				groups = {cracky=2},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.5, 0.4, -0.4, 0.5},
			{-0.1, -0.4, -0.5, 0.1, 0.5, 0.5}
		}
	}
})
minetest.register_craft({
	output = "default:concrete_wall 3",
	recipe = {
		{"","default:concrete",""},
		{"","default:concrete",""},
	{"default:concrete","default:concrete","default:concrete"}
	}
})
minetest.register_node("default:concrete_wall_flat",{
	description = "Conrete wall",
	tiles = {"default_concrete.png"},
	groups = {cracky=2},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1, -0.5, -0.5, 0.1, 0.5, 0.5}
		}
	}
})
