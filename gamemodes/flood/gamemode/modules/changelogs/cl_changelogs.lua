
GM.ChangeLogs = GM.ChangeLogs or {}
local changelogs = GM.ChangeLogs

local lastseenchangelogcvar = CreateClientConVar("fm_lastseenchangelog", "-1")
local changelognotice
function ShowNewChangelogNotice()
	if changelognotice != nil then
		return changelognotice
	end

	local latest = GetGlobalInt("LatestChangelog")

	if lastseenchangelogcvar:GetInt() == -1 then -- Not joined before
		lastseenchangelogcvar:SetInt(latest)
		changelognotice = false
		return false
	end

	if lastseenchangelogcvar:GetInt() < latest then
		lastseenchangelogcvar:SetInt(latest)
		changelognotice = true
	else
		changelognotice = false
	end

	return changelognotice
end

hook.Add("Initialize", "ChangelogNotice", function()
	timer.Simple(10, function()
		if ShowNewChangelogNotice() then
			Hint("There's been a new update since you last played!")
			Hint("Check Q-Menu -> Help/Rules tab!")
		end
	end)
end)

local rowtypetoid = {
	["add"]        = 1,
	["del"]        = 2,
	["tweak"]      = 3,
	["bugfix"]     = 4,
	["wip"]        = 5,
	["adminmod"]   = 6,
}
local function RowTypeToID(type)
	return rowtypetoid[type]
end
local rowtypetoicon = {
	["add"]        = "icon16/add.png",
	["del"]        = "icon16/delete.png",
	["tweak"]      = "icon16/wrench_orange.png",
	["bugfix"]     = "icon16/bug_delete.png",
	["wip"]        = "icon16/cog.png",
	["adminmod"]   = "icon16/server.png",
}
local function RowTypeToIcon(type)
	return rowtypetoicon[type]
end
local idtorowtype = {
	[1] = "add",
	[2] = "del",
	[3] = "tweak",
	[4] = "bugfix",
	[5] = "wip",
	[6] = "adminmod",
}
local function IDToRowType(type)
	return idtorowtype[type]
end

