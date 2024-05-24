
surface.CreateFont("ScoreboardDefault",
{
	font = "Arimo Bold",
	size = 19
})

surface.CreateFont("ScoreboardDefaultTitle",
{
	font   = "Arimo Bold",
	size   = 20,
	weight = 500
})

surface.CreateFont("FMFontAwesome",
{
	font     = "FontAwesome",
	size     = 18,
	extended = true
})

local function DrawPanel(x, y, w, h, col)
	derma.GetDefaultSkin().tex.Panels.Bright(x, y, w, h, col)
end

local rankw = 120
local lvlw = 60
local namew = 200
local teamw = 160
local propbarw = 128 + 10
local damagew = 70
local cashw = 90
local deathw = 60
local pingw = 50
local mutedw = 20
local rowwidth = 24 + 8 + 6 + rankw + lvlw + namew + teamw + propbarw + damagew + cashw + deathw + pingw + mutedw

local kickreasons = {
	"Ban evasion",
	"Excessive foul language",
	"Exploitation - Glitching",
	"Exploitation - Modding",
	"Flaming",
	"Harassment",
	"Minging - Blocking doors",
	"Minging - Pinning/Trapping player(s)",
	"Minging - Prop pushing",
	"Minging - Sabotage",
	"Minging - Spamming",
	"Offensive team name",
	"Overly disrespectful/rude",
	"Racism",
	"Round delaying - Last-minute trucing",
	"Round delaying - Prop farming",
	"Sexism",
	"Spamming - Chat",
	"Spamming - Props",
	"Spamming - Voice",
	"Threatening to DDoS",
	"Trucing",
}
local banreasons = kickreasons
local bantimes = {
	["0"]   = "Perma",
	["1h"]  = "1 Hour",
	["12h"] = "½ Day",
	["1d"]  = "1 Day",
	["2d"]  = "2 Days",
	["3d"]  = "3 Days",
	["4d"]  = "4 Days",
	["5d"]  = "5 Days",
	["6d"]  = "6 Days",
	["1w"]  = "1 Week",
	["2w"]  = "2 Weeks",
	["1mo"] = "1 Month",
}

local gagmutetimes = {
	[0]       = "Session",
	[30]      = "30 Seconds",
	[1 * 60]  = "1 Minute",
	[2 * 60]  = "2 Minutes",
	[5 * 60]  = "5 Minutes",
	[10 * 60] = "10 Minutes",
	[15 * 60] = "15 Minutes",
	[30 * 60] = "30 Minutes",
	[60 * 60] = "1 Hour",
}

local function OpenReasonPopup(title, callback)
	local popup = vgui.Create("DFrame")
		popup:SetSize(260, 90)
		popup:Center()
		popup:SetSizable(true)
		popup:SetTitle(title)
		popup:MakePopup()

	local rsnentry = vgui.Create("DTextEntry", popup)
		rsnentry:Dock(FILL)
		rsnentry:SetText("<reason>")

	local okay = vgui.Create("DButton", popup)
		okay:Dock(BOTTOM)
		okay:DockMargin(0, 5, 0, 0)
		okay:SetText("Okay")
		okay.DoClick = function()
			local reason = rsnentry:GetValue()
			if reason == "<reason>" then return end

			if IsValid(popup) then
				popup:Close()
			end

			callback(reason)
		end
end

local function DoChatCmd(cmd, ...)
	LocalPlayer():ConCommand(string.format("say %s %s", cmd, table.concat({...}, " ")))
end

local function OpenBanPopup(target, bantime)
	local prettytime
	if bantime > 0 then
		prettytime = string.NiceTime(bantime * 60)
	else
		prettytime = "Permanent"
	end

	if not IsValid(target) then	return end

	OpenReasonPopup(string.format("Ban on %s for %s", target:FilteredNick(), prettytime), function(reason)
		DoChatCmd("!ban", target:UserID(), bantime, reason)
	end)
end

local function OpenKickPopup(target)
	if not IsValid(target) then	return end
	OpenReasonPopup(string.format("Kick %s", target:FilteredNick()), function(reason)
		DoChatCmd("!kick", target:UserID(), reason)
	end)
end

local function OpenWarnPopup(target)
	if not IsValid(target) then	return end

	local name
	if type(target) == "Player" then
		name = target:FilteredNick()
	else
		name = "team " .. target:GetName()
	end

	OpenReasonPopup(string.format("Warn %s", name), function(reason)
		if type(target) == "Player" then
			DoChatCmd("!warn", target:UserID(), reason)
		else
			DoChatCmd("!warn", "-" .. target:GetID(), reason)
		end
	end)
