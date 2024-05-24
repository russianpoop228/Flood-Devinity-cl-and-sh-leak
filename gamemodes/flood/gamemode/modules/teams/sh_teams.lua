
GM.CTeams = GM.CTeams or {}
function GetCTeam(name)
	for _,v in pairs(GetCTeams()) do
		if not IsValid(v) then continue end
		if v.name == name then return v end
	end
end

function GetCTeamByID(id)
	for _,v in pairs(GetCTeams()) do
		if not IsValid(v) then continue end
		if v.id == id then return v end
	end
end

function GetCTeams()
	return (GAMEMODE or GM).CTeams
end

local plymeta = FindMetaTable("Player")
--[[
Player <-> Team helper methods
]]
function plymeta:SetCTeam(tm)
	self._cteam = tm

	if not tm then
		self.isleader = false
	end
end

function plymeta:CTeam()
	if not IsValid(self._cteam) then return end
	return self._cteam
end

function plymeta:IsLeader()
	if not IsValid(self._cteam) then return false end
	return self.isleader
end

function plymeta:SameTeam(ply)
	if not IsValid(self) or not IsValid(ply) then return false end
	if self == ply then return true end
	if not IsValid(self._cteam) or not IsValid(ply._cteam) then return false end
	return self._cteam == ply._cteam
end
