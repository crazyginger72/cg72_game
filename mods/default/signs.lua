-- This mod provides the visible text on signs library used by Home Decor
-- and perhaps other mods at some point in the future.  Forked from thexyz's/
-- PilzAdam's original text-on-signs mod and rewritten by Vanessa Ezekowitz
-- and Diego Martinez


-- This mod provides the visible text on signs library used by Home Decor
-- and perhaps other mods at some point in the future.  Forked from thexyz's/
-- PilzAdam's original text-on-signs mod and rewritten by Vanessa Ezekowitz
-- and Diego Martinez

signs_lib = {}

signs_lib.modpath = minetest.get_modpath("default")
signs_lib.intllib_modpath = minetest.get_modpath("intllib")

signs_lib.wall_sign_model = {
	nodebox = {
		type = "fixed",
		fixed = {-0.4375, -0.25, 0.4375, 0.4375, 0.4375, 0.5}
	},
	textpos = {
		{delta = {x =  0,     y = 0.07, z =  0.436}, yaw = 0},
		{delta = {x =  0.436, y = 0.07, z =  0    }, yaw = math.pi / -2},
		{delta = {x =  0,     y = 0.07, z = -0.436}, yaw = math.pi},
		{delta = {x = -0.436, y = 0.07, z =  0    }, yaw = math.pi / 2},
	}
}

signs_lib.yard_sign_model = {
	nodebox = {
		type = "fixed",
		fixed = {
				{-0.4375, -0.25, -0.0625, 0.4375, 0.4375, 0},
				{-0.0625, -0.5, -0.0625, 0.0625, -0.25, 0},
		}
	},
	textpos = {
		{delta = {x =  0,      y = 0.07, z = -0.063}, yaw = 0},
		{delta = {x = -0.063,  y = 0.07, z =  0    }, yaw = math.pi / -2},
		{delta = {x =  0,      y = 0.07, z =  0.063}, yaw = math.pi},
		{delta = {x =  0.063,  y = 0.07, z =  0    }, yaw = math.pi / 2},
	}
}

signs_lib.hanging_sign_model = {
	nodebox = {
		type = "fixed",
		fixed = {
				{-0.4375, -0.3125, -0.0625, 0.4375, 0.3125, 0},
				{-0.4375, 0.25, -0.03125, 0.4375, 0.5, -0.03125},
		}
	},
	textpos = {
		{delta = {x =  0,      y = -0.02, z = -0.063}, yaw = 0},
		{delta = {x = -0.063,  y = -0.02, z =  0    }, yaw = math.pi / -2},
		{delta = {x =  0,      y = -0.02, z =  0.063}, yaw = math.pi},
		{delta = {x =  0.063,  y = -0.02, z =  0    }, yaw = math.pi / 2},
	}
}

local S
if signs_lib.intllib_modpath then
    dofile(signs_lib.intllib_modpath.."/intllib.lua")
    S = intllib.Getter(minetest.get_current_modname())
else
    S = function ( s ) return s end
end
signs_lib.gettext = S

--table copy

function signs_lib.table_copy(t)
    local nt = { };
    for k, v in pairs(t) do
        if type(v) == "table" then
            nt[k] = signs_lib.table_copy(v)
        else
            nt[k] = v
        end
    end
    return nt
end

-- infinite stacks

if minetest.get_modpath("unified_inventory") or not minetest.setting_getbool("creative_mode") then
	signs_lib.expect_infinite_stacks = false
else
	signs_lib.expect_infinite_stacks = true
end

-- CONSTANTS

local MP = minetest.get_modpath("default")

