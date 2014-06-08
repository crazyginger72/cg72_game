--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------Minetest Time--kazea's code tweeked by cg72 with help from crazyR--------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

player_hud = {}
player_hud.time = {}
player_hud.lag = {}
 
local function explode(sep, input)
local t={}
local i=0
for k in string.gmatch(input,"([^"..sep.."]+)") do
t[i]=k;i=i+1
end
return t
end
local function get_lag()
local arrayoutput = explode(", ",minetest.get_server_status())
local arrayoutput = explode("=",arrayoutput[4])
return "Current Lag: "..arrayoutput[1].." sec"
end
local function floormod ( x, y )
return (math.floor(x) % y);
end
 
local function get_time ( )
local dn, secs, s, m, h
secs = (60*60*24*minetest.env:get_timeofday());
s = floormod(secs, 60);
m = floormod(secs/60, 60);
h = floormod(secs/3600, 60);
dn = "am";
if h >= 12 then
h = h - 12;
dn = "pm";
end
return ("Minetest time %02d:%02d "..dn):format(h, m, dn);
end
local function generatehud(player)
local name = player:get_player_name()
player_hud.time[name] = player:hud_add({
hud_elem_type = "text",
name = "player_hud:time",
position = {x=0.20, y=0.965},
text = get_time(),
scale = {x=100,y=100},
alignment = {x=0,y=0},
number = 0xFFFFFF,
})
player_hud.lag[name] = player:hud_add({
hud_elem_type = "text",
name = "player_hud:lag",
position = {x=0.80, y=0.965},
text = get_lag(),
scale = {x=100,y=100},
alignment = {x=0,y=0},
number = 0xFFFFFF,
})
end
 
local function removehud(player)
local name = player:get_player_name()
if player_hud.time[name] then


player:hud_remove(player_hud.time[name])
end
if player_hud.lag[name] then
player:hud_remove(player_hud.lag[name])
end
end
 
local timer = 0;
minetest.register_globalstep(function ( dtime )
timer = timer + dtime;
if (timer >= 1.0) then
timer = 0;
for _,player in ipairs(minetest.get_connected_players()) do
removehud(player)
generatehud(player)
end
end
end);
minetest.register_on_joinplayer(function(player)
minetest.after(0,generatehud,player)
end)