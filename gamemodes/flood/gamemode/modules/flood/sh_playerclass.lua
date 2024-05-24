
local plymeta = FindMetaTable("Player")

DEFINE_BASECLASS( "player_default" )

local PLAYER = {}
PLAYER.DisplayName = "Flood Player"

function PLAYER:Loadout()
end

local function UpdatePlayerColors(ply)
	local plycol
	local wepcol
	if ply:GetVIPTier() >= RANK_BRONZE then
		plycol = Vector(ply:GetInfo("cl_playercolor"))
		wepcol = Vector(ply:GetInfo("cl_weaponcolor"))
	else
		local defplyclr, defphysclr = hook.Run("FMDefaultColors", ply)

		plycol = ColorToVector(defplyclr)
		wepcol = ColorToVector(defphysclr)
	end

	ply:SetPlayerColor(ply.plycoloverride or plycol)
	ply:SetWeaponColor(ply.wepcoloverride or wepcol)
end

function plymeta:OverridePlayerColor(col)
	self.plycoloverride = col and ColorToVector(col) or nil
	UpdatePlayerColors(self)
end

function plymeta:OverrideWeaponColor(col)
	self.wepcoloverride = col and ColorToVector(col) or nil
	UpdatePlayerColors(self)
end

function PLAYER:Spawn()
	BaseClass.Spawn(self)
	UpdatePlayerColors(self.Player)
end

--Check for changes and update automagically
if CLIENT then
	cvars.NetworkConvarChange("cl_playercolor")
	cvars.NetworkConvarChange("cl_weaponcolor")
else
	hook.Add("PlayerConvarChanged", "UpdateColors", function(ply,cvar,old,new)
		if cvar == "cl_playercolor" or cvar == "cl_weaponcolor" then
			UpdatePlayerColors(ply)
		end
	end)
end

--VIP is loaded after ply:Spawn(), thus we need to update colors
if SERVER then
	hook.Add("FMVIPRankReceived", "PlayerClass", function(ply,rank)
		UpdatePlayerColors(ply)
	end)
end

--[[
Hands
]]
local lookup
local function ModelToName( mdl )
	if not lookup then
		lookup = {}
		for name,model in pairs(player_manager.AllValidModels()) do
			lookup[model:lower()] = name
		end
	end

	return lookup[mdl:lower()] or "male01"
end

function PLAYER:GetHandsModel()
	return player_manager.TranslatePlayerHands( ModelToName(self.Player:GetModel()) )
end

--[[
Misc
]]
function plymeta:GetPlayTime()
	if self.fakeskill then
		return math.Round(((self.fakeskill + 5) * 50) ^ 1.5)
	end

	return self.playtime or 0
end

function plymeta:GetPlayerLevel()
	if self.fakeskill then
		return math.Round((self.fakeskill + 2) * 1.5)
	end

	return self.plvl or 0
end

function plymeta:GetCustomDescription()
	if self.fakeskill then return end

	return self:GetNWString("FMCustomDesc")
end

function plymeta:GetRegisteredDate()
	if self.fakeskill then
		local unixstart = 1451606400
		local unixend = 1501545600
		local diff = unixend - unixstart

		local regdate = unixstart + math.Round(diff / 30 * (30 - self.fakeskill))
		return regdate
	end

	return self:GetNWInt("FMRegDate")
end

hook.Add("FMPlayerExtrasDataInit", "MiscPlayerData", function(ply, extrastbl, playertbl)
	if extrastbl["description"] then
		ply:SetNWString("FMCustomDesc", extrastbl["description"])
	end

	ply:SetNWInt("FMRegDate", os.UnixTimestamp(playertbl["joined"] or "2015-06-01 12:00:00"))
end)

--[[
Cash
]]
function plymeta:CanAfford(am)
	if self.fakeskill then
		return (self.GetInternalCash and self:GetInternalCash() or 0) >= am -- Check with internal cash instead
	end

	return (self:GetCash() or 0) >= am
end

if CLIENT then
	net.Receive("FMCashNotification", function()
		local newam = net.ReadUInt(32)

		util.WaitForLocalPlayer(function()
			LocalPlayer():SetInternalCash(newam)
		end)

		hook.Run("FMCashUpdate", newam)
	end)
end

if SERVER then
	util.AddNetworkString("FMCashNotification")
	function plymeta:SetCash(a,nosave)
		a = math.Clamp(math.floor(a), 0, 4294967294) -- Limit to 32bit number (I somehow think nobody will need this anyway)

		net.Start("FMCashNotification")
			net.WriteUInt(a, 32)
		net.Send(self)

		self:SetInternalCash(a)

		if not nosave then
			self:SaveCash()
		end
	end
end
function plymeta:GetCash(showreal)
	if CLIENT and self != LocalPlayer() and not self.GetInternalCash then
		RunConsoleCommand("_requestfmdt")
		return 0
	end

	if not showreal and self.fakeskill then
		return math.Round(((self.fakeskill + 10) * 100) ^ 1.3 + 3000)
	end

	return self.GetInternalCash and self:GetInternalCash() or 0
end

if SERVER then
	util.AddNetworkString("FMUpdatePlayerDataTables")
end
function PLAYER:SetupDataTables()
	BaseClass.SetupDataTables( self )

	if SERVER and #player.GetAll() > 1 then
		net.Start("FMUpdatePlayerDataTables")
		net.Broadcast()
	end

	self.Player:NetworkVar("Int", 0, "InternalCash")
	self.Player:NetworkVar("Int", 1, "DamageDone")
end

--This all datatable updating code is a huge thanks to NutScript!
if CLIENT then
	net.Receive("FMUpdatePlayerDataTables", function()
		for k,v in pairs(player.GetAll()) do
			if v != LocalPlayer() and not v.GetInternalCash then
				player_manager.RunClass(v, "SetupDataTables")
			end
		end
	end)
else
	concommand.Add("_requestfmdt", function(ply)
		if #player.GetAll() < 2 then return end

		if (ply.nextdtupdate or 0) > CurTime() then return end
		ply.nextdtupdate = CurTime() + 10

		net.Start("FMUpdatePlayerDataTables")
		net.Send(ply)
	end)
end

player_manager.RegisterClass( "floodplayer", PLAYER, "player_default" )
