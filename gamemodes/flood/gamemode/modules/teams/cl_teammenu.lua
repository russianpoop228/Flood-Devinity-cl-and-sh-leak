
local function DrawPanel(x, y, w, h, col)
	derma.GetDefaultSkin().tex.Panels.Bright(x, y, w, h, col)
end

local function CanJoinTeam(tm)
	if not tm then return false end

	local invited = tm:IsPublic() or tm:HasInvite(LocalPlayer())
	return invited and (LocalPlayer():CTeam() != tm)
end

local teamlist
local function FillTeamlist()
	local oldselected = teamlist.SelectedTeam
	teamlist:Clear()

	for _,tm in pairs(GetCTeams()) do
		if oldselected and oldselected == tm:GetName() then
			teamlist:SelectTeam(oldselected)
		end

		local pnl = vgui.Create("DPanel")
			pnl:SetTall(32)
			pnl:DockPadding(4,4,4,4)

		local lbl = vgui.Create("DLabel", pnl)
			lbl:SetFont("FMRegular24")
			lbl:SetText(tm:GetName())
			lbl:SetTextColor(FMCOLORS.bg)
			lbl:SizeToContents()
			lbl:Dock(FILL)

		local maxplayers = GetMaxTeamPlayers()
		local teamplayers = tm:GetNumberOfMembers()

		local rightpnl = vgui.Create("DPanel", pnl)
			rightpnl.Paint = function() end
			rightpnl:Dock(RIGHT)
			rightpnl:DockPadding(0,0,0,0)
			rightpnl:SetWide(60)

			local lbl = vgui.Create("DLabel", rightpnl)
				lbl:SetFont("FMRegular22")
				lbl:SetText(string.format("%i/%i", teamplayers, maxplayers))
				lbl:SetBright(true)
				lbl:SizeToContents()
				lbl:Dock(FILL)

			local icon = vgui.Create("DImage", rightpnl)
				icon:SetSize(16,16)
				icon:Dock(RIGHT)
				icon:DockMargin(4,4,0,4)

		if LocalPlayer():CTeam() and LocalPlayer():CTeam() == tm then
			icon:SetImage("icon16/status_online.png")
			icon:SetTooltip("Current team.")
		elseif teamplayers >= maxplayers then
			icon:SetImage("icon16/status_busy.png")
			icon:SetTooltip("Team is full!")
		elseif tm:HasInvite(LocalPlayer()) then
			icon:SetImage("icon16/status_offline.png")
			icon:SetTooltip("You are invited to this team.")
		elseif tm:IsPublic() then
			icon:SetImage("icon16/world.png")
			icon:SetTooltip("This team is public.")
		else
			icon:SetImage("icon16/status_busy.png")
			icon:SetTooltip("You are not invited to this team.")
		end

		local topbtn = vgui.Create("DButton", pnl)
			topbtn.Paint = function() end
			topbtn:SetText("")
			topbtn.DoClick = function()
				teamlist:SelectTeam(tm:GetName())
			end

		pnl.SetupColors = function(self, baseclr)
			local h,s,v = ColorToHSV(baseclr)
			self.hoverclr = HSVToColor(h,s,v)
			self.downclr = HSVToColor(h,s,v -	0.1)
			self.m_bgColor = HSVToColor(h,s,v - 0.05)
		end
		pnl:SetupColors(tm:GetColor())

		pnl.Paint = function(self,w,h)
			if teamlist.SelectedTeam == tm:GetName() then
				DrawPanel(0, 0, w, h, self.downclr)
			elseif topbtn.Hovered then
				DrawPanel(0, 0, w, h, self.hoverclr)
			else
				DrawPanel(0, 0, w, h, self.m_bgColor)
			end
		end

		pnl.PerformLayout = function()
			topbtn:SetSize(pnl:GetSize())
		end

		teamlist:AddItem(pnl)
	end
end

local createteampnl
local manageteampnl