end

local adminmenucommands = {
	{
		cmd = "setrank",
		name = "Set Rank",
		icon = "icon16/wand.png",
		teamtarget = false,
		submenu = function(men, ply)
			for ranki = 0, RANK_DEVELOPER do
				local name = GetTierName(ranki)
				if ranki == 0 then
					name = "None"
				end

				men:AddOption(name, function()
					DoChatCmd("!setrank", ply:SteamID64(), ranki)
				end):SetImage(GetTierSilkicon(ranki))
			end
		end
	},
	{
		cmd = "kick",
		name = "Kick",
		icon = "icon16/box.png",
		teamtarget = false,
		submenu = function(men, ply)
			for _, reason in pairs(kickreasons) do
				men:AddOption(reason, function() DoChatCmd("!kick", ply:UserID(), reason) end)
			end

			men:AddOption("Other reason", function() OpenKickPopup(ply) end)
		end
	},
	{
		cmd = "ban",
		name = "Ban",
		icon = "icon16/cancel.png",
		teamtarget = false,
		submenu = function(men, ply)
			for _, reason in pairs(banreasons) do
				local sub1 = men:AddSubMenu(reason)

				for time, name in SortedPairs(bantimes) do
					sub1:AddOption(name, function() DoChatCmd("!ban", ply:UserID(), time, reason) end)
				end
			end

			local other = men:AddSubMenu("Other reason")
			for time, name in SortedPairs(bantimes) do
				other:AddOption(name, function() OpenBanPopup(ply, ParseDurationStringToMinutes(time)) end)
			end
		end
	},
	{
		cmd = "warn",
		name = "Warn",
		icon = "icon16/error.png",
		teamtarget = true,
		func = function(ply)
			OpenWarnPopup(ply)
		end
	},
	{
		cmd = "mute",
		name = "Mute",
		icon = "icon16/cup_add.png",
		teamtarget = true,
		submenu = function(men, target)
			for time, name in SortedPairs(gagmutetimes) do
				if type(target) == "Player" then
					men:AddOption(name, function() DoChatCmd("!mute", target:UserID(), time) end)
				else
					men:AddOption(name, function() DoChatCmd("!mute", "-" .. target:GetID(), time) end)
				end
			end
		end
	},
	{
		cmd = "unmute",
		name = "Un-Mute",
		icon = "icon16/cup_delete.png",
		teamtarget = true
	},
	{
		cmd = "gag",
		name = "Gag",
		icon = "icon16/joystick_add.png",
		teamtarget = true,
		submenu = function(men, target)
			for time, name in SortedPairs(gagmutetimes) do
				if type(target) == "Player" then
					men:AddOption(name, function() DoChatCmd("!gag", target:UserID(), time) end)
				else
					men:AddOption(name, function() DoChatCmd("!gag", "-" .. target:GetID(), time) end)
				end
			end
		end
	},
	{
		cmd = "ungag",
		name = "Un-Gag",
		icon = "icon16/joystick_delete.png",
		teamtarget = true
	},
	{
		cmd = "slay",
		name = "Slay",
		icon = "icon16/cross.png",
		teamtarget = true
	},
	{
		cmd = "goto",
		name = "Goto",
		icon = "icon16/cog_go.png",
		teamtarget = false
	},
	{
		cmd = "spectate",
		name = "Spectate",
		icon = "icon16/magnifier.png",
		teamtarget = false
	},
	{
		cmd = "clean",
		name = "Clean",
		icon = "icon16/delete.png",
		teamtarget = true
	},
}

local function IsEmptyTable(t)
	return next(t) == nil
end

