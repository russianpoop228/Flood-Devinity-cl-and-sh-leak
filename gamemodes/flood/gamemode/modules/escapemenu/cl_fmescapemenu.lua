-- FMEscapeMenu

-- The entire escape menu panel

local iconcache = {}

local function getLogoMaterial(w)

	local pwr = 128

	while pwr < w do
		pwr = bit.lshift(pwr, 1)
	end

	pwr = math.Clamp(pwr, 128, 2048)

	if not iconcache[pwr] then
		iconcache[pwr] = Material(("icon32/logo/devinitylogo_white_%i.png"):format(pwr), "smooth")
	end

	return iconcache[pwr]

end

local font_regular = "FMEscapeMenuRegular"

local font_smaller = "FMEscapeMenuSmaller"

local font_small = "FMEscapeMenuSmall"

local font_mini = "FMEscapeMenuMini"

local font_mini_i = "FMEscapeMenuMiniItalic"

local function generateFonts()

	surface.CreateFont(font_regular, {
		font = "Arimo",
		size = math.Round(ScrH() / 22),
		weight = 500,
	})

	surface.CreateFont(font_smaller, {
		font = "Arimo",
		size = math.Round(ScrH() / 26),
		weight = 500,
	})

	surface.CreateFont(font_small, {
		font = "Arimo",
		size = math.Round(ScrH() / 34),
		weight = 500,
	})

	surface.CreateFont(font_mini, {
		font = "Arimo",
		size = math.Round(ScrH() / 60),
		weight = 500,
	})

	surface.CreateFont(font_mini_i, {
		font = "Arimo",
		size = math.Round(ScrH() / 60),
		weight = 500,
		italic = true,
	})

end

local PANEL = {}

function PANEL:Init()

	-- Create fonts here so we know screen size is established

	generateFonts()

	-- Panel init

	self:SetSize(ScrW(), ScrH())

	self.hasReleasedEscape = false

	self.playerbox = vgui.Create("FMEscapeMenuPlayerBox", self)

	self.newsbox = vgui.Create("FMEscapeMenuNewsBox", self)

	self.infobox = vgui.Create("FMEscapeMenuInfoBox", self)

		self.infobox:SetVisible(false)

	-- HTML panels break keyboard focus so escape button doesn't work if you focus a html panel

	-- To fix this, we have this hidden text entry that we can call RequestFocus() on to reclaim the focus

	-- to the escape menu and away from the html panel

	self.inputfocus = vgui.Create("DTextEntry", self)

	self.inputfocus:SetVisible(false)

	self.btnDisconnect = vgui.Create("FMEscapeMenuButton", self)

		self.btnDisconnect:SetText("#disconnect")
		self.btnDisconnect:SetFont(font_regular)
		self.btnDisconnect:SizeToContents()

		self.btnDisconnect.DoClick = function()
			RunConsoleCommand("disconnect")
		end

	self.btnCommands = vgui.Create("FMEscapeMenuButton", self)

		self.btnCommands:SetText("Commands")
		self.btnCommands:SetFont(font_regular)
		self.btnCommands:SizeToContents()

		self.btnCommands.DoClick = function(this)
			if this.isactive then
				this:Deactivate()
				self.infobox:SetVisible(false)
			else
				this:Activate()
				self.infobox:OpenCommands()
			end

		end

	self.btnServers = vgui.Create("FMEscapeMenuButton", self)

		self.btnServers:SetText("Servers")
		self.btnServers:SetFont(font_regular)
		self.btnServers:SizeToContents()

		self.btnServers.DoClick = function(this)
			if this.isactive then
				this:Deactivate()
				self.infobox:SetVisible(false)
			else
				this:Activate()
				self.infobox:OpenServers()
			end

		end

	self.btnForums = vgui.Create("FMEscapeMenuButton", self)

		self.btnForums:SetText("Forums")
		self.btnForums:SetFont(font_regular)
		self.btnForums:SizeToContents()

		self.btnForums.DoClick = function()
			gui.OpenURL("https://devinity.org/forums/flood/")
		end

	self.btnRules = vgui.Create("FMEscapeMenuButton", self)
		self.btnRules:SetText("Rules")
		self.btnRules:SetFont(font_regular)
		self.btnRules:SizeToContents()
		self.btnRules.DoClick = function(this)

			if this.isactive then
				this:Deactivate()
				self.infobox:SetVisible(false)
			else
				this:Activate()
				self.infobox:OpenRules()
			end

		end

	self.btnHelp = vgui.Create("FMEscapeMenuButton", self)

		self.btnHelp:SetText("Help")
		self.btnHelp:SetFont(font_regular)
		self.btnHelp:SizeToContents()

		self.btnHelp.DoClick = function(this)
			if this.isactive then
				this:Deactivate()
				self.infobox:SetVisible(false)
			else
				this:Activate()
				self.infobox:OpenHelp()
			end

		end

	self.btnResume = vgui.Create("FMEscapeMenuButton", self)

		self.btnResume:SetText("Play!")

		self.btnResume:SetFont(font_regular)

		self.btnResume:SizeToContents()

		self.btnResume.DoClick = function()

			self:OnClose()

			self:SetVisible(false)

		end

	self.btnOriginalMenu = vgui.Create("FMEscapeMenuButton", self)

		self.btnOriginalMenu:SetText("#back_to_main_menu")

		self.btnOriginalMenu:SetFont(font_smaller)

		self.btnOriginalMenu:SizeToContents()

		self.btnOriginalMenu.DoClick = function()

			FMBypassEscapeMenu(function()

				gui.ActivateGameUI()

			end)

			self:OnClose()

			self:SetVisible(false)

		end