-- Used by `build_char_db' to locate the file.
local FONT_FMT = "%s/hdf_%02x.png"

-- Simple texture name for building text texture.
local FONT_FMT_SIMPLE = "hdf_%02x.png"

-- Path to the textures.
local TP = MP.."/textures"

local TEXT_SCALE = {x=0.8, y=0.6}

-- Lots of overkill here. KISS advocates, go away, shoo! ;) -- kaeza

local PNG_HDR = string.char(0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A)

-- Read the image size from a PNG file.
-- Returns image_w, image_h.
-- Only the LSB is read from each field!
local function read_char_size(c)
	local filename = FONT_FMT:format(TP, c)
	local f = io.open(filename, "rb")
	f:seek("set", 0x0)
	local hdr = f:read(8)
	if hdr ~= PNG_HDR then
		f:close()
		return
	end
	f:seek("set", 0x13)
	local ws = f:read(1)
	f:seek("set", 0x17)
	local hs = f:read(1)
	f:close()
	return ws:byte(), hs:byte()
end

-- Set by build_char_db()
local LINE_HEIGHT
local SIGN_WIDTH

-- Size of the canvas, in characters.
-- Please note that CHARS_PER_LINE is multiplied by the average character
-- width to get the total width of the canvas, so for proportional fonts,
-- either more or fewer characters may fit on a line.
local CHARS_PER_LINE = 29
local NUMBER_OF_LINES = 6

-- This holds the individual character widths.
-- Indexed by the actual character (e.g. charwidth["A"])
local charwidth = { }

-- File to cache the font size to.
local CHARDB_FILE = minetest.get_worldpath().."/signs_lib_chardb"

-- Returns true if any file differs from cached one.
local function check_random_chars()
	for i = 1, 5 do
		local c = math.random(32, 126)
		local w, h = read_char_size(c)

		-- File is not a PNG... wut?
		if not (w and h) then return true end

		local ch = string.char(c)
		if  (not charwidth[ch])                     -- Char is not cached.
		 or (charwidth[ch] ~= w)                    -- Width differs.
		 or (LINE_HEIGHT and (LINE_HEIGHT ~= h))    -- Height differs
		 then
			-- In any case, file is different; rebuild cache.
			return true
		end
	end
	-- OK, our superficial check passed. If the textures are messed up,
	-- it's not our problem.
	return false
end

local function build_char_db()

	LINE_HEIGHT = nil
	SIGN_WIDTH = nil

	-- To calculate average char width.
	local total_width = 0
	local char_count = 0

	-- Try to load cached data to avoid heavy disk I/O.

	local cdbf = io.open(CHARDB_FILE, "rt")

	if cdbf then
		minetest.log("info", "[signs_lib] "..S("Reading cached character database."))
		for line in cdbf:lines() do
			local ch, w = line:match("(0x[0-9A-Fa-f]+)%s+([0-9][0-9]*)")
			if ch and w then
				local c = tonumber(ch)
				w = tonumber(w)
				if c and w then
					if c == 0 then
						LINE_HEIGHT = w
					elseif (c >= 32) and (c < 127) then
						charwidth[string.char(c)] = w
						total_width = total_width + w
						char_count = char_count + 1
					end
				end
			end
		end
		cdbf:close()
		if LINE_HEIGHT then
			-- Check some random characters to see if the file on disk differs
			-- from the cached one. If so, then ditch cached data and rebuild
			-- (font probably was changed).
			if check_random_chars() then
				LINE_HEIGHT = nil
				minetest.log("info", "[signs_lib] "
					..S("Font seems to have changed. Rebuilding cache.")
				)
			end
		else
			minetest.log("warning", "[signs_lib] "
				..S("Could not find font line height in cached DB. Trying brute force.")
			)
		end
	end

	if not LINE_HEIGHT then
		-- OK, something went wrong... try brute force loading from texture files.

		charwidth = { }

		total_width = 0
		char_count = 0

		for c = 32, 126 do
			local w, h = read_char_size(c)
			if w and h then
				local ch = string.char(c)
				charwidth[ch] = w
				total_width = total_width + w
				char_count = char_count + 1
				if not LINE_HEIGHT then LINE_HEIGHT = h end
			end
		end

		if not LINE_HEIGHT then
			error("Could not find font line height.")
		end

	end

	-- XXX: Is there a better way to calc this?
	SIGN_WIDTH = math.floor((total_width / char_count) * CHARS_PER_LINE)

	-- Try to save cached list back to disk.

	local e -- Note: `cdbf' is already declared local above.
	cdbf, e = io.open(CHARDB_FILE, "wt")
	if not cdbf then
		minetest.log("warning", "[signs_lib] Could not save cached char DB: "..(e or ""))
		return
	end

	cdbf:write(("0x00 %d\n"):format(LINE_HEIGHT))
	for c = 32, 126 do
		local w = charwidth[string.char(c)]
		if w then
			cdbf:write(("0x%02X %d\n"):format(c, w))
		end
	end
	cdbf:close()

