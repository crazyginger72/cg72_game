------------------------------------------------------------------------------
------------------------------------------------------------------------------
--------------boy/girl skins-- crazyginger72--rewrite by Krock----------------
------------------------------------------------------------------------------
---special thanks to kaeza, nore, Zeno`, and jordach for help with the code---
------------------------------------------------------------------------------
------------------------------------------------------------------------------

local gender = {}
gender.players = {}
 
gender.file = minetest.get_worldpath() .. "/player_genders"
gender.changed = false
 
gender.formname = "gender:selection"
gender.formspec = (
        "size[8,2]label[2.1,0;Do you want boy or a girl skin?]"..
        "button_exit[0,0;4,4;boy;Boy]"..
        "button_exit[4,0;4,4;girl;Girl]"
)
 
function gender.load_data()
        local input = io.open(gender.file, "r")
        if not input then return end
       
        for line in input:lines() do
                if line ~= "" then
                        local data = line:split(" ")
                        gender.players[data[1]] = data[2]
                end
        end
       
        io.close(input)
end
 
function gender.save_data()
        if not gender.changed then return end
       
        local output = io.open(gender.file, "w")
        for k,v in pairs(gender.players) do
                output:write(k.." "..v.."\n")
        end
        io.close(output)
        gender.changed = false
end
 
gender.load_data()
 
minetest.register_on_player_receive_fields(function(player, formname, fields)
        if gender.formname ~= formname then return end
        local plname = player:get_player_name()
        --default.player_set_model(player, "character.x")
        --player:set_local_animation({x=0, y=79}, {x=168, y=187}, {x=189, y=198}, {x=200, y=219}, 30)
       
        if fields.boy then -- Change skin to boy.
                player:set_properties({
                        visual = "mesh",
                        mesh = "character.x",
                        textures = {"characterm.png"},
                        visual_size = {x=1, y=1},
                })
                minetest.chat_send_player(plname, "Set player skin to boy!")
               
                gender.changed = true
                gender.players[plname] = "m"
        elseif fields.girl then -- Change skin to girl.
                player:set_properties({
                        visual = "mesh",
                        mesh = "character.x",
                        textures = {"characterf.png"},
                        visual_size = {x=1, y=1},
                })
                minetest.chat_send_player(plname, "Set player skin to girl!")
               
                gender.changed = true
                gender.players[plname] = "f"
        end
        gender.save_data()
end)
 
minetest.register_chatcommand("gender", {
        description = "Set your player skin.",
        func = function(name)
                minetest.show_formspec(name, gender.formname, gender.formspec)
        end
})
 
minetest.register_on_joinplayer(function(player)
        local plname = player:get_player_name()
        --default.player_set_model(player, "character.x")
        --player:set_local_animation({x=0, y=79}, {x=168, y=187}, {x=189, y=198}, {x=200, y=219}, 30)
       
        if gender.players[plname] == "m" then
                player:set_properties({
                        visual = "mesh",
                        mesh = "character.x",
                        textures = {"characterm.png"},
                        visual_size = {x=1, y=1},
                })
                minetest.chat_send_player(plname, "Your gender is set to boy, to change type /gender ")
        elseif gender.players[plname] == "f" then
                player:set_properties({
                        visual = "mesh",
                        mesh = "character.x",
                        textures = {"characterf.png"},
                        visual_size = {x=1, y=1},
                })
                minetest.chat_send_player(plname, "Your gender is set to girl, to change type /gender ")
        else
                minetest.chat_send_player(plname, "Please set your gender via /boy or /girl, thank you. You can also ignore this message and use the default male model. This message will be shown again when you rejoin.")
                minetest.show_formspec(plname, gender.formname, gender.formspec)
        end
end)
 
print("[MOD] Gender choices are loaded")
