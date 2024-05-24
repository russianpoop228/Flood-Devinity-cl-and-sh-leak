
surface.CreateFont( "FMTeamMenuFont",
	{
		font		= "Verdana",
		size		= 24,
		weight		= 500,
		antialias 	= true,
		italic 		= false,
	}
)
surface.CreateFont( "FMTeamMenuFont2",
	{
		font		= "Verdana",
		size		= 20,
		weight		= 500,
		antialias 	= true,
		italic 		= false,
	}
)

function GM:SpawnMenuEnabled()
	return false
end

function GM:SpawnMenuOpen()
	return false
end

--[[
Settings
]]

AddSettingsItem("flood", "button", "", {lbl = "Reload spawn icons", func = function() hook.Run("FMReloadSpawnIcons") end})

local PANEL = {}
function PANEL:Init()
	local menuw = math.min(ScrW() - 50, 1220)
	local menuh = math.min(ScrH() - 50, 800)

	g_SpawnMenu = self
	MENU = self

	self:SetTitle("")
	self:ShowCloseButton(false)
	self:SetSize(menuw, menuh)
	self:Center()
	self:SetMouseInputEnabled( true )

	local propSheet
	propSheet = vgui.Create("DPropertySheet", self)
		propSheet:SetSize((menuw * 0.5 - 5), menuh)
	local propSheetW, propSheetH = propSheet:GetWide(), propSheet:GetTall()

	self.PropPanel = propSheet

	local toolSheet
	toolSheet = vgui.Create("DPropertySheet", self)
		toolSheet:SetSize((menuw * 0.5 - 5), menuh)
		toolSheet:SetPos((menuw * 0.5 + 5), 0)
	local toolSheetW, toolSheetH = toolSheet:GetWide(), toolSheet:GetTall()

	self.FMToolMenu = toolSheet

	--[[
	Prop panel (left side)
	]]

	--[[
	Props tab
	]]
	local propsbasepnl = vgui.Create("DScrollPanel")
		propsbasepnl:SetSize((propSheetW - 10), propSheetH)

	SetupProps(propsbasepnl, propSheetW, propSheetH)

	propSheet:AddSheet("Props", propsbasepnl, "icon16/brick_add.png", true, false)

	--[[
	Weapons tab
	]]
	local wepbasepnl = vgui.Create("DPanel")
		wepbasepnl.Paint = function() end

	SetupWeapons(wepbasepnl, propSheetW, propSheetH)

	propSheet:AddSheet("Weapons and Utilities", wepbasepnl, "icon16/bomb.png", false, false)

	--[[
	Purchase tab
	]]
	local purchasebasepnl = vgui.Create("DPanel")
		purchasebasepnl.Paint = function() end

	SetupPurchase(purchasebasepnl, propSheetW, propSheetH)

	propSheet:AddSheet("Purchase", purchasebasepnl, "icon16/heart.png", false, false)

	--[[
	Leaderboard tab
	]]
	local leaderbasepnl = vgui.Create("DPanel")
		leaderbasepnl.Paint = function() end

	SetupLeaderboards(leaderbasepnl, propSheetW, propSheetW)

	propSheet:AddSheet("Leaderboards", leaderbasepnl, "icon16/shield.png", false, false)

	--[[
	Tool panel (rightside)
	]]

	--[[
	Tools tab
	]]
	local toolsbasepnl = vgui.Create("DPanel")
		toolsbasepnl.Paint = function() end

	SetupTools(toolsbasepnl, toolSheetW, toolSheetH)

	toolSheet:AddSheet( "Tools", toolsbasepnl, spawnmenu.GetTools()[1].Icon )

	--[[
	Help tab
	]]
	local helpbasepnl = vgui.Create("DPanel")
		helpbasepnl.Paint = function() end

	SetupHelpMenu(helpbasepnl, toolSheetW, toolSheetH)

	local helptab = toolSheet:AddSheet("Help/Rules", helpbasepnl, "icon16/information.png", false, false)
	helptab.showchloghint = false

	local lastcheck = 0
	hook.Add("Think", "UpdateHelpTab", function()
		if not helptab or not helptab.Tab.Image then return end
		if lastcheck > CurTime() then return end
		lastcheck = CurTime() + 0.1

		local newmode = ShowNewChangelogNotice()

		if helptab.showchloghint != newmode then
			helptab.showchloghint = newmode

			if newmode then
				helptab.Tab.Image:SetImage("icon16/error.png")
				helptab.Tab:SetTooltip("There's a new update!")
			else
				helptab.Tab.Image:SetImage("icon16/information.png")
				helptab.Tab:SetTooltip()
			end
		end
	end)

	--[[
	Store tab
	]]
	local storebasepnl = vgui.Create("DPanel")
		storebasepnl.Paint = function() end

	SetupStore(storebasepnl, toolSheetW, toolSheetH)

	toolSheet:AddSheet("Store", storebasepnl, "icon16/money_dollar.png", false, false)


	--[[
	Team tab
	]]
	local teambasepnl = vgui.Create("DPanel")
		teambasepnl.Paint = function() end

	SetupTeamMenu(teambasepnl, toolSheetW, toolSheetH)

	toolSheet:AddSheet("Teams", teambasepnl, "icon16/group.png", false, false)

	--[[
	Settings tab
	]]
	local settingsbasepnl = vgui.Create("DPanel")
		settingsbasepnl.Paint = function() end

	SetupSettings(settingsbasepnl, toolSheetW, toolSheetH)

	toolSheet:AddSheet("Settings", settingsbasepnl, "icon16/wrench.png", false, false)

	--[[
	Vote tab
	]]
	local votebasepnl = vgui.Create("DPanel")
		votebasepnl.Paint = function() end

	SetupVoteMenu(votebasepnl, toolSheetW, toolSheetH)

	toolSheet:AddSheet("Vote", votebasepnl, "icon16/sport_football.png", false, false)
