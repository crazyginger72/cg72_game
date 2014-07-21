--tps on selah's server

minetest.register_on_chat_message(function(name, message, playername, player)
	local cmd = "/porthaven"
	local ph = minetest.setting_get("porthaven")
	if message:sub(0, #cmd) == cmd then

		if ph == nil then
			minetest.log("action", "[ERROR] porthaven not set!!!!!!!!!!!")			
			return
		else
			if message == '/porthaven' then
				local player = minetest.env:get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to Port Haven...")
				player:setpos(minetest.string_to_pos(ph))
				return true
			end
		end
	end
end)


print("[MOD] /porthaven is set to "..ph))

minetest.register_on_chat_message(function(name, message, playername, player)
	local cmd = "/piratescove"
	local pc = minetest.setting_get("piratescove")
	if message:sub(0, #cmd) == cmd then

		if pc == nil then
			minetest.log("action", "[ERROR] piratescove not set!!!!!!!!!!!")			
			return
		else
			if message == '/piratescove' then
				local player = minetest.env:get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to Pirates Cove...")
				player:setpos(minetest.string_to_pos(pc))
				return true
			end
		end
	end
end)


print("[MOD] /admintown is set to "..pc))

minetest.register_on_chat_message(function(name, message, playername, player)
	local cmd = "/admintown"
	local at = minetest.setting_get("admintown")
	if message:sub(0, #cmd) == cmd then

		if at == nil then
			minetest.log("action", "[ERROR] admintown not set!!!!!!!!!!!")			
			return
		else
			if message == '/admintown' then
				local player = minetest.env:get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to The Admin Town...")
				player:setpos(minetest.string_to_pos(at))
				return true
			end
		end
	end
end)


print("[MOD] /admintown is set to "..at))