local teambuttonlist
local playerlist
local function FillPlayerlist()
	if not IsValid(LocalPlayer()) then return end

	local oldselected = playerlist.SelectedPlayer
	playerlist:Clear()

	local plylist = table.Copy(player.GetAll())

	local locplyteam = LocalPlayer():CTeam()
	table.sort(plylist, function(a,b)
		local at = a:CTeam()
		local bt = b:CTeam()

		--Push own team up to the top
		if at != bt then
			if at == locplyteam then
				return true
			elseif bt == locplyteam then
				return false
			end
		end

		--Sort alphabetically
		return a:Nick() < b:Nick()
	end)

	for _,ply in ipairs(plylist) do
		local itsame = (ply == LocalPlayer())

		if oldselected and oldselected == ply then
			playerlist:SelectPlayer(oldselected)
		end

		local pnl = vgui.Create("DPanel")
			pnl:SetTall(24)
			pnl:DockPadding(4,2,4,2)

		local lbl = vgui.Create("DLabel", pnl)
			lbl:SetFont("FMRegular20")
			lbl:SetText(itsame and "Me" or ply:FilteredNick())
			lbl:SetTextColor(FMCOLORS.bg)
			lbl:SizeToContents()
			lbl:Dock(FILL)

		local topbtn = vgui.Create("DButton", pnl)
			topbtn.Paint = function() end
			topbtn:SetText("")
			topbtn.DoClick = function()
				if itsame then return end

				playerlist:SelectPlayer(ply)
			end

		pnl.SetupColors = function(self, baseclr)
			local h,s,v = ColorToHSV(baseclr)
			self.hoverclr = HSVToColor(h,s,v)
			self.downclr = HSVToColor(h,s,v - 0.1)
			self.m_bgColor = HSVToColor(h,s,v - 0.05)
		end

		local clrSameTeam = Color(171, 212, 236)
		local clrInvited = Color(232, 235, 167)
		local clrDefault = FMCOLORS.txt

		if ply:CTeam() and ply:CTeam() == LocalPlayer():CTeam() then
			pnl:SetupColors(clrSameTeam)
		elseif LocalPlayer():CTeam() and LocalPlayer():CTeam():HasInvite(ply) then
			pnl:SetupColors(clrInvited)
		else
			pnl:SetupColors(clrDefault)
		end

		pnl.Paint = function(self,w,h)
			if playerlist.SelectedPlayer == ply then
				DrawPanel(0, 0, w, h, self.downclr)
			elseif topbtn.Hovered then
				DrawPanel(0, 0, w, h, self.hoverclr)
			else
				DrawPanel(0, 0, w, h, self.m_bgColor)
			end
		end

		pnl.PerformLayout = function()
			topbtn:SetSize(pnl:GetSize())
		end

		playerlist:AddItem(pnl)
	end
end

