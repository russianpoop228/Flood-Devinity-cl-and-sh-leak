
-- FMEscapeMenuPlayerBox
-- MenuBox containing the player information

local avatarSize = 80
local color_text = Color(220, 220, 220)

local font_regular = "FMEscapeMenuRegular"
local font_smaller = "FMEscapeMenuSmaller"
local font_small = "FMEscapeMenuSmall"
local font_mini = "FMEscapeMenuMini"
local font_mini_i = "FMEscapeMenuMiniItalic"

local PANEL = {}
function PANEL:Init()
	self:SetText("")

	self.infopanels = {}
end

function PANEL:HideAll()
	for _, pnl in pairs(self.infopanels) do
		pnl:SetVisible(false)
	end
end

--[[
Commands
]]
local cmdlookup
local function makeCmdLookup()
	cmdlookup = {}
	for k,v in pairs(GetAdminCmds()) do
		table.insert(cmdlookup, {cmd = k, rank = v.rank, desc = v.desc, args = v.args})
	end

	table.sort(cmdlookup, function(a,b)
		if a.rank != b.rank then
			return a.rank < b.rank
		end

		return a.cmd < b.cmd
	end)
end

local function DrawPanel( x,y,w,h,col )
	derma.GetDefaultSkin().tex.Panels.Bright( x,y,w,h, col )
end

local argtostr = {
	[CMDARG_PLAYER]    = "Player",
	[CMDARG_PLAYERS]   = "Player(s)",
	[CMDARG_STEAMID]   = "SteamID",
	[CMDARG_NUMBER]    = "Number",
	[CMDARG_EOLSTRING] = "Text",
	[CMDARG_STRING]    = "Text",
}
local function ArgTypeToStr( argtype )
	return argtostr[argtype]
end

local commandsDirty = true
function PANEL:OpenCommands()
	self:SetVisible(true)
	self:HideAll()
	self:SetText("Commands")

	if not IsValid(self.infopanels["commands"]) or commandsDirty then
		if IsValid(self.infopanels["commands"]) then
			self.infopanels["commands"]:Remove()
		end

		local scroll = vgui.Create("DScrollPanel", self)
			scroll:DockMargin(10, 10, 10, 10)
			scroll:Dock(FILL)

		local li = vgui.Create("DListLayout", scroll)
			li:Dock(FILL)

		makeCmdLookup()

		local prevrank = 0
		for _, v in ipairs(cmdlookup) do
			if v.rank != prevrank then
				local lblrank = vgui.Create("DLabel")
					lblrank:SetFont("FMRegular26")
					lblrank:SetText(GetTierName(v.rank, true))
					lblrank:SetTextColor(GetTierColor(v.rank))
					lblrank:DockMargin(0, 0, 0, 10)
					lblrank:SizeToContentsX()
				li:Add(lblrank)

				prevrank = v.rank
			end

			local p = vgui.Create("DPanel")
				p:DockMargin(0, 0, 0, 5)
				p:DockPadding(5, 5, 5, 5)

			local argstall = 0
			if #v.args > 0 then
				local argspnl = vgui.Create("Panel", p)
					argspnl:Dock(RIGHT)
					argspnl:DockMargin(5, 0, 0, 0)

				local lblargs = vgui.Create("DLabel", argspnl)
					lblargs:Dock(TOP)
					lblargs:DockMargin(0, 0, 0, 3)
					lblargs:SetFont("FMRegular16")
					lblargs:SetText("Arguments:")
					lblargs:SizeToContents()

				local argslist = vgui.Create("DListLayout", argspnl)
					argslist:Dock(TOP)

				for k2,v2 in pairs(v.args) do
					local ap = vgui.Create("DPanel")
						ap.Paint = function(_, w, h)
							DrawPanel(0, 0, w, h, Color(255,234,123))
						end
						ap:DockMargin(0, 0, 0, 2)
						ap:DockPadding(2, 2, 2, 2)

					local s1 = string.format("<%s>", ArgTypeToStr(v2.typ))
					if v2.optional then
						s1 = string.format("[%s]", s1)
					end
					s1 = string.format("##%i %s", k2, s1)
					local lbl1 = vgui.Create("DLabel", ap)
						lbl1:Dock(TOP)
						lbl1:SetFont("FMRegular16")
						lbl1:SetTextColor(FMCOLORS.bg)
						lbl1:SetText(s1)
						lbl1:SizeToContents()

					local lbl2 = vgui.Create("DLabelWordWrap2", ap)
						lbl2:Dock(TOP)
						lbl2:SetFont("FMRegular16")
						lbl2:SetTextColor(FMCOLORS.bg)
						lbl2:SetText(v2.desc)
						lbl2:SizeToContents()

					ap.PerformLayout = function(_, w, h)
						local calctall = 2 + lbl1:GetTall() + lbl2:GetTall() + 2
						if h != calctall then
							ap:SetTall(calctall)
						end
					end

					argslist:Add(ap)
				end

				p.argspnl = argspnl

				argstall = #v.args * (16 * 2 + 4 + 2) + 3 - 12
			end

			local lblcmd = vgui.Create("DLabel", p)
				lblcmd:Dock(TOP)
				lblcmd:DockMargin(0, 0, 0, 5)
				lblcmd:SetFont("FMRegular22")
				lblcmd:SetText("!" .. v.cmd:sub(3))
				lblcmd:SetTextColor(FMCOLORS.txt)
				lblcmd:SizeToContentsY()

			local lbldesc = vgui.Create("DLabelWordWrap2", p)
				lbldesc:Dock(TOP)
				lbldesc:DockMargin(0, 0, 0, 5)
				lbldesc:SetFont("FMRegular16")
				lbldesc:SetText(v.desc)
				lbldesc:SizeToContentsY()

			p.PerformLayout = function(_, w, h)
				if p.argspnl then
					p.argspnl:SetWide(w * 2 / 5)
				end

				local calctall = 5 + lblcmd:GetTall() + 5 + math.max(argstall, lbldesc:GetTall()) + 5
				if h != calctall then
					p:SetTall(calctall)
				end
			end

			li:Add(p)
		end

		commandsDirty = false
		self.infopanels["commands"] = scroll
	end

	self.infopanels["commands"]:SetVisible(true)
