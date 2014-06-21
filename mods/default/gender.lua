local gender_file = minetest.get_worldpath() .. "/player_genders"
local genders = {}
local function loadgenders()
local input = io.open(gender_file, "r")
if input then
repeat
local gender_choice = input:read("*n")
if gender_choice == nil then
--print("Gender choice was nil")
break
end
local name = input:read("*l")
--print("playername: "..name)
genders[name:sub(2)] = gender_choice
--print("gender: "..gender_choice)
until input:read(0) == nil
io.close(input)
else
genders = {}
end
end

loadgenders()

local changed = false

minetest.register_chatcommand("boy", {
description = "Sets your player model to the default male one",
func = function(name)
local player = minetest.env:get_player_by_name(name)
if player == nil then
return false
end
if true then
default.player_set_model(player, "character.x")

player:set_properties({
textures = {"characterm.png"},
})
end
player:set_local_animation({x=0, y=79}, {x=168, y=187}, {x=189, y=198}, {x=200, y=219}, 30)
minetest.chat_send_player(name, "Set player model to male!")
changed = true
if changed then
local output = io.open(gender_file, "w")
output:write("1 "..player:get_player_name().."\n")
io.close(output)
end
changed = false
end

})

minetest.register_chatcommand("girl", {
description = "Sets your player model to the female one",
func = function(name)
local player = minetest.env:get_player_by_name(name)
if player == nil then
return false
end
if true then
default.player_set_model(player, "character.x")

player:set_properties({
textures = {"characterf.png"},
})
end
player:set_local_animation({x=0, y=79}, {x=168, y=187}, {x=189, y=198}, {x=200, y=219}, 30)
minetest.chat_send_player(name, "Set player model to female!")
changed = true
if changed then
local output = io.open(gender_file, "w")
output:write("0 "..player:get_player_name().."\n")
io.close(output)
end
changed = false
end

})

minetest.register_on_joinplayer(function(player)
loadgenders()
if genders[player:get_player_name()] == 1 then
default.player_set_model(player, "character.x")
player:set_properties({
textures = {"characterm.png"},
})
player:set_local_animation({x=0, y=79}, {x=168, y=187}, {x=189, y=198}, {x=200, y=219}, 30)
minetest.chat_send_player(player:get_player_name(), "Your gender is set to boy, to change type /girl ")
elseif genders[player:get_player_name()] == 0 then
default.player_set_model(player, "character.x")
player:set_properties({
textures = {"characterf.png"},
})
player:set_local_animation({x=0, y=79}, {x=168, y=187}, {x=189, y=198}, {x=200, y=219}, 30)
minetest.chat_send_player(player:get_player_name(), "Your gender is set to girl, to change type /boy ")
else
default.player_set_model(player, "character.x")
player:set_local_animation({x=0, y=79}, {x=168, y=187}, {x=189, y=198}, {x=200, y=219}, 30)
minetest.chat_send_player(player:get_player_name(), "Please set your gender via /boy or /girl, thank you. You can also ignore this message and use the default male model. This message will be shown again when you rejoin.")
end
end)


print("[MOD] Gender choices are loaded")
