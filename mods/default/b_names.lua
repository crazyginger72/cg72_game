
-- No guests mod.
-- By VanessaE, sfan5, and kaeza.
-- more disallowed by crazyginger72


--added profanity filter to list
local disallowed = { 
	
	["[s]+[u]+[k]+[a4]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

	["[s]+[u]+[c]+[a4]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

	["[s]+[u]+[c]+[k]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

	["[d]+[1il]+[c]+[k]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",
	["[c]+[u]+[n]+[t]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

	["[n]+[1il]+[g]+[e3]+[r]+"]                =  "profanity names are not allowed" ..  
                                "please choose a proper name",

	["[s]+[h]+[1li]+[t]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

	["[p]+[u]+[s]+[y]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

	["[f]+[u]+[c]+[k]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

	["[n]+[i1l]+[g]+[a4]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

    ["[t]+[w]+[4a]+[t]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

    ["[c]+[o0]+[c]+[k]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

    ["[b]+[i1l]+[t]+[c]+[h]+"]                =   "profanity names are not allowed" ..  
                                "please choose a proper name",

    ["[p]+[u]+[s]+"]                =   "close to profanity names are not allowed" ..  
                                "please choose a proper name",
	["s[e3]x"]		=	"That is a clearly false, misleading, or otherwise disallowed username. "..
								"Please choose a unique username and try again.",
    ["[c]+[r]+[4a]+[z]+[y]+[g]+[i1l]+[n]+[g]+[3e]+[r]+"]  =  "that is too close to the server owners name"..         
                               "pick a new name",
	["w[0o]r[li1]d[e3]d[il1]t"]		=	"That is a clearly false, misleading, or otherwise disallowed username. "..
								"Please choose a unique username and try again.",
	["s[e3]rv[e3]r"]		=	"That is a clearly false, misleading, or otherwise disallowed username. "..
								"Please choose a unique username and try again.",
	["guest"]				=	"Guest accounts are disallowed on this server.  "..
								"Please choose a proper username and try again.",
	["[4a]dm[1il]n"]		=	"That is a clearly false, misleading, or otherwise disallowed username. "..
								"Please choose a unique username and try again.",
	["^[0-9]+$"]			=	"All-numeric usernames are disallowed on this server. "..
								"Please choose a proper username and try again.",
	["[0-9].-[0-9].-[0-9].-[0-9].-[0-9]"]	=	"Too many numbers in your username. "..
												"Please try again with less than five digits in your username."
}

-- Original implementation (in Python) by sfan5
local function judge(msg)
	local numspeakable = 0
	local numnotspeakable = 0
	local cn = 0
	local lastc = '____'
	for c in msg:gmatch(".") do
		c = c:lower()
		if c:find("[aeiou0-9_-]") then
			if cn > 2 and not c:find("[0-9]") then
				numnotspeakable = numnotspeakable + 1
			elseif not c:find("[0-9]") then
				numspeakable = numspeakable + 1
			end
			cn = 0
		else
			if (cn == 1) and (lastc == c) and (lastc ~= 's') then
				numnotspeakable = numnotspeakable + 1
				cn = 0
			end
			if cn > 2 then
				numnotspeakable = numnotspeakable + 1
				cn = 0
			end
			if lastc:find("[aeiou]") then
				numspeakable = numspeakable + 1
				cn = 0
			end
			if not ((lastc:find("[aipfom]") and c == "r") or (lastc == "c" and c == "h")) then
				cn = cn + 1
			end
		end
		lastc = c
	end
	if cn > 0 then
		numnotspeakable = numnotspeakable + 1
	end
	return (numspeakable >= numnotspeakable)
end

minetest.register_on_prejoinplayer(function(name, ip)
        local lname = name:lower()

        if name ~= "crazyginger72" then
             for re, reason in pairs(disallowed) do
                      if lname:find(re) then
                                return reason
                      end
             end
     
             if #name < 2 then
                    return "Too short of a username. "..
                                     "Please pick a name with at least two letters and try again."
             end

             if not judge(name) and #name > 5 then
                     return "Your username just plain looks like gibberish. "..
                                     "Please pick something readable and try again."
             end
      end
end)
