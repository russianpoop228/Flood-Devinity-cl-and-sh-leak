
local plymeta = FindMetaTable("Player")

CreateClientConVar("d_hidename", "", true, true)
cvars.NetworkConvarChange("d_hidename")

local function GetRandomSteamID()
	return "7656119" .. tostring( 7960265728 + math.random( 1, 200000000 ) )
end

net.Receive("FMSendCustomName", function()
	local customname = net.ReadString()
	net.FMReadEntity(function(ply)
		local apply = true
		if customname == "" then
			apply = false
		end

		if apply then
			ply.customname = customname
			ply.fakesteamid = GetRandomSteamID()
			ply.fakesteamid32 = util.SteamIDFrom64(ply.fakesteamid)

			local seed = tonumber(ply.fakesteamid:sub(-9,-1))
			math.randomseed(seed)
			ply.fakeskill = math.random(1,30) -- Assign a "skill" to this player, this will influence how many achievements, weapons, playtime, etc, this player got
			                                  -- Note that this skill is entirely based on the steamid meaning you always get the same skill for the same fake player
		else
			ply.customname = nil
			ply.fakesteamid = nil
			ply.fakesteamid32 = nil
			ply.fakeskill = nil
		end
	end)
end)

if not plymeta.SteamName then
	local GetPlyName = function(self)
		if self.customname then
			return self.customname
		else
			return self:SteamName()
		end
	end
	plymeta.SteamName = plymeta.Nick
	plymeta.Nick = GetPlyName
	plymeta.Name = GetPlyName
	plymeta.GetName = GetPlyName
end

function plymeta:FMSteamID()
	return self.fakesteamid32 or self:SteamID()
end

function plymeta:FMSteamID64()
	return self.fakesteamid or self:SteamID64()
end
