
local forceTeamLimit = CreateConVar("d_forceteamlimit", "-1", bit.bor(FCVAR_REPLICATED))

function GetMaxTeamPlayers()
	if forceTeamLimit:GetInt() >= 0 then
		return forceTeamLimit:GetInt()
	end

	return math.max(2, math.min(4, math.ceil(TeamMembersPerPlayers * #player.GetAll())))
end

--[[
Team convars
]]

local joinstatus = CreateClientConVar("d_teamjoinstatus", "private", false, true) -- default to private
--cvars.NetworkConvarChange("d_teamjoinstatus")

--[[
Team meta methods
]]
local meta = {}
function meta:GetMembers()
	return self.members
end

function meta:GetLeader()
	return self.leader
end

function meta:HasAliveMember()
	for _, v in pairs(self:GetMembers()) do
		if IsValid(v) and v:Alive() then
			return true
		end
	end

	if IsValid(self:GetLeader()) and self:GetLeader():Alive() then
		return true
	end

	return false
end

function meta:GetNumberOfMembers()
	local cnt = 0
	for _, v in pairs(self:GetMembers()) do
		if IsValid(v) then
			cnt = cnt + 1
		end
	end

	if IsValid(self:GetLeader()) then
		cnt = cnt + 1
	end

	return cnt
end

function meta:GetID()
	return self.id
end

function meta:GetColor()
	return self.color
end

function meta:GetName()
	return self.name
end

function meta:HasInvite(ply)
	return self.invites[ply]
end

function meta:IsPublic()
	return self.public
end

function meta:InvitePlayer(ply)
	if not IsValid(ply) then return end
	self.invites[ply] = true

	RunConsoleCommand("d_teaminvite", ply:UserID())
end

function meta:KickPlayer(ply)
	if not IsValid(ply) then return end

	RunConsoleCommand("d_teamkick", ply:UserID())
end

function meta:TransferLeadership(ply)
	if not IsValid(ply) then return end

	RunConsoleCommand("d_teamtransferleader", ply:UserID())
end

function meta:ChangeName(newname)
	RunConsoleCommand("d_teamchangename", newname)
end

function meta:Destroy()
	RunConsoleCommand("d_teamdestroy")
end

function meta:ReadNetData()
	net.FMReadEntity(function(e)
		self.leader = e
		e:SetCTeam(self)
		e.isleader = true
	end)
	self.color = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))

	self.members = {}
	for j = 1, net.ReadUInt(8) do
		net.FMReadEntity(function(e)
			self.members[j] = e
			e:SetCTeam(self)
		end)
	end

	self.invites = {}
	for _ = 1, net.ReadUInt(8) do
		net.FMReadEntity(function(e)
			self.invites[e] = true
		end)
	end
	self.public = net.ReadBool()

	self.name = net.ReadString()
end

function meta:IsValid()
	return not self.removed
end

function meta.__tostring(a)
	return string.format("Team{#%i, %s}", a.id, a.name)
end

meta.__index = meta

local function CreateTeamObject(id)
	local t = {}
	setmetatable(t, meta)
	t.id = id

	t.name = ""
	t.color = HSVToColor(0, 0.63, 0.8)
	t.members = {}
	t.invites = {}
	t.removed = false

	if joinstatus:GetString() == "public" then
		t.public = true
	else
		t.public = false
	end

	table.insert(GetCTeams(), t)
	return t
end

local function UpdatePlayerCTeams()
	for k,v in pairs(player.GetAll()) do
		v:SetCTeam()
	end

	for _,v in pairs(GetCTeams()) do
		if IsValid(v.leader) then
			v.leader:SetCTeam(v)
			v.leader.isleader = true
		end

		for _,v2 in pairs(v.members) do
			if IsValid(v2) then
				v2:SetCTeam(v)
			end
		end
	end
end

net.Receive("FMSendAllTeams", function()
	GAMEMODE.CTeams = {}

	for _ = 1, net.ReadUInt(5) do
		local tm = CreateTeamObject(net.ReadUInt(32))
		tm:ReadNetData()
	end

	UpdatePlayerCTeams()

	hook.Run("FMTeamsUpdate")
end)

net.Receive("FMSendTeam", function()
	local id = net.ReadUInt(32)
	local tm = GetCTeamByID(id)
	if not tm then
		tm = CreateTeamObject(id)
	end

	tm:ReadNetData()

	UpdatePlayerCTeams()

	hook.Run("FMTeamsUpdate")
end)

net.Receive("FMTeamDestroy", function()
	local id = net.ReadUInt(32)
	local tm = GetCTeamByID(id)
	if tm then
		if IsValid(tm.leader) then
			tm.leader:SetCTeam()
		end

		for k,v in pairs(tm.members) do
			if IsValid(v) then
				v:SetCTeam()
			end
		end

		tm.removed = true

		for k,v in pairs(GetCTeams()) do
			if v == tm then
				table.remove(GetCTeams(), k)
				break
			end
		end

		hook.Run("FMTeamsUpdate")
	end
end)

--[[
Admin stuff
]]
local function GetTeamDebugInfo()
	return dp(GetCTeams())
end

net.Receive("FMReqTeamDebugInfoAdmin", function()
	net.Start("FMTeamDebugInfoAdmin")
		net.WriteString(GetTeamDebugInfo())
	net.SendToServer()
end)

net.Receive("FMTeamDebugInfoAdminPrint", function()
	local msg = net.ReadString()

	printDebug(msg)
end)
