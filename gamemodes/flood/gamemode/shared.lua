DeriveGamemode("sandbox")

TEAM_NORMAL = 1
TEAM_DEAD = 2

team.SetUp (TEAM_NORMAL, "Player", Color (0, 0, 205, 255))
team.SetUp (TEAM_DEAD, "Dead", Color (80, 80, 80, 255))

--[[---------------------------------------------------------
  Relevant information
---------------------------------------------------------]]

GM.Name 	= "Flood"
GM.Author 	= "Devinity"
GM.Email 	= "admin@devinity.org"
GM.Website 	= "Devinity.org"

hook.Remove("PlayerTick", "TickWidgets")

local realmColor = SERVER and HSVToColor(200, 0.63, 0.8) or HSVToColor(58, 0.63, 0.8)
local colDebug = Color(53, 154, 243)
local colInfo = Color(230, 230, 230)
local colWarn = Color(243, 204, 53)
local colError = Color(243, 53, 53)
local function printCol(col, frmt, ...)
	MsgC(realmColor, "[FM] ", col, frmt:format(...), "\n")
end

function printDebug(frmt, ...) printCol(colDebug, frmt, ...) end
function printInfo(frmt, ...) printCol(colInfo, frmt, ...) end
function printWarn(frmt, ...) printCol(colWarn, frmt, ...) end
function printError(frmt, ...) printCol(colError, frmt, ...) end

--[[
Used to test for existance before calling require
]]
function moduleExist(name)
	local realmName = SERVER and "sv" or "cl"
	local systemName = system.IsLinux() and "linux" or (system.IsWindows() and "win32" or "osx")
	local binaryName = ("lua/bin/gm%s_%s_%s.dll"):format(realmName, name, systemName)
	if file.Exists(binaryName, "GAME") then
		return true
	end

	local luaName = ("lua/includes/modules/%s.lua"):format(name)
	if file.Exists(luaName, "GAME") then
		return true
	end

	return false
end

--[[
Flood stuff
]]
TIME_BUILD   = bit.lshift(1, 0)
TIME_PREPARE = bit.lshift(1, 1)
TIME_FLOOD   = bit.lshift(1, 2)
TIME_FIGHT   = bit.lshift(1, 3)
TIME_REFLECT = bit.lshift(1, 4)

--[[
Stuff
]]
function GM:FMDefaultColors()
	return Color(61, 87, 105), Color(77, 459, 536)
end

local map
function isMap(name)
	map = map or game.GetMap()
	if map == nil then return false end
	return string.match(map, name)
end

function FMIsMapCanals() return isMap("fm_buildaboat_canal") end
function FMIsMapCave() return isMap("fm_buildaboat_cave") end

function ret_PrintTable( t, indent, done, rett )

	done = done or {}
	indent = indent or 0
	rett = rett or {}
	local keys = table.GetKeys( t )

	table.sort( keys, function( a, b )
		if ( isnumber( a ) && isnumber( b ) ) then return a < b end
		return tostring( a ) < tostring( b )
	end )

	for i = 1, #keys do
		local key = keys[ i ]
		local value = t[ key ]
		rett[#rett + 1] = string.rep( "\t", indent )

		if  ( istable( value ) && !done[ value ] ) then

			done[ value ] = true
			rett[#rett + 1] = tostring( key ) .. ":" .. "\n"
			ret_PrintTable ( value, indent + 2, done, rett )
			done[ value ] = nil

		else

			rett[#rett + 1] = tostring( key ) .. "\t=\t"
			rett[#rett + 1] = tostring( value ) .. "\n"

		end

	end

	return table.concat(rett, "")
end

function dp(...)
	local out = {}
	for k,v in pairs({...}) do
		if istable(v) then
			out[#out + 1] = "\n" .. ret_PrintTable(v)
		else
			out[#out + 1] = tostring(v)
		end
	end
	return table.concat(out, "\t")
end
