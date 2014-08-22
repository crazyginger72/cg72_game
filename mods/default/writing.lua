----------------------------------------------
--------------Memorandum 0.2.0"---------------
--------------------cg72----------------------

--				{ left	, bottom , front  ,  right ,  top   ,  back  }
local sheet =	{ -1/2  , -1/2   , -1/2   , 1/2    , -7/16  ,  1/2  }
local info  =	'On this piece of paper is written: "'
local sign  =	'" Signed by '
--           { s,  w, n,  e }
local wdir = { 8, 17, 6, 15 } -- wall direction

minetest.register_node("default:letter_empty", {
	drawtype = "nodebox",
	tiles = {
		"memorandum_letter_empty.png",
		"memorandum_letter_empty.png^[transformFY" -- mirror
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	node_box = {type = "fixed", fixed = sheet},
	groups = {snappy=3,dig_immediate=3,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string(
					"formspec", 
					"size[10,10]"..
					"field[1,1;8.5,3;text; Write a Letter;${text}]"..
					"field[1,6;4.25,1;signed; Sign Letter (optional);${signed}]"..
					"button_exit[0.75,8;4.25,1;text,signed;Done]"
				)
		meta:set_string("infotext", info..'"')
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		fields.text = fields.text
		fields.signed = fields.signed
		--[[print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to paper at "..minetest.pos_to_string(pos))]]
		local fdir = minetest.get_node(pos).param2
		if fields.text ~= "" and fields.text ~= nil then
			minetest.add_node(pos, {name="default:letter_written", param2=fdir})
		end
		if fields.text ~= nil then 
			meta:set_string("text", fields.text)
			meta:set_string("signed", "")
			meta:set_string("infotext", info..fields.text..'" Unsigned')
		end
		if fields.signed ~= "" and fields.text ~= nil then
			meta:set_string("signed", fields.signed)
			meta:set_string("infotext", info..fields.text..sign..fields.signed)
		end
	end,
	on_dig = function(pos, node, digger)
		if digger:is_player() and digger:get_inventory() then
			digger:get_inventory():add_item("main", {name="default:paper", count=1, wear=0, metadata=""})
		end
		minetest.remove_node(pos)
	end,
})

minetest.register_craftitem("default:letter", {
	description = "Letter",
	inventory_image = "default_paper.png^memorandum_letters.png",
	stack_max = 1,
	groups = {not_in_creative_inventory=1},
	on_use = function(itemstack, user, pointed_thing)
		local player = user:get_player_name()
		local text = itemstack:get_metadata()
		local scnt = string.sub (text, -2, -1)
		if scnt == "00" then
			mssg = string.sub (text, 1, -3)
			sgnd = ""
		elseif tonumber(scnt) == nil then -- to support previous versions
			mssg = string.sub (text, 37, -1)
			sgnd = ""
		else
			mssg = string.sub (text, 1, -scnt -3)
			sgnd = string.sub (text, -scnt-2, -3)
		end
		if scnt == "00" or tonumber(scnt) == nil then
			minetest.chat_send_player(player, info..mssg..'" Unsigned', false)
		else
			minetest.chat_send_player(player, info..mssg..sign..sgnd, false)
		end
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		local above = pt.above
		local under = pt.under
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local meta = minetest.get_meta(above)
		local text = itemstack:get_metadata()
		local scnt = string.sub (text, -2, -1)
		if scnt == "00" then
			mssg = string.sub (text, 1, -3)
			sgnd = ""
		elseif tonumber(scnt) == nil then -- to support previous versions
			mssg = string.sub (text, 37, -1)
			sgnd = ""
		else
			mssg = string.sub (text, 1, -scnt -3)
			sgnd = string.sub (text, -scnt-2, -3)
		end
		if minetest.get_node(above).name == "air" then
			if (above.x ~= under.x) or (above.z ~= under.z) then
				minetest.add_node(above, {name="default:letter_written", param2=wdir[fdir+1]})
			else
				minetest.add_node(above, {name="default:letter_written", param2=fdir})
			end
			if scnt == "00" or tonumber(scnt) == nil then
				meta:set_string("infotext", info..mssg..'" Unsigned')
			else
				meta:set_string("infotext", info..mssg..sign..sgnd)
			end
			meta:set_string("text", mssg)
			meta:set_string("signed", sgnd)
			itemstack:take_item()
			return itemstack
		end
	end,
})

minetest.register_node("default:letter_written", {
	drawtype = "nodebox",
	tiles = {
		"memorandum_letter_empty.png^memorandum_letter_text.png",
		"memorandum_letter_empty.png^[transformFY" -- mirror
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	node_box = {type = "fixed", fixed = sheet},
	groups = {snappy=3,dig_immediate=3,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	on_receive_fields = function(pos, formname, fields, sender)
		local item = sender:get_wielded_item()
		if item:get_name() == "default:eraser" then
			local meta = minetest.get_meta(pos)
			fields.text = fields.text
			fields.signed = fields.signed
			--[[print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to paper at "..minetest.pos_to_string(pos))]]
			local fdir = minetest.get_node(pos).param2
			if fields.text == "" then
				minetest.add_node(pos, {name="default:letter_empty", param2=fdir})
			end
			meta:set_string("text", fields.text)
			meta:set_string("signed", "")
			meta:set_string("infotext", info..fields.text..'" Unsigned')
			if fields.signed ~= "" then
				meta:set_string("signed", fields.signed)
				meta:set_string("infotext", info..fields.text..sign..fields.signed)
			end
		end
	end,
	on_dig = function(pos, node, digger)
		if digger:is_player() and digger:get_inventory() then
			local meta = minetest.get_meta(pos)
			local text = meta:get_string("text")
			local signed = meta:get_string("signed")
			local signcount = string.len(signed)
			local item = digger:get_wielded_item()
			local inv = digger:get_inventory()
			if string.len(signed) < 10 then
				signcount = "0"..string.len(signed)
			end
			if signed == '" Unsigned' then
				signcount = "00"
			end
			if item:get_name() == "vessels:glass_bottle" then
				inv:remove_item("main", "vessels:glass_bottle")
				inv:add_item("main", {name="default:message", count=1, wear=0, metadata=text..signed..signcount})
			else
				inv:add_item("main", {name="default:letter", count=1, wear=0, metadata=text..signed..signcount})
			end
		end
		minetest.remove_node(pos)
	end,
})

local function eraser_wear(itemstack, user, pointed_thing, uses)
	itemstack:add_wear(65535/(uses-1))
	return itemstack
end

minetest.register_tool("default:eraser", {
	description = "Eraser",
	inventory_image = "memorandum_eraser.png",
	wield_image = "memorandum_eraser.png^[transformR90",--^[transformFX",
	wield_scale = {x = 0.5, y = 0.5, z = 1},
	on_use = function(itemstack, user, pointed_thing)
		local pt = pointed_thing
		if pt and pt.under then
			local node = minetest.get_node(pt.under)
			local meta = minetest.get_meta(pt.under)
			local player = user:get_player_name()
			local signer = meta:get_string("signed")
			if string.find(node.name, "default:letter_written") then
				if signer == player or signer == "" then
					meta:set_string(
						"formspec", 
						"size[10,7]"..
						"textarea[1,1;8.5,3;text; Edit Text;${text}]"..--"field[1,1;8.5,1;text; Edit Text;${text}]"..
						"field[1,3;4.25,1;signed; Edit Signature;${signed}]"..
						"button_exit[0.75,5;4.25,1;text,signed;Done]"
					)
					if not minetest.setting_getbool("creative_mode") then
						return eraser_wear(itemstack, user, pointed_thing, 30)	
					else
						return {name="default:eraser", count=1, wear=0, metadata=""}
					end
				end
			end
		end
	end,
})

minetest.register_node("default:message", {
	description = "Message in a Bottle",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png^memorandum_message.png"},
	inventory_image = "vessels_glass_bottle_inv.png^memorandum_message.png",
	wield_image = "vessels_glass_bottle.png^memorandum_message.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-1/4, -1/2, -1/4, 1/4, 4/10, 1/4}
	},
	stack_max = 1,
	groups = {vessel=1,dig_immediate=3,attached_node=1,not_in_creative_inventory=1},
	--sounds = default.node_sound_glass_defaults(),
	on_use = function(itemstack, user, pointed_thing)
		local pt = pointed_thing
		if  pt.under then
			local meta = minetest.get_meta(pt.above)
			local text = itemstack:get_metadata()
			local scnt = string.sub (text, -2, -1)
			if scnt == "00" then
				mssg = string.sub (text, 1, -3)
				sgnd = ""
			elseif tonumber(scnt) == nil then -- to support previous versions
				mssg = string.sub (text, 37, -1)
				sgnd = ""
			else
				mssg = string.sub (text, 1, -scnt -3)
				sgnd = string.sub (text, -scnt-2, -3)
			end
			if  minetest.get_node(pt.above).name == "air" then
				minetest.add_node(pt.above, {name="default:letter_written", param2=math.random(0,3)})
				if scnt == "00" or tonumber(scnt) == nil then
					meta:set_string("infotext", info..mssg..'" Unsigned')
				else
					meta:set_string("infotext", info..mssg..sign..sgnd)
				end
				meta:set_string("text", mssg)
				meta:set_string("signed", sgnd)
				itemstack:take_item()
				user:get_inventory():add_item("main", {name="vessels:glass_bottle", count=1, wear=0, metadata=""})
				return itemstack
			end
		end
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		local meta = minetest.get_meta(pt.above)
		local text = itemstack:get_metadata()
		local scnt = string.sub (text, -2, -1)
		if scnt == "00" then
			mssg = string.sub (text, 1, -3)
			sgnd = ""
		elseif tonumber(scnt) == nil then -- to support previous versions
			mssg = string.sub (text, 37, -1)
			sgnd = ""
		else
			mssg = string.sub (text, 1, -scnt -3)
			sgnd = string.sub (text, -scnt-2, -3)
		end
		if minetest.get_node(pt.above).name == "air" then
			minetest.add_node(pt.above, {name="default:message"})
			meta:set_string("text", mssg)
			meta:set_string("signed", sgnd)
			itemstack:take_item()
			return itemstack
		end
	end,
	on_dig = function(pos, node, digger)
		if digger:is_player() and digger:get_inventory() then
			local meta = minetest.get_meta(pos)
			local text = meta:get_string("text")
			local signed = meta:get_string("signed")
			local signcount = string.len(signed)
			local item = digger:get_wielded_item()
			if string.len(signed) < 10 then
				signcount = "0"..string.len(signed)
			end
			if signed == '" Unsigned' then
				signcount = "00"
			end
			digger:get_inventory():add_item("main", {name="default:message", count=1, wear=0, metadata=text..signed..signcount})
		end
		minetest.remove_node(pos)
	end,
})