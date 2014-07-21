minetest.register_on_chat_message(function(name, message, playername, player)
	local cmd = "/spawn"
	local spawn = minetest.setting_get("spawn")
	if message:sub(0, #cmd) == cmd then
		if message == '/spawn' then
			local player = minetest.env:get_player_by_name(name)
			minetest.chat_send_player(player:get_player_name(), "Teleporting to spawn...")
			player:setpos(spawn)
			return true
		end
	end
end)


print("/spawn is set to"..minetest.setting_get("spawn"))
