
--[[
Add Song Form
]]
local PANEL = {}
function PANEL:Init()
	self:SetTitle("Add a song to the song system")

	local txtentrytitle = vgui.Create("DTextEntry", self)
		txtentrytitle:Dock(TOP)
		txtentrytitle:DockMargin(0, 0, 0, 5)
		txtentrytitle:SetPlaceholderText("Title - Leave empty for automatic")

	local txtentryurl = vgui.Create("DTextEntry", self)
		txtentryurl:Dock(TOP)
		txtentryurl:DockMargin(0, 0, 0, 5)
		txtentryurl:SetPlaceholderText("Youtube URL")

	local statustxt = vgui.Create("DLabelCenter", self)
		statustxt:Dock(TOP)
		statustxt:DockMargin(0, 0, 0, 5)
		statustxt:SetText("")
		statustxt:SetTall(26)
		statustxt:SetFont("FMRegular24")
	self.statustxt = statustxt

	local btncontainer = vgui.Create("Panel", self)
		btncontainer:Dock(FILL)

	local btn = vgui.Create("DButton", btncontainer)
		btn:SetText("Add!")
		btn:SetEnabled(true)

		btn.resetf = function()
			txtentrytitle:SetText("")
			txtentryurl:SetText("")
			statustxt:SetText(" ")
			btn:SetText("Add!")
			btn:SetEnabled(true)
			btn.DoClick = btn.addf
		end

		btn.addf = function()
			self:SetStatus("Loading...", color_white)

			net.Start("FMAddSong")
				net.WriteString(txtentryurl:GetValue())
				net.WriteString(txtentrytitle:GetValue())
			net.SendToServer()

			btn:SetEnabled(false)
		end

		btn.DoClick = btn.addf
	self.btn = btn

	btncontainer.PerformLayout = function(_, w, h)
		local btnw = math.min(w - 10, h * 3)

		btn:SetSize(btnw, h)
		btn:SetPos(w / 2 - btnw / 2, 0)
	end

	self:SetMinimumSize(300, 140)
	self:SetSize(300, 140)
	self:SetSizable(true)
	self:Center()
	self:MakePopup()
end

function PANEL:SetStatus(txt, clr)
	self.statustxt:SetText(txt)
	self.statustxt:SetTextColor(clr)
end

function PANEL:SetSucceeded()
	self:SetStatus("Success!", Color(0, 200, 0))
	self.btn:SetEnabled(true)
	self.btn:SetText("Reset")
	self.btn.DoClick = self.btn.resetf
end

function PANEL:SetFailed(msg)
	self:SetStatus("Failed: " .. msg, Color(200, 0, 0))
	self.btn:SetEnabled(true)
end
vgui.Register("FMAddSongForm", PANEL, "DFrame")

local addsongform
local function OpenAddSongForm()
	if IsValid(addsongform) then addsongform:Remove() end

	addsongform = vgui.Create("FMAddSongForm")
end

net.Receive("FMAddSongReply", function()
	local success = net.ReadBool()
	local msg = net.ReadString()

	if not IsValid(addsongform) then return end

	if success then
		addsongform:SetSucceeded()
	else
		addsongform:SetFailed(msg)
		printError(msg)
	end
end)
--[[
Song list
]]
local function CanViewSongList()
	return true
end
local function CanPlaySong()
	return LocalPlayer():GetMODTier(true) >= RANK_PLATINUM
end
local function CanEditSong(song)
	local tier = LocalPlayer():GetMODTier(true)
	if tier >= RANK_ADMIN then return true end
	if tier >= RANK_MOD and (not song or song:GetUploaderSteamID() == LocalPlayer():SteamID()) then return true end
	return false
end
local function CanRemoveSong(song)
	return CanEditSong(song)
end
local function CanAddSong()
	return LocalPlayer():GetMODTier(true) >= RANK_SENIOR
end

local eventsbtnsettext = function(self)
	local song = self.song

	local events = {}
	if song.edit.ap_events then
		for k,_ in pairs(song.edit.ap_events) do
			table.insert(events, k)
		end
	end
	if #events == 0 then table.insert(events, "all") end

	table.sort(events, function(a,b)
		if a == "all" then return true end
		if b == "all" then return false end
		if a == "regular" then return true end
		if b == "regular" then return false end

		return a > b
	end)

	local txt = table.concat(events, ", ")
	self:SetText(txt)
end