local function UpdateManageTeamPanel(w, h)
	if IsValid(playerlist) then
		if not manageteampnl:IsVisible() then return end

		FillPlayerlist()
		teambuttonlist:Update()
		return
	end

	playerlist = vgui.Create("DPanelList", manageteampnl)
		playerlist:Dock(FILL)
		playerlist:EnableVerticalScrollbar()
		playerlist:EnableHorizontal(false)
		playerlist:SetPadding(1)
		playerlist:SetSpacing(1)
		playerlist:DockMargin(0,0,2,0)
		playerlist.SelectedPlayer = nil
	Derma_Hook( playerlist, "Paint", "Paint", "Panel" )

	FillPlayerlist()

	teambuttonlist = vgui.Create("DPanelList", manageteampnl)
		teambuttonlist:Dock(RIGHT)
		teambuttonlist:SetWide(150)
		teambuttonlist:EnableHorizontal(false)
		teambuttonlist:SetPadding(2)
		teambuttonlist:SetSpacing(4)

	local selectedplayerlbl = vgui.Create("DLabel")
		selectedplayerlbl:SetTall(22)
		selectedplayerlbl:SetFont("FMRegular18")
		selectedplayerlbl:SetBright(true)
		selectedplayerlbl:SetText("")
		teambuttonlist:AddItem(selectedplayerlbl)

	local invitebtn = vgui.Create("DButton")
		invitebtn:SetTall(26)
		invitebtn:SetFont("FMRegular20")
		invitebtn:SetText("Invite")
		invitebtn.DoClick = function()
			LocalPlayer():CTeam():InvitePlayer(playerlist.SelectedPlayer)
		end
		teambuttonlist:AddItem(invitebtn)

	local gotobtn = vgui.Create("DButton")
		gotobtn:SetTall(26)
		gotobtn:SetFont("FMRegular20")
		gotobtn:SetText("Go To")
		gotobtn.DoClick = function()
			if IsValid(playerlist.SelectedPlayer) then
				RunConsoleCommand("d_teamgoto", playerlist.SelectedPlayer:UserID())
			end
		end
		teambuttonlist:AddItem(gotobtn)

	local bringbtn = vgui.Create("DButton")
		bringbtn:SetTall(26)
		bringbtn:SetFont("FMRegular20")
		bringbtn:SetText("Bring")
		bringbtn.DoClick = function()
			if IsValid(playerlist.SelectedPlayer) then
				RunConsoleCommand("d_teambring", playerlist.SelectedPlayer:UserID())
			end
		end
		teambuttonlist:AddItem(bringbtn)

	local kickbtn = vgui.Create("DButton")
		kickbtn:SetTall(26)
		kickbtn:SetFont("FMRegular20")
		kickbtn:SetText("Kick")
		kickbtn.DoClick = function()
			LocalPlayer():CTeam():KickPlayer(playerlist.SelectedPlayer)
		end
		teambuttonlist:AddItem(kickbtn)

	local trnsfrbtn = vgui.Create("DButton")
		trnsfrbtn:SetTall(26)
		trnsfrbtn:SetFont("FMRegular20")
		trnsfrbtn:SetText("Transfer Leader")
		trnsfrbtn.DoClick = function()
			Derma_Query("Are you sure you want to transfer leadership to " .. playerlist.SelectedPlayer:FilteredNick() .. "?",
						"Are you sure?",
						"Yes", function()
							LocalPlayer():CTeam():TransferLeadership(playerlist.SelectedPlayer)
						end,
						"No", function() end)
		end
		teambuttonlist:AddItem(trnsfrbtn)

	local spacer = vgui.Create("DPanel")
		spacer.Paint = function() end
		spacer:SetTall(10)
		teambuttonlist:AddItem(spacer)

	local chngnamebtn = vgui.Create("DButton")
		chngnamebtn:SetTall(26)
		chngnamebtn:SetFont("FMRegular20")
		chngnamebtn:SetText("Change Name")
		chngnamebtn.DoClick = function()
			local curname = LocalPlayer():CTeam():GetName()

			Derma_StringRequest("Change team name",
						"Input the new name. The team name can only be changed once a round.",
						curname,
						function(newname) LocalPlayer():CTeam():ChangeName(newname) end)
		end
		teambuttonlist:AddItem(chngnamebtn)

	local destroybtn = vgui.Create("DButton")
		destroybtn:SetTall(26)
		destroybtn:SetFont("FMRegular20")
		destroybtn:SetText("Destroy Team")
		destroybtn.DoClick = function()
			Derma_Query("Are you sure you want to destroy your team?",
						"Are you sure?",
						"Yes", function()
							LocalPlayer():CTeam():Destroy()
						end,
						"No", function() end)
		end
		teambuttonlist:AddItem(destroybtn)

		teambuttonlist.Update = function(self)
			local ply = playerlist.SelectedPlayer

			if IsValid(ply) then
				selectedplayerlbl:SetText(ply:FilteredNick())

				invitebtn:SetDisabled( not (LocalPlayer():IsLeader() and ply:CTeam() != LocalPlayer():CTeam()))
				gotobtn:SetDisabled( not (ply:CTeam() == LocalPlayer():CTeam() and GAMEMODE:IsPhase(TIME_BUILD)))
				bringbtn:SetDisabled( not (LocalPlayer():IsLeader() and ply:CTeam() == LocalPlayer():CTeam() and GAMEMODE:IsPhase(TIME_BUILD)))
				kickbtn:SetDisabled( not (LocalPlayer():IsLeader() and ply:CTeam() == LocalPlayer():CTeam()))
				trnsfrbtn:SetDisabled( not (LocalPlayer():IsLeader() and ply:CTeam() == LocalPlayer():CTeam()))
			else
				selectedplayerlbl:SetText("")

				invitebtn:SetDisabled(true)
				gotobtn:SetDisabled(true)
				bringbtn:SetDisabled(true)
				kickbtn:SetDisabled(true)
				trnsfrbtn:SetDisabled(true)
			end

			chngnamebtn:SetDisabled(not LocalPlayer():IsLeader())
			destroybtn:SetDisabled(not LocalPlayer():IsLeader())
		end

		playerlist.SelectPlayer = function(self,ply)
			self.SelectedPlayer = ply
			teambuttonlist:Update()
		end
end

local function FixColorPalette(palette)
	for k,v in pairs(palette.Palette:GetChildren()) do
		local _,_,b = ColorToHSV(v:GetColor())
		if b < 0.5 then
			v:Remove()
		end
	end
	palette.Palette:InvalidateLayout()

	local limitv = 0.5
	local clrcub = palette.HSV
	clrcub.PerformLayout = function(self)
		DSlider.PerformLayout( self )

		local w,h = self:GetSize()
		self.BGValue:SetSize(w, h * 1.2)

		self.BGSaturation:StretchToParent( 0,0,0,0 )
		self.BGSaturation:SetZPos( -9 )

		self.BGValue:SetZPos( -8 )
	end
	clrcub:InvalidateLayout()

	clrcub.UpdateColor = function( self, x, y )
		x = x or self:GetSlideX()
		y = (y or self:GetSlideY()) * limitv

		local value = 1 - y
		local saturation = 1 - x
		local h = ColorToHSV( self.m_BaseRGB )

		local color = HSVToColor( h, saturation, value )

		self:SetRGB( color )
	end

	clrcub.SetColor = function( self, color )

		local h, s, v = ColorToHSV( color )
		v = math.Clamp(v, limitv, 1)

		self:SetBaseRGB( HSVToColor( h, 1, 1 ) )

		self:SetSlideY( 1 - ((v - (1 - limitv)) * (1 / limitv)) )
		self:SetSlideX( 1 - s )
		self:UpdateColor()

	end