end

hook.Add("FMCommandsReceived", "FMEscapeMenuCommands", function()
	commandsDirty = true
end)

--[[
Rules
]]
function PANEL:OpenRules()
	self:SetVisible(true)
	self:HideAll()
	self:SetText("Rules")

	if not IsValid(self.infopanels["rules"]) then
		local pnl = vgui.Create("HTML", self)
			pnl:Dock(FILL)
			pnl:OpenURL("https://devinity.org/flood/rules.php")
			pnl:DockMargin(10, 10, 10, 10)
			pnl.OnFocusChanged = function(_, gained)
				if gained then
					self:GetParent():ReclaimFocus() -- Give back focus to the escape menu so escape key still works
				end
			end

		self.infopanels["rules"] = pnl
	end

	self.infopanels["rules"]:SetVisible(true)
end

--[[
Help
]]
local slides = {
	"icon32/tutorial/tut1.png",
	"icon32/tutorial/tut2.png",
	"icon32/tutorial/tut3.png",
	"icon32/tutorial/tut4.png",
	"icon32/tutorial/tut5.png",
	"icon32/tutorial/tut6.png",
	"icon32/tutorial/tut7.png",
	"icon32/tutorial/tut8.png",
	"icon32/tutorial/tut9.png",
}
for k,v in pairs(slides) do slides[k] = Material(v, "smooth") end
function PANEL:OpenHelp()
	self:SetVisible(true)
	self:HideAll()
	self:SetText("Help")

	if not IsValid(self.infopanels["help"]) then
		local pnl = vgui.Create("Panel", self)
			pnl:Dock(FILL)
			pnl:DockMargin(10, 10, 10, 10)
			pnl.curslide = 1
			pnl.maxslide = #slides

		local imgcont = vgui.Create("Panel", pnl)
			imgcont:Dock(FILL)

		local img = vgui.Create("DImage", imgcont)
			img.PaintOver = function(_, w, h)
				draw.SimpleText(("%i/%i"):format(pnl.curslide, pnl.maxslide), font_small, 4, 2, color_text)
			end

		imgcont.PerformLayout = function(_, w, h)
			local size = math.min(w, h)
			img:SetSize(size, size)
			img:SetPos(w / 2 - size / 2, h / 2 - size / 2)
		end

		local buttonrow = vgui.Create("Panel", pnl)
			buttonrow:Dock(BOTTOM)
			buttonrow:DockMargin(0, 5, 0, 0)
			buttonrow:SetTall(ScrH() / 26)

		local left = vgui.Create("DButton", buttonrow)
			left:Dock(LEFT)
			left:DockMargin(0, 0, 2, 0)
			left:SetFont(font_small)
			left:SetText("< Previous Page")
			left.DoClick = function() pnl:ChangeSlide(-1) end

		local right = vgui.Create("DButton", buttonrow)
			right:Dock(RIGHT)
			right:DockMargin(2, 0, 0, 0)
			right:SetFont(font_small)
			right:SetText("Next Page >")
			right.DoClick = function() pnl:ChangeSlide(1) end

		pnl.ChangeSlide = function(_, dir)
			pnl.curslide = math.Clamp(pnl.curslide + dir, 1, pnl.maxslide)
			img:SetMaterial(slides[pnl.curslide])

			left:SetDisabled(pnl.curslide == 1)
			right:SetDisabled(pnl.curslide == pnl.maxslide)
		end

		buttonrow.PerformLayout = function(_, w, h)
			left:SetWide(w / 2 - 2)
			right:SetWide(w / 2 - 2)
		end

		pnl:ChangeSlide(0)

		self.infopanels["help"] = pnl
	end

	self.infopanels["help"]:SetVisible(true)