end

local sign_groups = {choppy=2, dig_immediate=2}

local fences_with_sign = { }

-- some local helper functions

local function split_lines_and_words_old(text)
	local lines = { }
	local line = { }
	if not text then return end
	for word in text:gmatch("%S+") do
		if word == "|" then
			table.insert(lines, line)
			if #lines >= NUMBER_OF_LINES then break end
			line = { }
		elseif word == "\\|" then
			table.insert(line, "|")
		else
			table.insert(line, word)
		end
	end
	table.insert(lines, line)
	return lines
end

local function split_lines_and_words(text)
	if not text then return end
	local lines = { }
	for _, line in ipairs(text:split("\n")) do
		table.insert(lines, { line })
	end
	return lines
end

local math_max = math.max

local function fill_line(x, y, w, c)
	local tex = { }
	for xx = 0, math.max(0, w-16), 16 do
		table.insert(tex, (":%d,%d=slc_%s.png"):format(x + xx, y, c))
	end
	if ((w % 16) > 0) and (w > 16) then
		table.insert(tex, (":%d,%d=slc_%s.png"):format(x + w - 16, y, c))
	end
	return table.concat(tex)
end

local function make_line_texture(line, lineno)

	local width = 0
	local maxw = 0

	local words = { }

	local cur_color = 0

	-- We check which chars are available here.
	for word_i, word in ipairs(line) do
		local chars = { }
		local ch_offs = 0
		local word_l = #word
		local i = 1
		while i <= word_l  do
			local c = word:sub(i, i)
			if c == "#" then
				local cc = tonumber(word:sub(i+1, i+1), 16)
				if cc then
					i = i + 1
					cur_color = cc
				end
			else
				local w = charwidth[c]
				if w then
					width = width + w + 1
					if width >= (SIGN_WIDTH - charwidth[" "]) then
						width = 0
					else
						maxw = math_max(width, maxw)
					end
					table.insert(chars, {
						off=ch_offs,
						tex=FONT_FMT_SIMPLE:format(c:byte()),
						col=("%X"):format(cur_color),
					})
					ch_offs = ch_offs + w
				end
			end
			i = i + 1
		end
		width = width + charwidth[" "] + 1
		maxw = math_max(width, maxw)
		table.insert(words, { chars=chars, w=ch_offs })
	end

	-- Okay, we actually build the "line texture" here.

	local texture = { }

	local start_xpos = math.floor((SIGN_WIDTH - maxw) / 2)

	local xpos = start_xpos
	local ypos = (LINE_HEIGHT * lineno)

	cur_color = nil

	for word_i, word in ipairs(words) do
		local xoffs = (xpos - start_xpos)
		if (xoffs > 0) and ((xoffs + word.w) > maxw) then
			table.insert(texture, fill_line(xpos, ypos, maxw, "n"))
			xpos = start_xpos
			ypos = ypos + LINE_HEIGHT
			lineno = lineno + 1
			if lineno >= NUMBER_OF_LINES then break end
			table.insert(texture, fill_line(xpos, ypos, maxw, cur_color))
		end
		for ch_i, ch in ipairs(word.chars) do
			if ch.col ~= cur_color then
				cur_color = ch.col
				table.insert(texture, fill_line(xpos + ch.off, ypos, maxw, cur_color))
			end
			table.insert(texture, (":%d,%d=%s"):format(xpos + ch.off, ypos, ch.tex))
		end
		table.insert(texture, (":%d,%d=hdf_20.png"):format(xpos + word.w, ypos))
		xpos = xpos + word.w + charwidth[" "]
	end

	table.insert(texture, fill_line(xpos, ypos, maxw, "n"))
	table.insert(texture, fill_line(start_xpos, ypos + LINE_HEIGHT, maxw, "n"))

	return table.concat(texture), lineno
end

local function make_sign_texture(lines)
	local texture = { ("[combine:%dx%d"):format(SIGN_WIDTH, LINE_HEIGHT * NUMBER_OF_LINES) }
	local lineno = 0
	for i = 1, #lines do
		if lineno >= NUMBER_OF_LINES then break end
		local linetex, ln = make_line_texture(lines[i], lineno)
		table.insert(texture, linetex)
		lineno = ln + 1
	end
	table.insert(texture, "^[makealpha:0,0,0")
	return table.concat(texture, "")