end

local function UpdateCreateTeamPanel(w, h)
	local y = 5
	local lbl = vgui.Create("DLabel", createteampnl)
		lbl:SetPos(w / 2 - 55.5, y)
		lbl:SetText("Create team")
		lbl:SetFont("FMRegular20")
		lbl:SetTextColor(FMCOLORS.txt)
		lbl:SizeToContents()

	y = y + 29
	local x = 5
	local palette = vgui.Create("DColorMixerFM", createteampnl)
		palette:SetSize(192, 160)
		palette:SetPos(x, y)
		palette:SetPalette(true)
		palette:SetAlphaBar(false)
		palette:SetWangs(false)

	FixColorPalette(palette)

	x = x + 192 + 5
	local randclrchkbx = vgui.Create("DCheckBoxLabel", createteampnl)
		randclrchkbx:SetWide(w - 192 - 15)
		randclrchkbx:SetPos(x, y)
		randclrchkbx:SetText("Random Color")
		randclrchkbx.OnChange = function(self, newbool)
			palette:SetDisabled(newbool)
		end
		randclrchkbx:SetValue(1)

	y = y + 20
	local joinstatus = GetConVar("d_teamjoinstatus")
	local chkbx = vgui.Create("DCheckBoxLabel", createteampnl)
		chkbx:SetWide(w - 192 - 15)
		chkbx:SetPos(x, y)
		chkbx:SetText("Private")

		local status = joinstatus:GetString() or "private"
		local value = status == "private" and 1 or 0
		chkbx:SetValue(value)

		chkbx.OnChange = function(self, newbool)
			if not joinstatus then
				self:SetValue(value)
				HintError("Error setting team privacy; try again later!")
			end

			if status == "private" then
				joinstatus:SetString("public")
			else
				joinstatus:SetString("private")
			end

			status = joinstatus:GetString()
			Hint("Team privacy set to " .. status)
		end

	y = y + 25
	local txtbx = vgui.Create("DTextEntry", createteampnl)
		txtbx:SetWide(w - 192 - 15)
		txtbx:SetPos(x, y)
		txtbx:SetText("Teamname")
		txtbx:SetUpdateOnType(true)

		txtbx.OnGetFocus = function(this)
			hook.Run( "OnTextEntryGetFocus", this )

			if not this.hascleared then
				this:SetText("")
				this.hascleared = true
			end
		end

	local function ValidTeamname(txt)
		txt = string.LangSafe(txt)
		txt = txt:Trim()
		return txt != "Teamname" and #txt >= 3 and #txt <= 15
	end

	y = y + 25
	local btn = vgui.Create("DButton", createteampnl)
		btn:SetSize(w - 192 - 15, 26)
		btn:SetFont("FMRegular20")
		btn:SetPos(x, y)
		btn:SetText("Create")
		btn:SetDisabled(true)
		btn.DoClick = function()
			local txt = txtbx:GetValue()
			if ValidTeamname(txt) then
				if randclrchkbx:GetChecked() then
					RunConsoleCommand("d_teamcreate", -1, -1, -1, txt)
				else
					RunConsoleCommand("d_teamcreate", palette:GetColor().r, palette:GetColor().g, palette:GetColor().b, txt)
				end
			end
		end

		txtbx.OnTextChanged = function()
			btn:SetDisabled(not ValidTeamname(txtbx:GetValue()))
		end
end

local function UpdateManageCreation()
	if not IsValid(LocalPlayer()) then return end

	if not LocalPlayer():CTeam() then
		createteampnl:SetVisible(true)
		manageteampnl:SetVisible(false)
	else
		UpdateManageTeamPanel()
		createteampnl:SetVisible(false)
		manageteampnl:SetVisible(true)
	end
end

local buttonlist
hook.Add("OnSpawnMenuOpen", "UpdateTeamlist", function()
	if IsValid(teamlist) then
		FillTeamlist()
		buttonlist:Update()

		UpdateManageCreation()
	end
end)
hook.Add("FMTeamsUpdate", "UpdateTeamlist", function()
	if not IsValid(LocalPlayer()) then return end
	if IsValid(teamlist) and teamlist:IsVisible() then
		FillTeamlist()
		buttonlist:Update()

		UpdateManageCreation()
	end
end)