local cmds
local function CreateAdminMenu(self, options, spacer)
	if not cmds then
		cmds = {}

		local tbl = concommand.GetTable()
		for k, _ in pairs(tbl) do
			if string.sub(k, 1, 2) == "d_" then
				cmds[string.sub(k, 3)] = true
			end
		end
	end

	if not IsEmptyTable(cmds) then
		spacer:SetTall(1)
	end

	local ply = self.Player
	local cteam = ply:CTeam()
	local inteam = IsValid(cteam)

	for _, cmdtbl in pairs(adminmenucommands) do
		if not cmds[cmdtbl.cmd] then continue end

		local function AddItems(men, name, target)
			if cmdtbl.submenu then
				local sub, pnl = men:AddSubMenu(name)
					pnl:SetImage(cmdtbl.icon)
				cmdtbl.submenu(sub, target)
			else
				if cmdtbl.func then
					men:AddOption(name, function() cmdtbl.func(target) end):SetImage(cmdtbl.icon)
				else
					if type(target) == "Player" then
						men:AddOption(name, function() DoChatCmd("!" .. cmdtbl.cmd, target:UserID()) end):SetImage(cmdtbl.icon)
					else
						men:AddOption(name, function() DoChatCmd("!" .. cmdtbl.cmd, "-" .. target:GetID()) end):SetImage(cmdtbl.icon)
					end
				end
			end
		end

		if cmdtbl.teamtarget and inteam then
			local sub, pnl = options:AddSubMenu(cmdtbl.name)
				pnl:SetImage(cmdtbl.icon)

			AddItems(sub, ply:FilteredNick(), ply)
			AddItems(sub, "Team " .. cteam:GetName(), cteam)
		else
			AddItems(options, cmdtbl.name, ply)
		end
	end
end

local function SumTable(t)
	local a = 0
	for _, v in pairs(t) do
		if not isnumber(v) then continue end

		a = a + v
	end
	return a
end

local playerpropdata
local playerpropdata_maxhp
local runtimer = true
timer.Create("PropDataGathererForScoreboard", 0.2, 0, function()
	if not runtimer then return end
	runtimer = false

	playerpropdata = {}

	if GAMEMODE:IsPhase(TIME_BUILD) then
		playerpropdata_maxhp = {}
	end

	for _, v in pairs(player.GetAll()) do
		for _, v2 in pairs(ents.GetAll()) do
			if v2:IsProp() and IsValid(v2:FMOwner()) and v2:FMOwner():SameTeam(v) then
				local p = v
				local id = p:UserID()

				playerpropdata[id] = playerpropdata[id] or {}
				table.insert(playerpropdata[id], v2:GetFMHealth())

				if not GAMEMODE:IsPhase(TIME_BUILD) then continue end

				playerpropdata_maxhp[id] = playerpropdata_maxhp[id] or {}

				local mdl = v2:GetModel()
				if mdl == "models/error.mdl" then
					mdl = v2:GetSaveTable().model
				end
				mdl = mdl or "models/error.mdl"

				if not SpawnableProps[mdl] then
					if mdl == "models/error.mdl" then continue end

					printWarn("SpawnableProps[%q] is nil!", mdl)
					continue
				end

				table.insert(playerpropdata_maxhp[id], SpawnableProps[mdl].health)
			end
		end
	end
end)

--Player level
net.Receive("FMSendPlayerLevel", function()
	local ply = net.ReadEntity()
	local lvl = net.ReadUInt(10)

	if not IsValid(ply) then return end

	ply.plvl = lvl
end)

local barbg = Material("icon32/sb_bar_bg.png", "smooth")
local barfg = Material("icon32/sb_bar_fg.png", "smooth")

local drawdebug = false