end

function PANEL:HangOpen(bHang)
	self.m_bHangOpen = bHang
end

function PANEL:HangingOpen()
	return self.m_bHangOpen
end

function PANEL:StartKeyFocus(pPanel)
	self.m_pKeyFocus = pPanel
	self:SetKeyboardInputEnabled(true)
	self:HangOpen(true)
end

function PANEL:EndKeyFocus(pPanel)
	if self.m_pKeyFocus != pPanel then return end
	self:SetKeyboardInputEnabled(false)
end

hook.Add( "OnTextEntryGetFocus", "FMSpawnMenuKeyboardFocusOn", function(pnl)
	if not IsValid(pnl) then return end

	pnl:SetDrawLanguageID(false)

	if IsValid(g_SpawnMenu) and pnl:HasParent(g_SpawnMenu) then
		g_SpawnMenu:StartKeyFocus(pnl)
	end
end)

hook.Add( "OnTextEntryLoseFocus", "FMSpawnMenuKeyboardFocusOn", function(pnl)
	if not IsValid(pnl) then return end

	if IsValid(g_SpawnMenu) and pnl:HasParent(g_SpawnMenu) then
		g_SpawnMenu:EndKeyFocus(pnl)
	end
end)

function PANEL:GetToolMenu()
	return self.FMToolMenu
end

function PANEL:Paint()
	return true
end

function PANEL:Think()
end

function PANEL:Close()
end

function PANEL:PerformLayout()
end
vgui.Register("fmqmenu", PANEL, "DFrame")

function GM:OnSpawnMenuOpen()
	if not IsValid(MENU) then
		vgui.Create("fmqmenu")
		MENU:SetKeyboardInputEnabled(false)

		hook.Remove("OnTextEntryGetFocus", "SpawnMenuKeyboardFocusOn") -- Dirty as fuck, removes some hook which old spawnmenu uses
	else
		MENU.m_bHangOpen = false

		MENU:SetVisible(true)
		MENU:MakePopup()
		MENU:SetVisible(true)
		MENU:SetKeyboardInputEnabled(false)
		MENU:SetMouseInputEnabled(true)

		hook.Run("FMSpawnmenuUpdate", MENU)
	end

	gui.EnableScreenClicker(true)
	RestoreCursorPosition()
end

function GM:OnSpawnMenuClose()
	if MENU.m_bHangOpen then
		MENU.m_bHangOpen = false
		return
	end

	if IsValid(MENU) and MENU:IsVisible() then
		MENU:SetVisible(false)
		MENU:SetKeyboardInputEnabled(false)
		MENU:SetMouseInputEnabled(false)
	end

	RememberCursorPosition()
	gui.EnableScreenClicker(false)
end

hook.Remove("OnGamemodeLoaded", "CreateSpawnMenu")
hook.Add("OnGamemodeLoaded", "CreateFloodSpawnmenu", function()

	-- If we have an old spawn menu remove it.
	if g_SpawnMenu or MENU then
		g_SpawnMenu:Remove()
		g_SpawnMenu = nil
		MENU = nil
	end

	-- Start Fresh
	spawnmenu.ClearToolMenus()
	hook.Run("AddGamemodeToolMenuTabs")
	hook.Run("AddToolMenuTabs")
	hook.Run("AddGamemodeToolMenuCategories")
	hook.Run("AddToolMenuCategories")
	hook.Run("PopulateToolMenu")

	g_SpawnMenu = vgui.Create("fmqmenu")
	g_SpawnMenu:SetVisible(false)

	CreateContextMenu()

	hook.Run("PostReloadToolsMenu")
end)

hook.Add("FMOnReloaded", "RefreshQMenu", function()
	if g_SpawnMenu or MENU then
		g_SpawnMenu:Remove()
		g_SpawnMenu = nil
		MENU = nil

		g_SpawnMenu = vgui.Create("fmqmenu")
		g_SpawnMenu:SetVisible(false)
	end
end)
