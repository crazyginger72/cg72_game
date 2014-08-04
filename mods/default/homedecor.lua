

minetest.register_node("default:refrigerator", {
    drawtype = "nodebox",
    description = "Refrigerator",
    tiles = {
        'homedecor_refrigerator.png',
        'homedecor_refrigerator_bottom.png',
        'homedecor_refrigerator.png',
        'homedecor_refrigerator.png',
        'homedecor_refrigerator_back.png',	
        'homedecor_refrigerator_front.png'
    },
    sunlight_propagates = false,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    groups = { snappy = 3 },

        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
        },

    sounds = default.node_sound_wood_defaults(),
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
                "size[10,10]"..
                "list[current_name;main;0,0;10,5;]"..
                "list[current_player;main;1,6;8,4;]")
        meta:set_string("infotext", "Refrigerator")
        local inv = meta:get_inventory()
        inv:set_size("main",50)
    end,

    on_place = function(itemstack, placer, pointed_thing)
        local pos = pointed_thing.above
        if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
            minetest.chat_send_player( placer:get_player_name(), 'Not enough vertical space to place a refrigerator!' )
            return
        end
        return minetest.item_place(itemstack, placer, pointed_thing)
    end,

    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name().." moves stuff in refrigerator at "..minetest.pos_to_string(pos))
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name().." moves stuff to refrigerator at "..minetest.pos_to_string(pos))
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name().." removes stuff from refrigerator at "..minetest.pos_to_string(pos))
    end,
})

minetest.register_node("default:ceiling_paint", {
    description = "Textured Ceiling Paint",
    drawtype = 'signlike',
    tiles = { 'homedecor_ceiling_paint.png' },
    inventory_image = 'homedecor_ceiling_paint_roller.png',
    wield_image = 'homedecor_ceiling_paint_roller.png',
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = false,
    groups = { snappy = 3 },
    sounds = default.node_sound_leaves_defaults(),
        selection_box = { type = "wallmounted", },
})

minetest.register_node("default:kitchen_cabinet", {
    description = "Kitchen Cabinet",
    tiles = { 'homedecor_kitchen_cabinet_top_granite.png',
            'homedecor_kitchen_cabinet_bottom.png',
            'homedecor_kitchen_cabinet_sides.png',
            'homedecor_kitchen_cabinet_sides.png',
            'homedecor_kitchen_cabinet_sides.png',
            'homedecor_kitchen_cabinet_front.png'},
    sunlight_propagates = false,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    groups = { snappy = 3 },
    sounds = default.node_sound_wood_defaults(),
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
            "size[8,8]"..
            "list[current_name;main;0,0;8,3;]"..
            "list[current_player;main;0,4;8,4;]")
        meta:set_string("infotext", "Kitchen Cabinet")
        local inv = meta:get_inventory()
        inv:set_size("main", 24)
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        minetest.log("action", player:get_player_name().." moves stuff in kitchen cabinet at "..minetest.pos_to_string(pos))
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        minetest.log("action", player:get_player_name().." moves stuff to kitchen cabinet at "..minetest.pos_to_string(pos))
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
        minetest.log("action", player:get_player_name().." removes stuff from kitchen cabinet at "..minetest.pos_to_string(pos))
    end,
})


minetest.register_node("default:kitchen_cabinet_half", {  
    drawtype="nodebox",
    description = "Top Kitchen Cabinet",
    tiles = { 'homedecor_kitchen_cabinet_sides.png',
            'homedecor_kitchen_cabinet_bottom.png',
            'homedecor_kitchen_cabinet_sides.png',
            'homedecor_kitchen_cabinet_sides.png',
            'homedecor_kitchen_cabinet_sides.png',
            'homedecor_kitchen_cabinet_front_half.png'},
    sunlight_propagates = false,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
        selection_box = {
                type = "fixed",
                fixed = { -0.5, 0, -0.5, 0.5, 0.5, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, 0, -0.5, 0.5, 0.5, 0.5 }
        },
    groups = { snappy = 3 },
    sounds = default.node_sound_wood_defaults(),
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
                "size[8,7]"..
                "list[current_name;main;1,0;6,2;]"..
                "list[current_player;main;0,3;8,4;]")
        meta:set_string("infotext", "Kitchen Cabinet")
        local inv = meta:get_inventory()
        inv:set_size("main", 12)
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        minetest.log("action", player:get_player_name().." moves stuff in kitchen cabinet at "..minetest.pos_to_string(pos))
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        minetest.log("action", player:get_player_name().." moves stuff to kitchen cabinet at "..minetest.pos_to_string(pos))
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
        minetest.log("action", player:get_player_name().." removes stuff from kitchen cabinet at "..minetest.pos_to_string(pos))
    end,
})