local listpnl
local function UpdateChangelogList()
	if not IsValid(listpnl) then return end

	for changelogid, t in pairs(changelogs) do
		if listpnl.changelogpnls[changelogid] then continue end

		local cont = vgui.Create("DPanel")
			cont.Paint = function() end
			cont:DockMargin(0, 0, 5, 10)
			cont.changelogid = changelogid
			cont:SetZPos(50 + changelogid) -- Orders the panels, lowest Z pos is at the top

		listpnl.changelogpnls[changelogid] = cont

		local datelbl = vgui.Create("DLabel", cont)
			datelbl:Dock(TOP)
			datelbl:SetText(os.date("%Y/%m/%d - %H:%M", t.date))
			datelbl:SetFont("FMRegular26")
			datelbl:SizeToContents()

		local box = vgui.Create("DPanel", cont)
			box:Dock(TOP)
			box:DockPadding(5, 5, 5, 5)

		local titlelbl = vgui.Create("DLabel", box)
			titlelbl:Dock(TOP)
			titlelbl:SetText(t.title)
			titlelbl:SetFont("FMRegular26")
			titlelbl:SizeToContents()
			titlelbl:SetTextColor(FMCOLORS.txt)

		if #t.subtitle > 0 then
			local subtitlelbl = vgui.Create("DLabel", box)
				subtitlelbl:Dock(TOP)
				subtitlelbl:SetText(t.subtitle)
				subtitlelbl:SetFont("FMRegular16")
				subtitlelbl:SizeToContents()
		end

		table.sort(t.rows, function(a, b)
			if a.author != b.author then
				return a.author < b.author
			end

			return RowTypeToID(a.type) < RowTypeToID(b.type)
		end)

		local prevauthor, rowcont
		for _, row in pairs(t.rows) do
			if not prevauthor or row.author != prevauthor then
				rowcont = vgui.Create("DPanel", box)
					rowcont:Dock(TOP)
					rowcont:DockMargin(0, 5, 0, 0)
					rowcont.Paint = function() end

				local authorlbl = vgui.Create("DLabel", rowcont)
					authorlbl:Dock(TOP)
					authorlbl:SetText(string.format("%s updated:", row.author))
					authorlbl:SetFont("FMRegular20")
					authorlbl:SizeToContents()

				prevauthor = row.author
			end

			local rowbox = vgui.Create("DPanel", rowcont)
				rowbox:Dock(TOP)
				rowbox:DockMargin(10, 2, 0, 0)
				rowbox.Paint = function(_, w, h)
					surface.SetDrawColor(Color(200,200,200))
					surface.DrawRect(0, 0, w, 1)
					surface.DrawRect(0, h - 1, w, 1)
					surface.DrawRect(w - 1, 0, 1, h)

					surface.SetDrawColor(Color(150,150,150))
					surface.DrawRect(0, 0, 3, h)
				end

			local rowicon = vgui.Create("DImage", rowbox)
				rowicon:SetImage(RowTypeToIcon(row.type))
				rowicon:SetSize(16, 16)

			local rowtxt = vgui.Create("DLabelWordWrap", rowbox)
				rowtxt:SetFont("FMRegular20")
				rowtxt:SetPos(3 + 4 + 16 + 4, 4)
				rowtxt:SetMaxWidth(500)
				rowtxt:SetText(row.text)
				rowtxt:SizeToContents()
				rowtxt:SetTextColor(Color(150,150,150))

			rowbox.PerformLayout = function(_, w, h)
				rowicon:SetPos(3 + 4, h / 2 - 8)

				rowtxt:SetSize(w - (3 + 4 + 16 + 4 + 4), h - 8)
				rowtxt:SetMaxWidth(rowtxt:GetWide())
				rowtxt:SetText(row.text) -- Updates wordwrap
				rowtxt:SizeToContents()

				rowbox:SetTall(rowtxt:GetTall() + 8)
				rowcont:SizeToChildren(false, true)
				box:SizeToChildren(false, true)
				cont:SizeToChildren(false, true)
			end

			rowbox:SetTall(rowtxt:GetTall() + 8)

			rowcont:InvalidateLayout(true)
			rowcont:SizeToChildren(false, true)
		end

		box:InvalidateLayout(true)
		box:SizeToChildren(false, true)

		cont:InvalidateLayout(true)
		cont:SizeToChildren(false, true)
		listpnl:Add(cont)
	end
end

local function RequestChangelogs(start)
	net.Start("FMRequestChangelogs")
		net.WriteUInt(start or 1, 8)
	net.SendToServer()
end

local function ReceiveChangelogs()
	while net.ReadBool() do
		local changelogid = net.ReadUInt(8)
		local t = {
			title = net.ReadString(),
			subtitle = net.ReadString(),
			date = net.ReadUInt(32),
			rows = {},
		}

		for i = 1, net.ReadUInt(8) do
			t.rows[i] = {
				id = net.ReadUInt(16),
				type = IDToRowType(net.ReadUInt(4)),
				text = net.ReadString(),
				author = net.ReadString(),
			}
		end

		changelogs[changelogid] = t
	end

	UpdateChangelogList()
end
net.Receive("FMReceiveChangelogs", ReceiveChangelogs)

function SetupChangeLogs()
	local basepnl = vgui.Create("DScrollPanel")

	listpnl = vgui.Create("DListLayout", basepnl)
		listpnl:Dock(FILL)
		listpnl.changelogpnls = {}

		listpnl.Think = function()
			if listpnl:IsVisible() then -- Delay request until we are actually interested
				changelognotice = false

				RequestChangelogs()
				listpnl.Think = nil
			end
		end

	--More logs button
	local morelogscont = vgui.Create("DPanel")
		morelogscont:SetZPos(5000)
		morelogscont:SetTall(40)
		morelogscont.Paint = function() end

	local morelogsbtn = vgui.Create("DButton", morelogscont)
		morelogsbtn:SetText("More")
		morelogsbtn.DoClick = function()
			local currentlogs = table.GetKeys(listpnl.changelogpnls)
			table.sort(currentlogs)
			local last = currentlogs[#currentlogs]

			RequestChangelogs(last + 1)
		end

	morelogscont.PerformLayout = function(_, w, h)
		morelogsbtn:SetSize(100, 30)
		morelogsbtn:SetPos(w / 2 - 50, 5)
	end

	listpnl:Add(morelogscont)

	return basepnl
end
