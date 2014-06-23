
local old_is_protected = minetest.is_protected
function minetest.is_protected(pos, name)
	if not default:canInteract(pos, name) then
		return true
	end
	return old_is_protected(pos, name)
end

minetest.register_on_protection_violation(function(pos, name)
	if not adefault:canInteract(pos, name) then
		local owners = default:getNodeOwners(pos)
		minetest.chat_send_player(name,
			("%s is protected by %s."):format(
				minetest.pos_to_string(pos),
				table.concat(owners, ", ")))
	end
end)