minetest.register_node("default:toilet", {
    description = "Toilet",
    tiles = { "default_marble.png" },
    drawtype = "nodebox",
    sunlight_propagates = false,
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -0.20, -0.50, -0.20,  0.20, -0.45,  0.50, },
            { -0.10, -0.45, -0.10,  0.10,  0.00,  0.50, },
            { -0.30, -0.20, -0.30,  0.30,  0.00,  0.35, },
            { -0.25,  0.00, -0.25,  0.25,  0.05,  0.25, },
            { -0.30,  0.00,  0.30,  0.30,  0.40,  0.50, },
            { -0.05,  0.40,  0.35,  0.05,  0.45,  0.45, },
        },
    },
    drop = "default:toilet",
    groups = {cracky=3,},
    sounds = default.node_sound_stone_defaults(),
    on_punch = function (pos, node, puncher)
        node.name = "default:toilet_open"
        minetest.set_node(pos, node)
    end,
})

minetest.register_node("default:toilet_open", {
    tiles = {
        "fdefault_toilet.png",
        "default_marble.png"
    },
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -0.20, -0.50, -0.20,  0.20, -0.45,  0.50, },
            { -0.10, -0.45, -0.10,  0.10, -0.20,  0.50, },
            { -0.10, -0.20,  0.30,  0.10,  0.00,  0.50, },
            { -0.30, -0.20,  0.10,  0.30,  0.00,  0.35, },
            { -0.30, -0.20, -0.30, -0.10, -0.15,  0.10, },
            { -0.10, -0.20, -0.30,  0.10, -0.15, -0.10, },
            {  0.10, -0.20, -0.30,  0.30, -0.15,  0.10, },
            { -0.30, -0.15, -0.30, -0.20,  0.00,  0.10, },
            { -0.20, -0.15, -0.30,  0.20,  0.00, -0.20, },
            {  0.20, -0.15, -0.30,  0.30,  0.00,  0.10, },
            { -0.25,  0.00,  0.20,  0.25,  0.50,  0.25, },
            { -0.30,  0.00,  0.30,  0.30,  0.40,  0.50, },
        },
    },
    drop = "default:toilet",
    groups = {cracky = 3,},
    sounds = default.node_sound_stone_defaults(),
    on_punch = function (pos, node, puncher)
        node.name = "default:toilet"
        minetest.set_node(pos, node)
        minetest.sound_play("homedecor_toilet_flush", {
            pos=pos,
            max_hear_distance = 5,
            gain = 1,
        })
    end,
})

minetest.register_node("default:speaker", {
    description = "Large Stereo Speaker",
    tiles = { 'homedecor_speaker.png',
            'homedecor_speaker.png',
            'homedecor_speaker.png',
            'homedecor_speaker.png',
            'homedecor_speaker_back.png',
            'homedecor_speaker_front.png'},
    sunlight_propagates = false,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    groups = { snappy = 3 },
    sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:stereo", {
    description = "Stereo Receiver",
    tiles = { 'homedecor_stereo_top.png',
            'homedecor_stereo_bottom.png',
            'homedecor_stereo_right.png',
            'homedecor_stereo_left.png',
            'homedecor_stereo_back.png',
            'homedecor_stereo_front.png'},
    sunlight_propagates = false,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
    groups = { snappy = 3 },
    sounds = default.node_sound_leaves_defaults(),
    on_rightclick = function ( pos, node, clicker, itemstack) 
    node.name = "default:stereo_on";
            minetest.set_node(pos, node);
            nodeupdate(pos)
    end
})

minetest.register_node("default:stereo_on", {
    tiles = { 'homedecor_stereo_top.png',
            'homedecor_stereo_bottom.png',
            'homedecor_stereo_right.png',
            'homedecor_stereo_left.png',
            'homedecor_stereo_back.png',
            'homedecor_stereo_front_on.png'},
    sunlight_propagates = false,
    paramtype = "light",
    paramtype2 = "facedir",
    drop = "default:stereo",
    walkable = true,
    groups = { snappy = 3 },
    sounds = default.node_sound_leaves_defaults(),
    on_rightclick = function ( pos, node, clicker, itemstack) 
    node.name = "default:stereo";
         minetest.set_node(pos, node);
        nodeupdate(pos)
    end
})