end

--[[
Servers
]]
local serverlist
local function addServer(ip, port, iscur, info)
	if not IsValid(serverlist) then return end

	local ipport = ip .. ":" .. port
	for _, pnl in pairs(serverlist:GetChildren()) do
		if pnl.ipport == ipport then
			pnl:UpdateInfo(info)
			return
		end
	end

	local hostname = info.hostname
	hostname = hostname:gsub("Devinity.org", "")
	hostname = hostname:Trim()

	local pnl = vgui.Create("DPanel")
		pnl:DockPadding(8, 5, 5, 5)
		pnl:DockMargin(0, 0, 0, 5)
		pnl.ipport = ipport
		pnl.sortkey = hostname
		pnl.polygon = {}
		pnl.calcpolygon = function(self, w, h)
			self.polygon = {{},{},{}}
			self.polygon[1].x = w - 5
			self.polygon[1].y = h / 2
			self.polygon[2].x = w - 5 - 20
			self.polygon[2].y = h - 5
			self.polygon[3].x = w - 5 - 20
			self.polygon[3].y = 5
		end
		local oldpaint = pnl.Paint
		pnl.Paint = function(self, w, h)
			oldpaint(self, w, h)

			if not iscur then
				surface.SetDrawColor(FMCOLORS.txt)
				surface.SetTexture(0)
				surface.DrawPoly(self.polygon)
			end
		end

	local hdrlbl = vgui.Create("DLabel", pnl)
		hdrlbl:Dock(TOP)
		hdrlbl:SetZPos(10)
		hdrlbl:SetText(hostname)
		hdrlbl:SetTextColor(FMCOLORS.txt)
		hdrlbl:SetFont(font_small)
		hdrlbl:SizeToContentsY()

	local plycntlbl = vgui.Create("DLabel", pnl)
		plycntlbl:Dock(RIGHT)
		plycntlbl:DockMargin(0, 0, 30, 0)
		plycntlbl:SetTextColor(FMCOLORS.txt)
		plycntlbl:SetFont(font_regular)
		plycntlbl:SetContentAlignment(6)

	local footer = vgui.Create("Panel", pnl)
		footer:Dock(BOTTOM)
		footer:SetTall(ScrH() / 50)

	local iplbl = vgui.Create("DLabel", footer)
		iplbl:Dock(LEFT)
		iplbl:SetText(ipport)
		iplbl:SetContentAlignment(1)
		iplbl:SetTextColor(Color(100, 100, 100))
		iplbl:SetFont(font_mini)
		iplbl:SizeToContentsX()

	local phaselbl
	if info.time then
		phaselbl = vgui.Create("DLabel", footer)
			phaselbl:Dock(LEFT)
			phaselbl:DockMargin(10, 0, 0, 0)
			phaselbl:SetContentAlignment(1)
			phaselbl:SetTextColor(FMCOLORS.txt)
			phaselbl:SetFont(font_mini)
			phaselbl.UpdateTxt = function(this, inf)
				local phasetxt
				if inf.phase and inf.time then
					local phaseName = isstring(inf.phase) and inf.phase or PhaseToString(inf.phase):gsub("^%l", string.upper)
					phasetxt = string.format("%s %s", phaseName, string.FromSeconds(inf.time))
				else
					phasetxt = ""
				end
				phaselbl:SetText(phasetxt)
				phaselbl:SizeToContentsX()
			end
			timer.Create("serverlist" .. ipport, 1, 0, function()
				if IsValid(phaselbl) and phaselbl:IsVisible() then
					-- Hacky shit, tick up for game and reflect in BR else tick down
					local tickDir = isstring(info.phase) and (info.phase == "Game" or info.phase == "Reflect") and 1 or -1
					info.time = math.max(info.time + tickDir, 0)
					phaselbl:UpdateTxt(info)
				end
			end)
	end

	-- Invisible button covering the panel, used to capture clicks.
	local btn
	if not iscur then
		btn = vgui.Create("DButton", pnl)
			btn:SetText("")
			btn.DoClick = function()
				LocalPlayer():ConCommand(string.format("%s %s", "connect", ipport))
			end
			btn.Paint = function() end
	end

	pnl.UpdateInfo = function(this, inf)
		if inf.players and inf.maxplayers then
			plycntlbl:SetText(string.format("%i/%i", inf.players, inf.maxplayers))
		else
			plycntlbl:SetText("")
		end
		plycntlbl:SizeToContentsX()

		if phaselbl then
			phaselbl:UpdateTxt(inf)
		end
	end

	pnl.PerformLayout = function(_, w, h)
		if IsValid(btn) then
			btn:SetSize(w, h)
		end
		pnl:calcpolygon(w, h)

		local calctall = 5 + hdrlbl:GetTall() + footer:GetTall() + 5
		if h != calctall then
			pnl:SetTall(calctall)
		end
	end

	pnl:UpdateInfo(info)

	serverlist:Add(pnl)
	serverlist:SortChildren()