end

function PANEL:ReclaimFocus()

	self.inputfocus:RequestFocus()

end

function PANEL:OpenTab(tab)

	for _, pnl in pairs(self:GetChildren()) do

		if pnl:GetName() == "FMEscapeMenuButton" and pnl:GetText():lower() == tab:lower() then

			if not pnl.isactive then

				pnl:DoClick()

			end

			break

		end

	end

end

function PANEL:Open()

	self.hasReleasedEscape = not input.IsKeyDown(KEY_ESCAPE)

	self:SetVisible(true)

	self:MakePopup()

end

function PANEL:OnClose()

	hook.Run("FMEscapeMenuClose", self)

end

function PANEL:OnKeyCodeReleased(key)

	if key == KEY_ESCAPE then

		if not self.hasReleasedEscape then

			self.hasReleasedEscape = true

		else

			self:OnClose()

			self:SetVisible(false)

		end

	end

end

function PANEL:PerformLayout(w, h)

	self.newsbox:SetSize(w / 4, h / 3)
	self.newsbox:AlignTop(50)
	self.newsbox:AlignRight(50)

	self.playerbox:SetPos(50, 50)
	self.playerbox:SetWide(h / 2.5) -- Base this on height since it's more tied to font size which is based on height

	self.infobox:SetSize(w / 3, w / 3)
	self.infobox:SetPos(0,50)
	self.infobox:CenterHorizontal()
	self.infobox:CenterVertical()

	self.btnOriginalMenu:SetPos(30, 0)
	self.btnOriginalMenu:AlignBottom(30, 30)

	self.btnDisconnect:SetPos(50)
	self.btnDisconnect:MoveAbove(self.btnOriginalMenu, 30)

	self.btnCommands:SetPos(50, 0)
	self.btnCommands:MoveAbove(self.btnDisconnect, 0)

	self.btnServers:SetPos(50, 0)
	self.btnServers:MoveAbove(self.btnCommands, 0)

	self.btnForums:SetPos(50, 0)
	self.btnForums:MoveAbove(self.btnServers, 0)

	self.btnRules:SetPos(50, 0)
	self.btnRules:MoveAbove(self.btnForums, 0)

	self.btnHelp:SetPos(50, 0)
	self.btnHelp:MoveAbove(self.btnRules, 0)

	self.btnResume:SetPos(50, 0)
	self.btnResume:MoveAbove(self.btnHelp, 0)

end



function PANEL:Paint(w, h)

	if not IsValid(self.btnResume) then return end

	DrawBlurRect(self, 0, 0, w, h, 3)

	surface.SetDrawColor(Color(0, 0, 0, 150))

	surface.DrawRect(0, 0, w, h)

	local logow = math.Round(w / 6 / 4) * 4

	local logoh = logow / 4

	local logox, logoy = self.btnResume:LocalToScreen(0, -logoh - 5)

	surface.SetMaterial(getLogoMaterial(logow))

	surface.SetDrawColor(color_white)

	surface.DrawTexturedRect(logox, logoy, logow, logoh)

end

vgui.Register("FMEscapeMenu", PANEL, "EditablePanel")