function SetupTeamMenu(parent, parentw, parenth)
	local w = math.min(parentw, 400) - 10
	local h = (parenth - 200) / 2

	--[[
	Player part
	Contains:
	List of teams
	Ability to select team and choose to join it.
	Ability to leave current team
	]]
	local playerpnl = vgui.Create("DPanel", parent)
		playerpnl:SetSize(w, h)
		playerpnl:SetPos(5, 5)
		playerpnl.Paint = function() end

	teamlist = vgui.Create("DPanelList", playerpnl)
		teamlist:Dock(FILL)
		teamlist:EnableVerticalScrollbar()
		teamlist:EnableHorizontal(false)
		teamlist:SetPadding(1)
		teamlist:SetSpacing(1)
		teamlist:DockMargin(0,0,2,0)
		teamlist.SelectedTeam = nil
	Derma_Hook( teamlist, "Paint", "Paint", "Panel" )

	FillTeamlist()

	buttonlist = vgui.Create("DPanelList", playerpnl)
		buttonlist:Dock(RIGHT)
		buttonlist:SetWide(150)
		buttonlist:EnableHorizontal(false)
		buttonlist:SetPadding(2)
		buttonlist:SetSpacing(4)

	local selectedteamlbl = vgui.Create("DLabel")
		selectedteamlbl:SetTall(22)
		selectedteamlbl:SetFont("FMRegular18")
		selectedteamlbl:SetBright(true)
		selectedteamlbl:SetText("")
		buttonlist:AddItem(selectedteamlbl)

	local joinbtn = vgui.Create("DButton")
		joinbtn:SetText("Join")
		joinbtn:SetTall(26)
		joinbtn:SetFont("FMRegular20")
		joinbtn:SetDisabled(true)
		joinbtn.DoClick = function()
			RunConsoleCommand("d_teamjoin", teamlist.SelectedTeam)
		end
		buttonlist:AddItem(joinbtn)

	local leavebtn = vgui.Create("DButton")
		leavebtn:SetText("Leave")
		leavebtn:SetTall(26)
		leavebtn:SetFont("FMRegular20")
		leavebtn:SetDisabled(true)
		leavebtn.DoClick = function()
			RunConsoleCommand("d_teamleave")
		end
		buttonlist:AddItem(leavebtn)

		buttonlist.Update = function(self)
			if not IsValid(LocalPlayer()) then return end

			local teamname = teamlist.SelectedTeam

			if teamname then
				selectedteamlbl:SetText(teamname)
				joinbtn:SetDisabled(not CanJoinTeam(GetCTeam(teamname)))
			else
				selectedteamlbl:SetText("")
				joinbtn:SetDisabled(true)
			end

			leavebtn:SetDisabled( not (LocalPlayer():CTeam() != nil and not LocalPlayer():IsLeader()))
		end

		teamlist.SelectTeam = function(self,teamname)
			self.SelectedTeam = teamname
			buttonlist:Update()
		end

	--[[
	Managing part
	Contains:
	if not leader:
	Ability to create team

	if leader:
	List of players on server, teammembers sorted at top. Interaction such as invite, kick, bring and goto can be used.
	Destroy team
	]]
	local pnl = vgui.Create("DPanel", parent)
		pnl:DockPadding(4,2,4,2)
		pnl:SetSize(144, 32)
		pnl:SetPos(w / 2 - 74 + 5, h + 10)

	local lbl = vgui.Create("DLabel", pnl)
		lbl:SetText("Management")
		lbl:SetFont("FMRegular28")
		lbl:SizeToContents()
		lbl:SetTextColor(FMCOLORS.txt)
		lbl:Dock(FILL)

	local lw,lh = lbl:GetSize()
	pnl:SetSize(lw + 10,lh + 10)
	pnl:SetPos(w / 2 - lw / 2, h + 10)

	createteampnl = vgui.Create("DPanel", parent)
		createteampnl:SetPos(5, h + 10 + 32 + 10)
		createteampnl:SetSize(w, 160 + 15 + 24)
		createteampnl:DockPadding(5, 5, 5, 5)
	UpdateCreateTeamPanel(w, h)

	manageteampnl = vgui.Create("DPanel", parent)
		manageteampnl:SetPos(5, h + 10 + 32 + 10)
		manageteampnl:SetSize(w, h)
		manageteampnl.Paint = function() end
	UpdateManageTeamPanel(w, h)

	UpdateManageCreation()
end
