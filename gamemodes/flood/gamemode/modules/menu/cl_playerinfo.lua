
--[[
FMFrame
]]
PANEL = {}
function PANEL:Init()
	return true
end
function PANEL:SetTall(x, direct)
	if x == self:GetTall() then return end

	if direct then
		self:SetSize(self:GetWide(), x)
	else
		StartAnim(self:GetTall(), x, 1, function(tall)
			if not IsValid(self) then return end

			self:SetSize(self:GetWide(), tall)
		end)
	end
end
vgui.Register("FMFrame", PANEL, "DFrame")

local function PaintGenericBG(self, w, h)
	surface.SetDrawColor(FMCOLORS.bg)
	surface.DrawRect(0,0,w,h)
end

local function UnclippedPaint(self,w,h)
	DisableClipping(true)
	if self.paintbkp then self.paintbkp(self,w,h) end
	DisableClipping(false)
end

local function NiceTime(time)
	local days = math.floor(time / 86400)
	local hours = math.floor(time / 3600) % 24
	local minutes = math.floor(time / 60) % 60
	local seconds = time % 60

	if days > 0 then
		return string.format("%i day%s", days, days > 1 and "s" or "")
	elseif hours > 0 then
		return string.format("%i hour%s", hours, hours > 1 and "s" or "")
	elseif minutes > 0 then
		return string.format("%i minute%s", minutes, minutes > 1 and "s" or "")
	else
		return string.format("%i second%s", seconds, seconds > 1 and "s" or "")
	end
end

net.Receive("FMSendPlayerPlaytime", function()
	local ply = net.ReadEntity()
	local time = net.ReadUInt(32)
	ply.playtime = time
end)

local plypnls = {}
net.Receive("FMSendPlayerNationality", function()
	local ply = net.ReadEntity()
	local flagstr = net.ReadString()
	ply.flagstr = flagstr

	if not IsValid(ply) or not ply:UserID() then return end

	if plypnls[ply:UserID()] then
		plypnls[ply:UserID()].icon.flag:SetFlag(flagstr)
	end
end)

local function FillInfoPanel(ply, pnl)
	pnl:DockPadding(195, 5, 5, 5)

	local customdesclbl = vgui.Create("DLabel", pnl)
		customdesclbl:Dock(TOP)
		customdesclbl:SetFont("FMRegular20i")
		customdesclbl:SetDark(false)
		customdesclbl:SetTall(22)
		customdesclbl:DockMargin(0, 0, 0, 2)
		customdesclbl:SetVisible(false)

	local desc = vgui.Create("DLabel", pnl)
		desc:Dock(TOP)
		desc:SetFont("FMRegular20")
		desc:SetDark(false)

	local webicon = vgui.Create("DImageButton", pnl)
		webicon.DoClick = function()
			local sid = ply.customname and ply.fakesteamid or ply:SteamID64()
			local url = "http://steamcommunity.com/profiles/" .. sid
			gui.OpenURL( url )
		end
		webicon:SetIcon("icon32/icon_steam.png")
		webicon:SetSize(16,16)
		webicon:SetPos(pnl:GetWide() - 16, 82 - 16)

	pnl.Update = function()
		local customdesc = ply:GetCustomDescription()
		if customdesc and #customdesc > 0 then
			customdesclbl:SetText(customdesc)
			customdesclbl:SetVisible(true)
		else
			customdesclbl:SetVisible(false)
		end

		local infotbl = {
			string.format("Playtime: %s", NiceTime(ply:GetPlayTime(), true)),
			string.format("Registered: %s", os.date("%Y/%m/%d", ply:GetRegisteredDate())),
			string.format("Level: %s", ply:GetPlayerLevel()),
		}
		desc:SetText(table.concat(infotbl, "\n"))
		desc:SizeToContents()
	end

	pnl:Update()
end

local curpnl