end

local function set_obj_text(obj, text, new)
	local split = new and split_lines_and_words or split_lines_and_words_old
	obj:set_properties({
		textures={make_sign_texture(split(text))},
		visual_size = TEXT_SCALE,
	})
end

signs_lib.construct_sign = function(pos)
    local meta = minetest.get_meta(pos)
	meta:set_string(
		"formspec",
		"size[6,4]"..
		"textarea[0,0;6.5,3;text;;${text}]"..
		"button_exit[2,3;2,1;ok;Write]"..
		"background[-0.5,-0.5;7,5;bg_signs_lib.jpg]")
	meta:set_string("infotext", "")
end

signs_lib.destruct_sign = function(pos)
    local objects = minetest.get_objects_inside_radius(pos, 0.5)
    for _, v in ipairs(objects) do
		local e = v:get_luaentity()
        if e and e.name == "default:text" then
            v:remove()
        end
    end
end

local function make_infotext(text)
	local lines = split_lines_and_words(text) or {}
	local lines2 = { }
	for _, line in ipairs(lines) do
		table.insert(lines2, (table.concat(line, " "):gsub("#[0-9a-fA-F]", ""):gsub("##", "#")))
	end
	return table.concat(lines2, "\n")
end

signs_lib.update_sign = function(pos, fields)
    local meta = minetest.get_meta(pos)
    local new
	if fields then
		meta:set_string("infotext", make_infotext(fields.text).." ")
		meta:set_string("text", fields.text)
		meta:set_int("__signslib_new_format", 1)
		new = true
	else
		new = (meta:get_int("__signslib_new_format") ~= 0)
	end
    local text = meta:get_string("text")
    if text == nil then return end
    local objects = minetest.get_objects_inside_radius(pos, 0.5)
    for _, v in ipairs(objects) do
		local e = v:get_luaentity()
		if e and e.name == "default:text" then
			set_obj_text(v, text, new)
			return
        end
    end

	-- if there is no entity
	local sign_info
	local signnode = minetest.get_node(pos)
	if signnode.name == "default:sign_yard" then
		sign_info = signs_lib.yard_sign_model.textpos[minetest.get_node(pos).param2 + 1]
	elseif signnode.name == "default:sign_hanging" then
		sign_info = signs_lib.hanging_sign_model.textpos[minetest.get_node(pos).param2 + 1]
	elseif signnode.name == "default:sign_wall" 
		or signnode.name == "default:sign_wall_green"
		or signnode.name == "default:sign_wall_yellow" then
		sign_info = signs_lib.wall_sign_model.textpos[minetest.get_node(pos).param2 + 1]
	else -- ...it must be a sign on a fence post.
		sign_info = signs_lib.sign_post_model.textpos[minetest.get_node(pos).param2 + 1]
	end
	if sign_info == nil then
		return
	end
	local text = minetest.add_entity({x = pos.x + sign_info.delta.x,
										y = pos.y + sign_info.delta.y,
										z = pos.z + sign_info.delta.z}, "default:text")
	text:setyaw(sign_info.yaw)
end

-- What kind of sign do we need to place, anyway?