local eventsbtndoclick = function(self)
	local song = self.song

	local men = DermaMenu()

	local opts = {}
	local function UpdateOpts()
		local all = (not song.edit.ap_events) or (table.Count(song.edit.ap_events) == 0)

		for _, v in pairs(opts) do
			local isagree = all or song.edit.ap_events[v:GetText()]
			v:SetIcon(isagree and "icon16/tick.png" or "icon16/cross.png")
		end

		self:UpdateText()
	end

	local t = {}
	table.Add(t, EVENTSLIST)
	table.sort(t)
	table.insert(t, 1, "regular")
	for _, v in ipairs(t) do
		local opt
		opt = men:AddOption("", function(_)
			if song.edit.ap_events[v] then
				song.edit.ap_events[v] = nil
			else
				song.edit.ap_events[v] = true
			end

			if table.Count(song.edit.ap_events) == #t then -- We've enabled all events
				song.edit.ap_events = {} -- Then disable all, it's the same thing
			end

			UpdateOpts()
		end)
		opt:SetText(v)
		opt.OnMouseReleased = function(self_opt, mousecode) -- disable derma menu closing
			DButton.OnMouseReleased( self_opt, mousecode )
			if self_opt.m_MenuClicking and mousecode == MOUSE_LEFT then
				self_opt.m_MenuClicking = false
			end
		end

		table.insert(opts, opt)
	end
	UpdateOpts()

	men:Open()
end

local function OpenSongMenu(song, row)
	local men = DermaMenu()

	if CanPlaySong(song) then
		men:AddOption("Play", function()
			LocalPlayer():ConCommand("d_play " .. song:GetURL())
		end):SetIcon("icon16/resultset_next.png")

		men:AddSpacer()
	end

	men:AddOption("Copy Youtube URL", function()
		SetClipboardText(string.format("https://www.youtube.com/watch?v=%s", song:GetURL()))
		Hint("Youtube URL copied!")
	end):SetIcon("icon16/link.png")

	men:AddOption("Open in Youtube", function()
		local url = string.format("https://www.youtube.com/watch?v=%s", song:GetURL())
		gui.OpenURL(url)
	end):SetIcon("icon16/link_go.png")


	if CanEditSong(song) then
		men:AddSpacer()

		men:AddOption("Edit Title", function()
			row:EditTitle()
		end):SetIcon("icon16/book_edit.png")
	end

	if CanRemoveSong(song) then
		men:AddSpacer()

		men:AddOption("Remove", function()
			Derma_Query("Remove \"" .. song:GetTitle() .. "\"?", "Are you sure?", "Yes, delete", function()
				song:Remove()
			end, "Cancel", function() end)
		end):SetIcon("icon16/cross.png")
	end

	men:Open()
end

local phasenames = {
	[1] = "Build",
	[2] = "Preparation & Flooding",
	[3] = "",
	[4] = "Fighting",
	[5] = "Reflect",
}

local saveicon = Material("icon16/disk.png")
local dirtyicon = Material("icon16/exclamation.png")