end

net.Receive("FMReturnServerInfo", function()
	local ip = net.ReadString()
	local port = net.ReadUInt(16)
	local iscur = net.ReadBool()
	local info = util.JSONToTable(net.ReadString())

	addServer(ip, port, iscur, info)
end)

function PANEL:OpenServers()
	self:SetVisible(true)
	self:HideAll()
	self:SetText("Servers")

	if not IsValid(self.infopanels["servers"]) or not IsValid(serverlist) then
		if IsValid(self.infopanels["servers"]) then
			self.infopanels["servers"]:Remove()
		end

		local scroll = vgui.Create("DScrollPanel", self)
			scroll:DockMargin(10, 10, 10, 10)
			scroll:Dock(FILL)

		serverlist = vgui.Create("DListLayout", scroll)
			serverlist:Dock(FILL)
			serverlist.SortChildren = function(this)
				local children = this:GetChildren()
				table.sort(children, function(a, b)
					if not a.sortkey then return false end
					if not b.sortkey then return true end

					return a.sortkey > b.sortkey
				end)
				for k,pnl in pairs(children) do
					pnl:SetZPos(1000 - k)
				end
			end
			serverlist.PerformLayout = function(this, w, h)
				DListLayout.PerformLayout(this, w, h)
				scroll:InvalidateLayout()
			end

		local toplbl = vgui.Create("DLabel")
			toplbl:DockMargin(0, 0, 0, 10)
			toplbl:SetFont(font_small)
			toplbl:SetText("Click on a server to connect to it")
			toplbl:SetContentAlignment(5)
			toplbl:SizeToContents()
		serverlist:Add(toplbl)

		self.infopanels["servers"] = scroll
	end

	self.infopanels["servers"]:SetVisible(true)
end

function PANEL:PerformLayout(w, h)
end

function PANEL:Think()
	if IsValid(serverlist) and serverlist:IsVisible() and not LocalPlayer():RateLimit("fetchserverlist", 5) then
		net.Start("FMRequestServerInfos") net.SendToServer()
	end
end
vgui.Register("FMEscapeMenuInfoBox", PANEL, "FMEscapeMenuBox")