function signs_lib.determine_sign_type(itemstack, placer, pointed_thing)
	local name
	name = minetest.get_node(pointed_thing.under).name
	if fences_with_sign[name] then
		if minetest.is_protected(pointed_thing.under, placer:get_player_name()) then
			minetest.record_protection_violation(pointed_thing.under,
				placer:get_player_name())
			return itemstack
		end
	else
		name = minetest.get_node(pointed_thing.above).name
		local def = minetest.registered_nodes[name]
		if not def.buildable_to then
			return itemstack
		end
		if minetest.is_protected(pointed_thing.above, placer:get_player_name()) then
			minetest.record_protection_violation(pointed_thing.above,
				placer:get_player_name())
			return itemstack
		end
	end

	local node=minetest.get_node(pointed_thing.under)

	if minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].on_rightclick then
		return minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, placer, itemstack)
	else
		local above = pointed_thing.above
		local under = pointed_thing.under
		local dir = {x = under.x - above.x,
					 y = under.y - above.y,
					 z = under.z - above.z}

		local wdir = minetest.dir_to_wallmounted(dir)

		local placer_pos = placer:getpos()
		if placer_pos then
			dir = {
				x = above.x - placer_pos.x,
				y = above.y - placer_pos.y,
				z = above.z - placer_pos.z
			}
		end

		local fdir = minetest.dir_to_facedir(dir)

		local sign_info
		local pt_name = minetest.get_node(under).name
		print(dump(pt_name))
		local signname = itemstack:get_name()

		if fences_with_sign[pt_name] and signname == "default:sign_wall" then
			minetest.add_node(under, {name = fences_with_sign[pt_name], param2 = fdir})
			sign_info = signs_lib.sign_post_model.textpos[fdir + 1]

		elseif wdir == 0 and signname == "default:sign_wall" then
			minetest.add_node(above, {name = "default:sign_hanging", param2 = fdir})
			sign_info = signs_lib.hanging_sign_model.textpos[fdir + 1]

		elseif wdir == 1 and signname == "default:sign_wall" then
			minetest.add_node(above, {name = "default:sign_yard", param2 = fdir})
			sign_info = signs_lib.yard_sign_model.textpos[fdir + 1]

		else
			minetest.add_node(above, {name = signname, param2 = fdir})
			sign_info = signs_lib.wall_sign_model.textpos[fdir + 1]
		end

		local text = minetest.add_entity({x = above.x + sign_info.delta.x,
											  y = above.y + sign_info.delta.y,
											  z = above.z + sign_info.delta.z}, "default:text")
		text:setyaw(sign_info.yaw)

		if not signs_lib.expect_infinite_stacks then
			itemstack:take_item()
		end
		return itemstack
	end
end

function signs_lib.receive_fields(pos, formname, fields, sender)
	if minetest.is_protected(pos, sender:get_player_name()) then
		minetest.record_protection_violation(pos,
			sender:get_player_name())
		return
	end
	if fields and fields.text and fields.ok then
		minetest.log("action", S("%s wrote \"%s\" to sign at %s"):format(
			(sender:get_player_name() or ""),
			fields.text,
			minetest.pos_to_string(pos)
		))
		signs_lib.update_sign(pos, fields)
	end
end


minetest.register_alias("sings:sign_wall","default:sign_wall")

minetest.register_node("default:sign_wall", {
	description = S("Sign"),
	node_placement_prediction = "",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = signs_lib.wall_sign_model.nodebox,
	tiles = {"default_junglewood.png", "default_junglewood.png", "default_junglewood.png", "default_junglewood.png", "default_junglewood.png", "default_sign_front.png"},
	groups = sign_groups,

	on_place = function(itemstack, placer, pointed_thing)
		return signs_lib.determine_sign_type(itemstack, placer, pointed_thing)
	end,
	on_construct = function(pos)
		signs_lib.construct_sign(pos)
	end,
	on_destruct = function(pos)
		signs_lib.destruct_sign(pos)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		signs_lib.receive_fields(pos, formname, fields, sender)
	end,
	on_punch = function(pos, node, puncher)
		signs_lib.update_sign(pos)
	end,
})

minetest.register_alias("signs:sign_yard", "default:sign_yard")

minetest.register_node("default:sign_yard", {
    paramtype = "light",
	sunlight_propagates = true,
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = signs_lib.yard_sign_model.nodebox,
    tiles = {"default_junglewood.png", "default_junglewood.png", "default_junglewood.png", "default_junglewood.png", "default_junglewood.png", "default_sign_front.png"},
    groups = {choppy=2, dig_immediate=2},
    drop = "default:sign_wall",

    on_construct = function(pos)
        signs_lib.construct_sign(pos)
    end,
    on_destruct = function(pos)
        signs_lib.destruct_sign(pos)
    end,
	on_receive_fields = function(pos, formname, fields, sender)
		signs_lib.receive_fields(pos, formname, fields, sender)
	end,
	on_punch = function(pos, node, puncher)
		signs_lib.update_sign(pos)
	end,
})

minetest.register_alias("signs:sign_hanging", "default:sign_hanging")