local rowtall = 30
local function CreateSongRow(song)
	local caneditsong = CanEditSong(song)

	local pnl = vgui.Create("DPanel")
		pnl.Paint = function() end
		pnl:SetSize(0, rowtall)
		pnl.sortvalues = {
			title = song:GetTitle():lower(),
			length = song:GetLength(),
			ap_enabled = song:GetAutoPlayEnabled() and 1 or 0,
			uploader = song:GetUploaderNick():lower(),
			date = song:GetTimestamp(),
		}

	local lbltitle = vgui.Create("DLabelCenter", pnl)
		lbltitle:SetFont("FMRegular20")
		lbltitle:SetCursor("hand")
		lbltitle:SetDark(true)
		lbltitle:SetCenterY(true)
		lbltitle:SetText(song.edit.title)
		lbltitle:SetTooltip(song.edit.title)
		lbltitle.OnMousePressed = function()
			OpenSongMenu(song, pnl)
		end
	local savebtn = vgui.Create("DImageButton", pnl)
		savebtn:SetMaterial(saveicon)
		savebtn:SetSize(16, 16)
		savebtn:SetVisible(false)
		savebtn:SetTooltip("Save changes")
		savebtn.DoClick = function(self)
			if not caneditsong then return end

			song:Save()
		end

	local dirtyimg = vgui.Create("DImage", pnl)
		dirtyimg:SetMaterial(dirtyicon)
		dirtyimg:SetSize(16, 16)
		dirtyimg:SetVisible(false)
		dirtyimg:SetTooltip("Someone else has edited this while you were making changes!")
	pnl.dirty = dirtyimg

	local txtinputtitle = vgui.Create("DTextEntry", pnl)
		txtinputtitle:SetVisible(false)
		txtinputtitle:SetTooltip("Press the enter key to set")
		txtinputtitle.OnEnter = function(self)
			if not caneditsong then return end

			lbltitle:SetText(self:GetText())
			song.edit.title = self:GetText()
			self:SetVisible(false)

			pnl:InvalidateLayout()
		end

	pnl.EditTitle = function()
		if not caneditsong then return end

		txtinputtitle:SetValue(lbltitle:GetText())
		txtinputtitle:SetVisible(true)
		txtinputtitle:RequestFocus()
	end

	local lbldur = vgui.Create("DLabelCenter", pnl)
		lbldur:SetFont("FMRegular20")
		lbldur:SetDark(true)
		lbldur:SetCenterY(true)
		lbldur:SetText(string.FromSeconds(song:GetLength()))
		lbldur:SetTooltip("Duration")

	local pnlapenable = vgui.Create("DPanel", pnl)
		pnlapenable.Paint = function() end
		pnlapenable:SetTooltip("Auto-Play Enabled")

	local pnlphases = vgui.Create("DPanel", pnl)
		pnlphases.Paint = function() end
	pnl.phases = {}
	local function UpdatePhaseChkbxes(chkbx)
		local ap_phases = song.edit.ap_phases or 0

		if caneditsong and chkbx then
			-- Selection / Deselection
			if bit.band(bit.lshift(1,chkbx.i), ap_phases) == 0 then -- Check current value
				ap_phases = bit.bor(ap_phases, bit.lshift(1,chkbx.i)) -- Check
			else
				ap_phases = bit.band(ap_phases, bit.bnot(bit.lshift(1,chkbx.i))) -- Uncheck
			end

			-- If all are checked, set to 0 instead for consistency
			if ap_phases == bit.bor(TIME_BUILD, TIME_PREPARE, TIME_FIGHT, TIME_REFLECT) then
				ap_phases = 0
			end

			song.edit.ap_phases = ap_phases
		end

		if ap_phases > 0 then
			for i, v in pairs(pnl.phases) do
				v:SetChecked(bit.band(bit.lshift(1,i), ap_phases) > 0)
			end
		else
			for _, v in pairs(pnl.phases) do
				v:SetChecked(true)
			end
		end
	end
	for i = 0,4 do
		if i == 2 then continue end
		local chkbx = vgui.Create("DCheckBox", pnlphases)
			chkbx.OnChange = UpdatePhaseChkbxes
			chkbx:Dock(LEFT)
			chkbx:SetTooltip("Auto-Play enabled during the " .. phasenames[i + 1] .. " phase")
			chkbx:SetEnabled(caneditsong)
			chkbx.i = i
		pnl.phases[i] = chkbx
	end
	UpdatePhaseChkbxes()

	local pnlevents = vgui.Create("DButton", pnl)
		pnlevents.Paint = function() end
		pnlevents.song = song
		pnlevents.UpdateText = eventsbtnsettext
		pnlevents:UpdateText()
		pnlevents.DoClick = eventsbtndoclick
		pnlevents:SetTooltip("Auto-Play enabled during specific event types")
		pnlevents:SetEnabled(caneditsong)
	pnl.eventsbtn = pnlevents

	local chkbxapenable = vgui.Create("DCheckBox", pnlapenable)
		chkbxapenable.OnChange = function(self, newval)
			if not caneditsong then return end

			if newval != song.edit.ap_enabled then
				song.edit.ap_enabled = newval
			end

			pnlevents:SetEnabled(newval)
			for _,v in pairs(pnl.phases) do
				v:SetEnabled(newval)
			end
		end
		chkbxapenable:SetValue(song.edit.ap_enabled)
		chkbxapenable:SetEnabled(caneditsong)

	local lbluploader = vgui.Create("DLabelCenter", pnl)
		lbluploader:SetFont("FMRegular20")
		lbluploader:SetDark(true)
		lbluploader:SetCenterY(true)
		lbluploader:SetText(song:GetUploaderNick())
		lbluploader:SetTooltip("Uploader name, click to copy steamid")
		lbluploader.OnMousePressed = function()
			SetClipboardText(song:GetUploaderSteamID())
			Hint("SteamID copied!")
		end

	local lbldate = vgui.Create("DLabelCenter", pnl)
		lbldate:SetFont("FMRegular20")
		lbldate:SetDark(true)
		lbldate:SetCenterY(true)
		lbldate:SetText(os.date("%Y-%m-%d", song:GetTimestamp()))
		lbldate:SetTooltip("Uploaded date")

	pnl.Think = function(self)
		savebtn:SetVisible(caneditsong and song:IsEdited())
	end

	pnl.PerformLayout = function(self, w, h)
		local titlew = math.Round(w / 2)
		local durw = 50
		local apenw = 24
		local phasesw = 16 * 4
		local uploaderw = 140
		local datew = 100
		local eventsw = w - (titlew + durw + apenw + phasesw + uploaderw + datew)
		if eventsw < 50 then
			titlew = titlew + (eventsw - 50)
			eventsw = 50
		end

		savebtn:SetPos(2, h / 2 - 8)
		dirtyimg:SetPos(2 + 16 + 2, h / 2 - 8)

		if txtinputtitle:IsVisible() then
			lbltitle:SetVisible(false)

			txtinputtitle:SetPos(5, h / 2 - txtinputtitle:GetTall() / 2)
			txtinputtitle:SetWide(titlew - 10)
		else
			lbltitle:SetVisible(true)
			lbltitle:SetPos(0, 0)
			lbltitle:SetSize(titlew, h)
		end

		lbldur:SetPos(titlew, 0)
		lbldur:SetSize(durw, h)

		pnlapenable:SetPos(titlew + durw, 0)
		pnlapenable:SetSize(apenw, h)
		chkbxapenable:Center()

		pnlphases:SetPos(titlew + durw + apenw, 0)
		pnlphases:SetSize(phasesw, h)
		local phasechkbxdist = h / 2 - 8
		pnlphases:DockPadding(0, phasechkbxdist, 0, phasechkbxdist + 1)

		pnlevents:SetPos(titlew + durw + apenw + phasesw, 0)
		pnlevents:SetSize(eventsw, h)

		lbluploader:SetPos(titlew + durw + apenw + phasesw + eventsw, 0)
		lbluploader:SetSize(uploaderw, h)

		lbldate:SetPos(titlew + durw + apenw + phasesw + eventsw + uploaderw, 0)
		lbldate:SetSize(datew, h)
	end

	return pnl