local PLAYER_LINE =
{
	Init = function(self)
		self:SetCursor("hand")
		self:SetTooltip("Click to open Player Info")

		self.Rank = self:Add("DLabel")
		self.Rank:Dock(LEFT)
		self.Rank:DockMargin(0, 1, 3, 0)
		self.Rank:DockPadding(0, 0, 0, 1)
		self.Rank:SetWidth(rankw)
		self.Rank:SetFont("ScoreboardDefault")
		self.Rank:SetContentAlignment(5)

		self.AvatarButton = self:Add("DButton")
		self.AvatarButton:DockMargin(0, 0, 0, 0)
		self.AvatarButton:SetWide(20)
		self.AvatarButton:Dock(LEFT)
		self.AvatarButton.OnMousePressed = function(_, mc) self:OnMousePressed(mc) end -- Redirects mousepresses to the parent

		self.Avatar = vgui.Create("AvatarImage", self.AvatarButton)
		self.Avatar:SetSize(20, 20)
		self.Avatar:SetMouseInputEnabled(false)
		self.Avatar.UpdateAvatar = function(av)
			if self.Player.customname then
				av:SetSteamID(self.Player.fakesteamid, 16)
			else
				av:SetPlayer(self.Player)
			end
		end

		self.Plvl = self:Add("DLabel")
		self.Plvl:Dock(LEFT)
		self.Plvl:DockMargin(0, 1, 8, 0)
		self.Plvl:SetWidth(lvlw)
		self.Plvl:SetFont("ScoreboardDefault")
		self.Plvl:SetTextColor(FMCOLORS.txt)
		self.Plvl:SetContentAlignment(5)
		self.Plvl.Paint = function(_, w, h)
			if drawdebug then
				DrawPanel(0, 0, w, h, Color(0, 150, 150, 255))
			end
		end

		self.InfractionWarningButton = self:Add("DButton")
		self.InfractionWarningButton:Dock(LEFT)
		self.InfractionWarningButton:DockMargin(0, 1, 0, 0)
		self.InfractionWarningButton:SetWide(20)
		self.InfractionWarningButton.Paint = function() end
		self.InfractionWarningButton:SetText("")

		self.InfractionWarningButton.DoClick = function()
			local sid = self.Player.customname and self.Player.fakesteamid or self.Player:SteamID64()
			local url = "https://devinity.org/pages/infractions/?steamid=" .. sid
			gui.OpenURL(url)
		end

		self.InfractionWarning = self.InfractionWarningButton:Add("DLabel")
		self.InfractionWarning:SetSize(20,20)
		self.InfractionWarning:SetFont("FMFontAwesome")
		self.InfractionWarning:SetText(utf8.char(0xf06a))
		self.InfractionWarning.Paint = function(_, w, h)
			if drawdebug then
				DrawPanel(0, 0, w, h, Color(150, 0, 150, 255))
			end
		end

		self.Name = self:Add("DLabel")
		self.Name:Dock(FILL)
		self.Name:DockMargin(0, 1, 0, 0)
		self.Name:SetFont("ScoreboardDefault")
		self.Name:SetTextColor(FMCOLORS.txt)
		self.Name.Paint = function(_, w, h)
			if drawdebug then
				DrawPanel(0, 0, w, h, Color(150, 0, 0, 255))
			end
		end

		self.Mute = self:Add("DImageButton")
		self.Mute:SetWide(16)
		self.Mute:DockMargin(0, 2, 0, 2)
		self.Mute:Dock(RIGHT)

		self.Ping = self:Add("DLabel")
		self.Ping:Dock(RIGHT)
		self.Ping:DockMargin(0, 1, 0, 0)
		self.Ping:SetWidth(pingw)
		self.Ping:SetFont("ScoreboardDefault")
		self.Ping:SetTextColor(FMCOLORS.txt)
		self.Ping:SetContentAlignment(5)
		self.Ping.Paint = function(_, w, h)
			if drawdebug then
				DrawPanel(0, 0, w, h, Color(0, 0, 150, 255))
			end
		end

		self.Deaths = self:Add("DLabel")
		self.Deaths:Dock(RIGHT)
		self.Deaths:DockMargin(0, 1, 0, 0)
		self.Deaths:SetWidth(deathw)
		self.Deaths:SetFont("ScoreboardDefault")
		self.Deaths:SetTextColor(FMCOLORS.txt)
		self.Deaths:SetContentAlignment(5)
		self.Deaths.Paint = function(_, w, h)
			if drawdebug then
				DrawPanel(0, 0, w, h, Color(150, 0, 150, 255))
			end
		end

		self.Cash = self:Add("DLabel")
		self.Cash:Dock(RIGHT)
		self.Cash:DockMargin(0, 1, 0, 0)
		self.Cash:SetWidth(cashw)
		self.Cash:SetFont("ScoreboardDefault")
		self.Cash:SetTextColor(FMCOLORS.txt)
		self.Cash:SetContentAlignment(5)
		self.Cash.Paint = function(_, w, h)
			if drawdebug then
				DrawPanel(0, 0, w, h, Color(150, 150, 0, 255))
			end
		end

		self.Dmg = self:Add("DLabel")
		self.Dmg:Dock(RIGHT)
		self.Dmg:DockMargin(0, 1, 0, 0)
		self.Dmg:SetWidth(damagew)
		self.Dmg:SetFont("ScoreboardDefault")
		self.Dmg:SetTextColor(FMCOLORS.txt)
		self.Dmg:SetContentAlignment(5)
		self.Dmg.Paint = function(_, w, h)
			if drawdebug then
				DrawPanel(0, 0, w, h, Color(0, 150, 150, 255))
			end
		end

		self.PropBar = self:Add("DPanel")
		self.PropBar:Dock(RIGHT)
		self.PropBar:DockMargin(0, 1, 0, 0)
		self.PropBar:SetWidth(propbarw)
		self.PropBar.propcnt = 0
		self.PropBar.perc = 0
		self.PropBar.Paint = function(propbar, w, h)
			--BG Color
			surface.SetDrawColor(Color(70, 70, 70))
			surface.SetMaterial(barbg)
			surface.DrawTexturedRect(5, 1, 128, 16)

			local x, y = propbar:LocalToScreen(0, 1)
			local pw = w * propbar.perc

			--Actual bar
			render.SetScissorRect(x, y, x + pw, y + h, true)
				surface.SetDrawColor(FMCOLORS.txt)
				surface.DrawTexturedRect(5, 1, 128, 16)
			render.SetScissorRect(0, 0, 0, 0, false)

			--This will add a itty bitty shaded line to prevent a sharp cutoff
			render.SetScissorRect(x + pw, y, x + pw + 1, y + h, true)
				local lowalpha = table.Copy(FMCOLORS.txt)
				lowalpha.a = 150
				surface.SetDrawColor(lowalpha)
				surface.DrawTexturedRect(5, 1, 128, 16)
			render.SetScissorRect(0, 0, 0, 0, false)

			local txt = string.format("Props: %i", propbar.propcnt)
			surface.SetFont("FMRegular16")
			local tw, th = surface.GetTextSize(txt)

			surface.SetTextPos(w / 2 - tw / 2, h / 2 - th / 2)
			surface.SetTextColor(Color(120, 120, 120))
			surface.DrawText(txt)

			--Innershadow
			surface.SetDrawColor(Color(0, 0, 0))
			surface.SetMaterial(barfg)
			surface.DrawTexturedRect(5, 0, 128, 16)
		end

		self.Team = self:Add("DLabel")
		self.Team:Dock(RIGHT)
		self.Team:DockMargin(0, 1, 0, 0)
		self.Team:SetWidth(teamw)
		self.Team:SetText("")
		self.Team:SetFont("ScoreboardDefault")

		-- Override to prevent teamnames being invisible
		local old = self.Team.SetTextColor
		self.Team.SetTextColor = function(teamlbl, col)
			col.a = 255
			old(teamlbl, col)
		end

		self.Team.Paint = function(_, w, h)
			if drawdebug then
				DrawPanel(0, 0, w, h, Color(0, 150, 0, 255))
			end
		end

		self:Dock(TOP)
		self:DockPadding(0, 3, 3, 3)
		self:SetHeight(20 + 3 * 2)
		self:DockMargin(2 + 128 + 10, 0, 2, 2)
	end,

	Setup = function(self, pl)
		self.Player = pl

		self.LastHiddenName = pl.customname
		self.Avatar:UpdateAvatar()

		self:Think(self)
	end,

	Think = function(self)
		if not IsValid(self.Player) then
			local parent = self:GetParent()
			self:Remove()
			parent:InvalidateLayout()
			return
		end

		--Avatar
		if self.Player.customname != self.LastHiddenName then
			self.LastHiddenName = self.Player.customname
			self.Avatar:UpdateAvatar()
		end

		--Rank
		if not self.NumRank or self.NumRank != self.Player:GetMODTier() then
			self.NumRank = self.Player:GetMODTier()

			local txt = ""
			if self.NumRank > 0 then
				txt = " " .. GetTierName(self.NumRank) .. " "
			end

			self.Rank:SetText(txt)
			self.Rank:SizeToContents()
			self.Rank:DockMargin(rankw - self.Rank:GetWide(), 1, 3, 0)
		end

		if not self.PlayerLevel or self.PlayerLevel != self.Player:GetPlayerLevel() then
			self.PlayerLevel = self.Player:GetPlayerLevel()

			local lvl = self.PlayerLevel
			self.Plvl:SetText(lvl)
		end

		--Name
		if (self.StrName == nil or self.StrName != self.Player:FilteredNick()) then
			self.StrName = self.Player:FilteredNick()
			self.Name:SetText(self.StrName)
		end

		if self.InfractionWarningLevel == nil or self.InfractionWarningLevel != self.Player:GetNWInt("InfractionWarningLevel", 0) then
			local warnlvl = self.Player:GetNWInt("InfractionWarningLevel", 0)

			self.InfractionWarningLevel = warnlvl
			self.InfractionWarning:SetTextColor(warnlvl == 1 and Color(204, 180, 75) or Color(204, 75, 75))
			self.InfractionWarningButton:SetWide(warnlvl > 0 and 20 or 0)
			self.InfractionWarningButton:SetTooltip(warnlvl == 1 and "Player has received one or more infractions in the last three months" or "Player has received multiple infractions in the last three months")
		end

		--Team
		if self.Player:CTeam() then
			local tm = self.Player:CTeam()

			self.Team:SetText(tm:GetName())

			if self.Player:IsLeader() then
				local h, s, v = ColorToHSV(tm:GetColor())
				self.Team:SetTextColor(HSVToColor(h, s, v - (math.sin(CurTime() * 4) + 1) * 0.1))
			else
				self.Team:SetTextColor(tm:GetColor())
			end
		else
			self.Team:SetText("")
		end

		--Damage
		if (not self.Player.GetDamageDone or self.NumDmg == nil or self.NumDmg != self.Player:GetDamageDone()) then
			self.NumDmg = self.Player.GetDamageDone and self.Player:GetDamageDone() or 0
			self.Dmg:SetText(self.NumDmg)
		end

		--Cash
		if (not self.Player.GetCash or self.NumCash == nil or self.NumCash != self.Player:GetCash()) then
			self.NumCash = self.Player.GetCash and self.Player:GetCash() or 0
			self.Cash:SetText(FormatMoney(self.NumCash))
		end

		--Deaths
		if (self.NumDeaths == nil or self.NumDeaths != self.Player:Deaths()) then
			self.NumDeaths = self.Player:Deaths()
			self.Deaths:SetText(self.NumDeaths)
		end

		--Ping
		if (self.NumPing == nil or self.NumPing != self.Player:Ping()) then
			self.NumPing = self.Player:Ping()
			self.Ping:SetText(self.NumPing)
		end

		if playerpropdata_maxhp then
			runtimer = true

			local id = self.Player:UserID()
			local props = playerpropdata[id] or {}
			local props_maxhp = playerpropdata_maxhp[id] or {}

			local curhp = SumTable(props)
			local maxhp = SumTable(props_maxhp)

			self.PropBar.propcnt = #props
			self.PropBar.perc = curhp / maxhp

			self.PropBar:SetTooltip(string.format("Props: %i\nHP: %i/%i", #props, curhp, maxhp))
		end

		if (self.Muted == nil or self.Muted != self.Player:IsMuted()) then

			self.Muted = self.Player:IsMuted()
			if (self.Muted) then
				self.Mute:SetImage("icon32/muted.png")
			else
				self.Mute:SetImage("icon32/unmuted.png")
			end

			self.Mute.DoClick = function() self.Player:SetMuted(not self.Muted) end

		end
	end,

	Paint = function(self, w, h)
		if not IsValid(self.Player) then
			local parent = self:GetParent()
			self:Remove()
			parent:InvalidateLayout()
			return
		end

		local RankTxtWidth = self.Rank:GetWide() + 2
		local RankWidth = rankw - RankTxtWidth

		if self.Player:GetMODTier() > 0 then
			DrawPanel(RankWidth, 0, RankTxtWidth + 5, h, GetTierColor(self.NumRank))
		end

		if not self.Player:Alive() then
			DrawPanel(rankw, 0, w-rankw, h, Color(40, 0, 0, 255))
			return
		end

		DrawPanel(rankw, 0, w-rankw, h, FMCOLORS.bg)
	end,
	OnMousePressed = function(self, mousecode)
		if mousecode == 107 then

			OpenPlayerInfo(self.Player)
			hook.Call("ScoreboardHide", GAMEMODE)

		elseif mousecode == 108 then

			local options = DermaMenu()
			options:AddOption("Copy Name", function() SetClipboardText(self.Player:Nick()) end):SetImage("icon16/user_edit.png")
			options:AddOption("Copy SteamID", function() SetClipboardText(self.Player:FMSteamID()) end):SetImage("icon16/tag_blue.png")
			options:AddOption("Community Profile", function() gui.OpenURL("http://steamcommunity.com/profiles/" .. self.Player:FMSteamID64()) end):SetImage("icon32/icon_steam.png")
			options:AddOption("Infractions", function() gui.OpenURL(string.format("https://devinity.org/pages/infractions/?steamid=%s", self.Player:FMSteamID())) end):SetImage("icon16/shield.png")

			if self.Player == LocalPlayer() then
				options:Open()
				return
			end

			options:AddOption("Request Ban", function() DoChatCmd("!requestban", self.Player:UserID()) end):SetImage("icon16/delete.png")

			local spacer = options:AddSpacer()
			spacer:SetTall(0)

			if LocalPlayer():GetMODTier() >= RANK_JUNIOR and IsValid(self.Player:CTeam()) then
				spacer:SetTall(1)

				local id = self.Player:CTeam():GetID()
				options:AddOption("Team ID: " .. id, function() SetClipboardText(tostring(id)) Hint("Team id copied") end):SetImage("icon16/information.png")
			end

			--Team functions
			if LocalPlayer():SameTeam(self.Player) then
				if GAMEMODE:IsPhase(TIME_BUILD) then
					spacer:SetTall(1)
					options:AddOption("Team goto", function() DoChatCmd("!teamgoto", self.Player:UserID()) end):SetImage("icon16/arrow_out.png")
				end

				if LocalPlayer():IsLeader() then
					if GAMEMODE:IsPhase(TIME_BUILD) then
						spacer:SetTall(1)
						options:AddOption("Team bring", function() DoChatCmd("!teambring", self.Player:UserID()) end):SetImage("icon16/arrow_in.png")
					end
					spacer:SetTall(1)
					options:AddOption("Team kick", function() DoChatCmd("!teamkick", self.Player:UserID()) end):SetImage("icon16/door_out.png")
				end
			elseif LocalPlayer().isleader then
				spacer:SetTall(1)
				options:AddOption("Invite to Team", function() DoChatCmd("!teaminvite", self.Player:UserID()) end):SetImage("icon16/user_add.png")
			elseif IsValid(self.Player:CTeam()) and (self.Player:CTeam():IsPublic() or self.Player:CTeam():HasInvite(LocalPlayer())) then
				spacer:SetTall(1)
				options:AddOption("Join Team", function() DoChatCmd("!teamjoin", self.Player:CTeam():GetName()) end):SetImage("icon16/door_in.png")
			end

			spacer = options:AddSpacer()
			spacer:SetTall(0)

			--Admin functions
			if LocalPlayer():GetMODTier(true) >= RANK_JUNIOR and (LocalPlayer():GetMODTier(true) >= RANK_SUPERADMIN or LocalPlayer():GetMODTier(true) > self.Player:GetMODTier()) then
				CreateAdminMenu(self, options, spacer)
			end

			options:Open()

		end
	end,
}

PLAYER_LINE = vgui.RegisterTable(PLAYER_LINE, "DPanel");

surface.SetFont("ScoreboardDefaultTitle")
local lvltxtw = surface.GetTextSize("Level") / 2
local dmgtxtw = surface.GetTextSize("Damage") / 2
local cashtxtw = surface.GetTextSize("Cash") / 2
local deathstxtw = surface.GetTextSize("Deaths") / 2
local pingtxtw = surface.GetTextSize("Ping") / 2
local propstxtw = surface.GetTextSize("Prop Stats") / 2
local SCORE_BOARD =
{
	Init = function(self)
		self.CatInfo = self:Add("DPanel")
			self.CatInfo:Dock(TOP)
			self.CatInfo:SetTall(20)
			self.CatInfo.Paint = function()
				local locx = 2 + 128 + 10 + rankw + 3 + 20
				surface.SetFont("ScoreboardDefaultTitle")
				surface.SetTextColor(FMCOLORS.bg)

				surface.SetTextPos(locx + (lvlw / 2 - lvltxtw), 0)
				surface.DrawText("Level")

				locx = locx + lvlw + 8
				surface.SetTextPos(locx, 0)
				surface.DrawText("Name")

				locx = locx + (namew - 6)
				surface.SetTextPos(locx, 0)
				surface.DrawText("Team")

				locx = locx + teamw
				surface.SetTextPos(locx + (propbarw / 2 - propstxtw), 0)
				surface.DrawText("Prop Stats")

				locx = locx + propbarw
				surface.SetTextPos(locx + (damagew / 2 - dmgtxtw), 0)
				surface.DrawText("Damage")

				locx = locx + damagew
				surface.SetTextPos(locx + (cashw / 2 - cashtxtw), 0)
				surface.DrawText("Cash")

				locx = locx + cashw
				surface.SetTextPos(locx + (deathw / 2 - deathstxtw), 0)
				surface.DrawText("Deaths")

				locx = locx + deathw
				surface.SetTextPos(locx + (pingw / 2 - pingtxtw), 0)
				surface.DrawText("Ping")
			end

		self.Scores = self:Add("DScrollPanel")
			self.Scores:Dock(FILL)

	end,

	PerformLayout = function(self)

		self:SetSize(rowwidth + 128, ScrH() - 200)
		self:SetPos(ScrW() / 2 - rowwidth / 2 - 128, 100)

	end,

	Paint = function(self, w, h)

		surface.SetMaterial(Material("icon32/logo_vertical2.png"))
		surface.SetDrawColor(FMCOLORS.txt)
		surface.DrawTexturedRect(0, 0, 128, 512)

		DisableClipping(true)
		draw.SimpleText(GetHostName(), "FMRegular40", 128 + rankw, -50, FMCOLORS.bg)
		DisableClipping(false)

	end,

	SortFunction = function(self, ply1, ply2)
		-- Push dead players down
		if ply1:Alive() != ply2:Alive() then
			return ply1:Alive()
		end

		-- Push staff up (but not VIP)
		local ply1rank = math.max(ply1:GetMODTier() - RANK_PLATINUM, 0)
		local ply2rank = math.max(ply2:GetMODTier() - RANK_PLATINUM, 0)

		if ply1rank != ply2rank then
			return ply1rank > ply2rank
		end

		-- Push players who are not in teams down
		if ply1:CTeam() and not ply2:CTeam() then return true end
		if ply2:CTeam() and not ply1:CTeam() then return false end

		if ply1:CTeam() and ply2:CTeam() then
			if ply1:CTeam() != ply2:CTeam() then
				-- Sort teams alphabetically
				return ply1:CTeam():GetName():lower() < ply2:CTeam():GetName():lower()
			else
				-- Move leaders up
				if ply1:IsLeader() != ply2:IsLeader() then return ply1:IsLeader() end
			end
		end

		-- Lastly sort alphabetically
		return ply1:Nick():lower() < ply2:Nick():lower()
	end,

	Sort = function(self)
		local pnls = {}
		for _, v in pairs(self.Scores:GetCanvas():GetChildren()) do
			table.insert(pnls, v)
		end

		table.sort(pnls, function(a,b)
			local ply1 = a.Player
			local ply2 = b.Player

			if not IsValid(ply1) then return false end
			if not IsValid(ply2) then return true end

			return self:SortFunction(ply1, ply2)
		end)

		for k, v in pairs(pnls) do
			v:SetZPos(k + 50)
		end
	end,

	Think = function(self)
		local plyrs = player.GetAll()
		for _, pl in pairs(plyrs) do

			if (IsValid(pl.ScoreEntry)) then continue end

			pl.ScoreEntry = vgui.CreateFromTable(PLAYER_LINE, pl.ScoreEntry)
			pl.ScoreEntry:Setup(pl)

			self.Scores:AddItem(pl.ScoreEntry)

		end

		self:Sort()
	end,
}

SCORE_BOARD = vgui.RegisterTable(SCORE_BOARD, "EditablePanel");

--[[---------------------------------------------------------
   Name: gamemode:ScoreboardShow()
   Desc: Sets the scoreboard to visible
-----------------------------------------------------------]]
function GM:ScoreboardShow()

	if not IsValid(g_Scoreboard) then
		g_Scoreboard = vgui.CreateFromTable(SCORE_BOARD)
	end

	if IsValid(g_Scoreboard) then
		g_Scoreboard:Show()
		g_Scoreboard:MakePopup()
		g_Scoreboard:SetKeyboardInputEnabled(false)
	end

end

--[[---------------------------------------------------------
   Name: gamemode:ScoreboardHide()
   Desc: Hides the scoreboard
-----------------------------------------------------------]]
function GM:ScoreboardHide()
	CloseDermaMenus()

	if IsValid(g_Scoreboard) then
		g_Scoreboard:Hide()
	end

end

concommand.Add("fm_reloadscoreboard", function()
	if IsValid(g_Scoreboard) then
		g_Scoreboard:Remove()
	end
end)


--[[---------------------------------------------------------
   Name: gamemode:HUDDrawScoreBoard()
   Desc: If you prefer to draw your scoreboard the stupid way (without vgui)
-----------------------------------------------------------]]
function GM:HUDDrawScoreBoard()
end
