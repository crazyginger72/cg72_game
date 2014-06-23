minetest.register_craftitem("default:plastic_sheeting", {
        description = S("Plastic sheet"),
        inventory_image = "homedecor_plastic_sheeting.png",
})

minetest.register_craftitem("default:plastic_base", {
        description = S("Unprocessed Plastic base"),
        wield_image = "homedecor_plastic_base.png",
        inventory_image = "homedecor_plastic_base_inv.png",
})

minetest.register_craft({
    type = "shapeless",
    output = "default:plastic_base 4",
    recipe = {
		"group:leaves",
		"group:leaves",
		"group:leaves",
		"group:leaves",
		"group:leaves",
		"group:leaves"
	}
})

minetest.register_craft({
        type = "cooking",
        output = "default:plastic_sheeting",
        recipe = "default:plastic_base",
})

minetest.register_craft({
        type = "fuel",
        recipe = "default:plastic_base",
        burntime = 30,
})

minetest.register_craft({
        type = "fuel",
        recipe = "default:plastic_sheeting",
        burntime = 30,
})