end

local function rowpainteven(self, w, h)
	if self.song:IsPlaying() then
		surface.SetDrawColor(Color(0, 255, 0, 35))
		surface.DrawRect(0, 0, w, h)
	end
end

local function rowpaintodd(self, w, h)
	rowpainteven(self, w, h)

	surface.SetDrawColor(Color(0,0,0,35))
	surface.DrawRect(0,0,w,h)
end

local sortkey = cookie.GetString("fm_songlist_sortkey", "title")
local sortasc = cookie.GetNumber("fm_songlist_sortasc", 1) > 0
local function SortList(li, key, asc)
	if key then
		sortkey = key
		cookie.Set("fm_songlist_sortkey", key)
	end

	if asc != nil then
		sortasc = asc
		cookie.Set("fm_songlist_sortasc", asc and 1 or 0)
	end

	table.sort(li.songrows, function(a, b)
		local aval = a.sortvalues[sortkey]
		local bval = b.sortvalues[sortkey]

		if a:IsVisible() != b:IsVisible() then
			return a:IsVisible()
		end

		--If same, sort by date instead, which will never be same
		--"not aval" catches if we supplied a invalid key somehow
		if (not aval) or aval == bval then
			aval = a.sortvalues["date"]
			bval = b.sortvalues["date"]
		end

		if sortasc then
			return aval < bval
		else
			return aval > bval
		end
	end)

	local i = 0
	for k, pnl in pairs(li.songrows) do
		if not pnl:IsVisible() then continue end

		i = i + 1
		pnl:SetZPos(100 + i)

		if (i % 2) == 0 then
			pnl.Paint = rowpainteven
		else
			pnl.Paint = rowpaintodd
		end
	end
end

local frame

local function AddSong(songobj)
	local li = frame.list

	local pnl = CreateSongRow(songobj)
	pnl.song = songobj
	li:AddItem(pnl)
	pnl:Dock(TOP)
	table.insert(li.songrows, pnl)

	SortList(li)