minetest.register_node("default:sign_hanging", {
    paramtype = "light",
	sunlight_propagates = true,
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = signs_lib.hanging_sign_model.nodebox,
    tiles = {"default_junglewood.png", "default_junglewood.png", "default_junglewood.png", "default_junglewood.png", "default_hangingsign_back.png", "default_hangingsign_front.png"},
    groups = {choppy=2, dig_immediate=2},
    drop = "default:sign_wall",

    on_construct = function(pos)
        signs_lib.construct_sign(pos)
    end,
    on_destruct = function(pos)
        signs_lib.destruct_sign(pos)
    end,
	on_receive_fields = function(pos, formname, fields, sender)
		signs_lib.receive_fields(pos, formname, fields, sender)
	end,
	on_punch = function(pos, node, puncher)
		signs_lib.update_sign(pos)
	end,
})

local signs_text_on_activate

signs_text_on_activate = function(self)
	local meta = minetest.get_meta(self.object:getpos())
	local text = meta:get_string("text")
	local new = (meta:get_int("__signslib_new_format") ~= 0)
	if text then
		set_obj_text(self.object, text, new)
	end
end

minetest.register_alias("signs:text", "default:text")

minetest.register_entity(":default:text", {
    collisionbox = { 0, 0, 0, 0, 0, 0 },
    visual = "upright_sprite",
    textures = {},

	on_activate = signs_text_on_activate,
})

-- And the good stuff here! :-)

function signs_lib.register_fence_with_sign(fencename, fencewithsignname)
    local def = minetest.registered_nodes[fencename]
    local def_sign = minetest.registered_nodes[fencewithsignname]
    if not (def and def_sign) then
        minetest.log("warning", "[signs_lib] Attempt to register unknown node as fence")
        return
    end
    def = signs_lib.table_copy(def)
    def_sign = signs_lib.table_copy(def_sign)
    fences_with_sign[fencename] = fencewithsignname

    def.on_place = function(itemstack, placer, pointed_thing, ...)
		local node_above = minetest.get_node(pointed_thing.above)
		local node_under = minetest.get_node(pointed_thing.under)
		local def_above = minetest.registered_nodes[node_above.name]
		local def_under = minetest.registered_nodes[node_under.name]
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local playername = placer:get_player_name()

		if minetest.is_protected(pointed_thing.under, playername) then
			minetest.record_protection_violation(pointed_thing.under, playername)
			return
		end

		if minetest.is_protected(pointed_thing.above, playername) then
			minetest.record_protection_violation(pointed_thing.above, playername)
			return
		end

		if def_under and def_under.on_rightclick then
			return def_under.on_rightclick(pointed_thing.under, node_under, placer, itemstack) or itemstack
		elseif def_under and def_under.buildable_to then
			minetest.add_node(pointed_thing.under, {name = fencename, param2 = fdir})
			if not signs_lib.expect_infinite_stacks then
				itemstack:take_item()
			end
			placer:set_wielded_item(itemstack)
			return itemstack
		elseif not def_above or def_above.buildable_to then
			minetest.add_node(pointed_thing.above, {name = fencename, param2 = fdir})
			if not signs_lib.expect_infinite_stacks then
				itemstack:take_item()
			end
			placer:set_wielded_item(itemstack)
			return itemstack
		end
	end
	def_sign.on_construct = function(pos, ...)
		signs_lib.construct_sign(pos)
	end
	def_sign.on_destruct = function(pos, ...)
		signs_lib.destruct_sign(pos)
	end
	def_sign.on_receive_fields = function(pos, formname, fields, sender)
		signs_lib.receive_fields(pos, formname, fields, sender)
	end
	def_sign.on_punch = function(pos, node, puncher, ...)
		signs_lib.update_sign(pos)
	end
	local fencename = fencename
	def_sign.after_dig_node = function(pos, node, ...)
	    node.name = fencename
	    minetest.add_node(pos, node)
	end
    def_sign.drop = "default:sign_wall"
	minetest.register_node(":"..fencename, def)
	minetest.register_node(":"..fencewithsignname, def_sign)
	print(S("Registered %s and %s"):format(fencename, fencewithsignname))
end

build_char_db()

minetest.register_alias("homedecor:fence_wood_with_sign", "default:sign_post")

signs_lib.register_fence_with_sign("default:fence_wood", "default:sign_post")

if minetest.setting_get("log_mods") then
	minetest.log("action", S("signs loaded"))
end