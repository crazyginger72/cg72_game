
-- Extended Ban Mod for Minetest
-- (C) 2013 Diego Martínez <kaeza>
-- See `LICENSE.txt' for details.

-- init.lua: Initialization script.

xban = { }
xban._ = { } -- Internal functions.

local MP = minetest.get_modpath("default")

dofile(MP.."/conf.lua")
dofile(MP.."/intr.lua")
dofile(MP.."/xban_ban.lua")
dofile(MP.."/chat.lua")
dofile(MP.."/join.lua")