end

local function RemoveSong(songobj)
	for k, pnl in pairs(frame.list.songrows) do
		if pnl.song == songobj then
			pnl:Remove()
			table.remove(frame.list.songrows, k)
			break
		end
	end

	SortList(frame.list)
end

local function UpdateList()
	if not IsValid(frame) then return end

	local li = frame.list
	li:Clear()
	li:Rebuild()
	li.songrows = {}

	for _,v in pairs(GAMEMODE:GetSongs()) do
		AddSong(v)
	end
end

local function DoSearch(text)
	if not IsValid(frame) then return end

	if not text or #(text:Trim()) == 0 then
		for _, pnl in pairs(frame.list.songrows) do
			pnl:SetVisible(true)
		end

		SortList(frame.list)

		return
	end

	text = text:lower():Trim():PatternSafe()

	for _, pnl in pairs(frame.list.songrows) do
		pnl:SetVisible(pnl.sortvalues.title:find(text) != nil)
	end

	SortList(frame.list)
end

hook.Add("FMSongRemoved", "SongList", function(songobj)
	if not IsValid(frame) then return end

	RemoveSong(songobj)
end)

hook.Add("FMSongAdded", "SongList", function(songobj)
	if not IsValid(frame) then return end

	AddSong(songobj)
end)

hook.Add("FMSongUpdate", "SongList", function(songobj)
	if not IsValid(frame) then return end

	for _, pnl in pairs(frame.list.songrows) do
		if pnl.song == songobj then
			if songobj:IsEdited() then
				HintError("Someone else has edited the song \"" .. songobj.edit.title .. "\" while you had standing changes. Saving this will overwrite their changes!")
				pnl.dirty:SetVisible(true)
			else
				-- Not edited, straight up replace it
				RemoveSong(songobj)
				AddSong(songobj)
			end

			break
		end
	end
end)

hook.Add("FMSongsFullUpdate", "SongList", function()
	UpdateList()
end)

local sortkeys = {
	title = "Title",
	length = "Duration",
	ap_enabled = "AutoPlay",
	uploader = "Uploader",
	date = "Date Added",
}
local function SetupMenuBar(men)
	if CanEditSong() then
		local men_songs = men:AddMenu("Songs")
			men_songs:AddOption("Revert changes & Update list", function()
				net.Start("FMRequestSongResend")
				net.SendToServer()
			end)

		if CanAddSong() then
			men_songs:AddOption("Add Song", function()
				OpenAddSongForm()
			end)
		end
	end

	local men_sort = men:AddMenu("Sort")
		--men_sort:AddOption("Sort direction " .. (sortasc and "▲" or "▼"), function()
		men_sort:AddOption("Switch sort direction", function()
			SortList(frame.list, nil, not sortasc)
		end)
		men_sort:AddSpacer()
		for key, nicename in pairs(sortkeys) do
			men_sort:AddOption(nicename, function()
				SortList(frame.list, key)
			end)
		end

	local men_search = men:Add("DTextEntry")
		men_search:Dock(LEFT)
		men_search:DockMargin(5, 0, 0, 0)
		men_search:SetWide(100)
		men_search:SetPlaceholderText("Search...")
		men_search:SetUpdateOnType(true)
		men_search.OnValueChange = function(_, text)
			DoSearch(text)
		end
end

local function OpenSongList()
	if not CanViewSongList() then return end

	if not IsValid(frame) then
		frame = vgui.Create("DFrame")
			frame:SetDeleteOnClose(false)
			frame:SetSizable(true)
			frame:ShowCloseButton(true)
			frame:SetSize(850, 500)
			frame:SetTitle("Devinity Song List")
			frame:Center()
			frame:MakePopup()
			frame:DockPadding(2, 24, 2, 2)

		local men = vgui.Create("DMenuBar", frame)
			men:DockMargin(-1, 0, -1, 0)
			men:Dock(TOP)
		SetupMenuBar(men)

		local pnllistbg = vgui.Create("DPanel", frame)
			pnllistbg:Dock(FILL)

		local pnllist = vgui.Create("DScrollPanel", pnllistbg)
			pnllist:Dock(FILL)

		frame.list = pnllist

		UpdateList()
	end

	frame:SetVisible(true)
end
net.Receive("FMOpenSongList", OpenSongList)