minetest.register_node("default:dvd_vcr", {
    description = "DVD and VCR",
    drawtype = "nodebox",
    tiles = {
        "homedecor_dvdvcr_top.png",
        "homedecor_dvdvcr_bottom.png",
        "homedecor_dvdvcr_sides.png",
        "homedecor_dvdvcr_sides.png^[transformFX",
        "homedecor_dvdvcr_back.png",
        "homedecor_dvdvcr_front.png",
    },
    inventory_image = "homedecor_dvdvcr_inv.png",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.3125, -0.5, -0.25, 0.3125, -0.375, 0.1875},
            {-0.25, -0.5, -0.25, 0.25, -0.1875, 0.125},
        }
    },
    groups = { snappy = 3 },
    sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:nightstand", {
    drawtype = "nodebox",
    description = "Nightstand with Two Drawers",
    tiles = { 'default_junglewood.png',
            'default_junglewood.png',
            'default_junglewood.png',
            'default_junglewood.png',
            'default_junglewood.png',
            'default_nightstand.png'},
    sunlight_propagates = false,
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = true,
        node_box = {
                type = "fixed",
        fixed = {
            { -8/16, -8/16, -30/64,  8/16,  8/16,   8/16 }, -- main body
            { -7/16,  1/16, -32/64,  7/16,  7/16, -29/64 }, -- top drawer face
            { -7/16, -7/16, -32/64,  7/16, -1/16, -29/64 }, -- bottom drawer face

        }
        },
    groups = { snappy = 3 },
    sounds = default.node_sound_wood_defaults(),
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
                "size[8,7]"..
                "list[current_name;main;0,0;8,2;]"..
                "list[current_player;main;0,3;8,4;]")
        meta:set_string("infotext", "Two-drawer Nightstand")
        local inv = meta:get_inventory()
        inv:set_size("main", 16)
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        minetest.log("action", "%s moves stuff in nightstand at %s":format(
            player:get_player_name(),
            minetest.pos_to_string(pos)
        ))
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        minetest.log("action", "%s moves stuff to nightstand at %s":format(
            player:get_player_name(),
            minetest.pos_to_string(pos)
        ))
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
        minetest.log("action", "%s takes stuff from nightstand at %s":format(
            player:get_player_name(),
            minetest.pos_to_string(pos)
        ))
    end,
})

-----------------------------------------------------------
-------------------------crafting--------------------------
-----------------------------------------------------------

minetest.register_craft( {
    type = "shapeless",
        output = "default:ceiling_paint 50",
        recipe = {
            "default:dye_white",
            "defauly:dye_white",
            "default:sand",
            "default:bucket_water",
        },
    replacements = { { "default:bucket_water","default:bucket_empty" } }
})

minetest.register_craft( {
    output = "default:stereo",
    recipe = {
        { "default:plastic_sheeting", "default:plastic_sheeting",      "default:plastic_sheeting" },
        { "default:plastic_sheeting", "default:mese_crystal_fragment", "default:plastic_sheeting" },
        { "default:steel_ingot",      "default:plastic_sheeting",      "default:steel_ingot" },
    },
})

minetest.register_craft( {
        output = 'default:speaker 4',
            recipe = {
        { "wool:black", "group:wood",           "group:wood" },
        { "wool:black", "default:copper_ingot", "group:wood" },
        { "wool:black", "group:wood",           "group:wood" },
    },
})

minetest.register_craft({
    output = 'default:refrigerator 2',
    recipe = {   
        {"default:steel_ingot", "default:plastic_sheeting",      "default:steel_ingot", },
        {"default:steel_ingot", "default:bucket_water",          "default:steel_ingot", },
        {"default:steel_ingot", "default:mese_crystal_fragment", "default:steel_ingot", },
    }
})

minetest.register_craft({
        output = 'default:kitchen_cabinet 2',
        recipe = {
        {"group:stone", "group:stone", "group:stone", },
        {"group:wood",  "group:stick", "group:wood", },
        {"group:wood",  "group:stick", "group:wood", },
    }
})

minetest.register_craft({
    type = "shapeless",
        output = "default:kitchen_cabinet_half 2",
        recipe = { "default:kitchen_cabinet" }
})

minetest.register_craft({
    output = "default:dvd_vcr",
    recipe = {
        {"default:plastic_sheeting", "default:plastic_sheeting",      "default:plastic_sheeting", },
        {"default:plastic_sheeting", "default:mese_crystal_fragment", "default:plastic_sheeting", },
        {"default:plastic_sheeting", "default:steel_ingot",           "default:copper_ingot", },
    },
})

minetest.register_craft({
    output = "default:toilet",
    recipe = {
        {"",               "",                     "default:bucket_water"},
        { "default:marble","default:marble",       "default:marble" },
        { "",              "default:bucket_empty", "" },
    },
})

minetest.register_craft({
    output = 'default:nightstand 4',
    recipe = {
        {"default:slab_junglewood", "default:slab_junglewoodg", "default:slab_junglewood", },
        {"default:junglewood",      "group:stick",              "default:junglewoodg", },
        {"default:junglewood",      "group:stick",              "default:junglewood", },
    },
})