PLAYERINFOWIDTH = 640
local w,h = ScrW(), ScrH()
local function InitiatePanel(ply)
	local frame = vgui.Create("FMFrame")
		frame:SetDeleteOnClose(false)
		frame:SetSize(PLAYERINFOWIDTH, 108)
		frame:SetPos(w / 2 - PLAYERINFOWIDTH / 2, 200)
		frame:SetMinHeight(200)
		frame:SetMinWidth(PLAYERINFOWIDTH)
		frame:SetSizable(true)
		frame.Paint = function(self, pnlw, pnlh)
			PaintGenericBG(self, pnlw, pnlh)

			surface.SetDrawColor(Color(150,150,150))
			draw.NoTexture()
			surface.DrawPoly({
				{x = pnlw - 5 - 2, y = pnlh - 2},
				{x = pnlw - 2, y = pnlh - 5 - 2},
				{x = pnlw - 2, y = pnlh - 2},
			})
		end
		frame.ply = ply
		frame:MakePopup()
		frame.btnMaxim:Remove()
		frame.btnMinim:Remove()
		frame.lblTitle:Remove()

	local icon
	local iconbg = vgui.Create("DPanel", frame)
		iconbg:SetSize(192,192)
		iconbg:SetPos(8, -84)
		iconbg:DockPadding(4,4,4,4)
		iconbg.paintbkp = PaintGenericBG
		iconbg.Paint = UnclippedPaint

		icon = vgui.Create("FMAvatar", iconbg)
			icon:Dock(FILL)
			icon:SetPlayer(ply)
			local iconOld = icon.Paint
			icon.Paint = function(self,iconw,iconh)
				DisableClipping(true)
				iconOld(self,iconw,iconh)
			end
			icon.PaintOver = function()
				DisableClipping(false)
			end

		local flag = vgui.Create("FMFlagIcon", icon)
			flag:SetPos(192-16-8-2,192-11-8-2) --bgsize-flagsize-margin-offset
			flag:SetFlag(ply.flagstr)
			flag:SetVisible(false)
			icon.OnFinishedLoading = function()
				flag:SetVisible(true)
			end

		icon.flag = flag
		frame.icon = icon

	frame.Open = function(self)
		self:SetVisible(true)
	end

	local name = vgui.Create("DLabel", frame)
		name:SetPos(200, 2)
		name:SetFont("FMRegular28")
		name:SetTextColor(FMCOLORS.txt)
		name.Update = function(self)
			self:SetText(ply:FilteredNick())
			self:SizeToContents()
		end
		name:Update()
		frame.namelbl = name

	local infopanel = vgui.Create("DPanel", frame)
		infopanel:SetSize(PLAYERINFOWIDTH-10,84)
		infopanel:SetPos(5,24)
		infopanel.Paint = function() end
		FillInfoPanel(ply, infopanel)
		frame.infopanel = infopanel

	frame:DockPadding(5,5 + 24 + 84,5,5)

	frame.panels = {}
	frame.AddItem = function(self, pnl, title)
		local lbl = vgui.Create("DLabel", self)
			lbl:SetFont("FMRegular24")
			lbl:SetText(title)
			lbl:SetTextColor(FMCOLORS.txt)
			lbl:SizeToContents()
			lbl:Dock(TOP)

		pnl:SetParent(self)
		pnl:Dock(TOP)

		table.insert(self.panels, pnl)
	end

	hook.Run("SetupPlayerInfo", ply, frame)

	frame.PerformLayout = function(self, pnlw, pnlh)
		self.btnClose:SetPos(pnlw - 31 - 4, 0)
		self.btnClose:SetSize(31, 31)

		infopanel:SetSize(pnlw - 10, 84)

		--Resize panels
		local usableheight = pnlh - (5 + 24 + 84) - 5
		local pnlam = #self.panels
		usableheight = usableheight - pnlam * 24 -- labels
		usableheight = usableheight / pnlam

		for k,v in pairs(self.panels) do
			v:SetTall(usableheight)
		end
	end
	frame:InvalidateLayout()

	frame:SetTall(h - 400)

	return frame
end
function OpenPlayerInfo(ply)
	if curpnl then ClosePlayerInfo() end

	if not IsValid(ply) then return end

	if plypnls[ply:UserID()] then
		curpnl = plypnls[ply:UserID()]
		curpnl:Open()

		curpnl.infopanel:Update()
		curpnl.namelbl:Update()
		for k,v in pairs(curpnl.panels) do
			if v.Update then v:Update(ply) end
		end
	else
		curpnl = InitiatePanel(ply)
		plypnls[ply:UserID()] = curpnl
	end
end
function ClosePlayerInfo()
	if curpnl then
		curpnl:Close()
		curpnl = nil
	end
end
