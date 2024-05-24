
RANK_USER = 0
RANK_BRONZE = 1
RANK_SILVER = 2
RANK_GOLD = 3
RANK_PLATINUM = 4
RANK_JUNIOR = 5
RANK_MOD = 6
RANK_SENIOR = 7
RANK_ADMIN = 8
RANK_SUPERADMIN = 9
RANK_DEVELOPER = 10

local plymeta = FindMetaTable("Player")

function plymeta:IsMod()
	return self:GetMODTier() >= RANK_MOD
end

function plymeta:IsAdmin()
	return self:GetMODTier() >= RANK_ADMIN
end

function plymeta:IsSuperAdmin()
	return self:GetMODTier() >= RANK_SUPERADMIN
end

local ranktostring = {
	[RANK_USER]       = "user",
	[RANK_BRONZE]     = "user",
	[RANK_SILVER]     = "user",
	[RANK_GOLD]       = "user",
	[RANK_PLATINUM]   = "user",
	[RANK_JUNIOR]     = "juniormod",
	[RANK_MOD]        = "moderator",
	[RANK_SENIOR]     = "seniormod",
	[RANK_ADMIN]      = "admin",
	[RANK_SUPERADMIN] = "superadmin",
	[RANK_DEVELOPER]  = "developer",
}

function plymeta:GetUserGroup()
	return ranktostring[self:GetMODTier()]
end

function plymeta:IsUserGroup(str)
	return self:GetUserGroup() == str
end

function plymeta:SetUserGroup() end -- Don't do anything

CMDARG_PLAYER    = 1
CMDARG_PLAYERS   = 2
CMDARG_STEAMID   = 3
CMDARG_NUMBER    = 4
CMDARG_EOLSTRING = 5
CMDARG_STRING    = 6

local units = {
	["y"]  = 365 * 24 * 3600,
	["mo"] = 30 * 24 * 3600,
	["w"]  = 7 * 24 * 3600,
	["d"]  = 24 * 3600,
	["h"]  = 3600,
	["m"]  = 60,
	["s"]  = 1,
}

function ParseDurationStringToSeconds(str)
	if str:match("^%d+$") then
		return tonumber(str) * 60
	end

	str = str:lower()

	local secs = 0
	for dur, unit in str:gmatch("([0-9]+)([a-z]+)") do
		if not units[unit] then
			return false, "Invalid unit \"" .. unit .. "\""
		end

		secs = secs + dur * units[unit]
	end

	return secs
end

function ParseDurationStringToMinutes(str)
	if str:match("^%d+$") then
		return tonumber(str)
	end

	str = str:lower()

	local secs = 0
	for dur, unit in str:gmatch("([0-9]+)([a-z]+)") do
		if not units[unit] or unit == "s" then
			return false, "Invalid unit \"" .. unit .. "\""
		end

		secs = secs + math.Round(dur * units[unit] / 60)
	end

	return secs
end
