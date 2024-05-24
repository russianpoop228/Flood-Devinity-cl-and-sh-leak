
-- FMEscapeMenuPlayerBox
-- MenuBox containing the player information

local avatarSize = 80
local color_text = Color(220, 220, 220)

local font_small = "FMEscapeMenuSmall"
local font_mini_i = "FMEscapeMenuMiniItalic"

local PANEL = {}
function PANEL:Init()
	self:SetText("Hello")

	self.avatarcontainer = vgui.Create("Panel", self)
		self.avatarcontainer:Dock(TOP)
		self.avatarcontainer:SetTall(avatarSize)
		self.avatarcontainer:DockMargin(10, 10, 10, 10)

	self.avatar = vgui.Create("FMEscapeMenuAvatarImage", self.avatarcontainer)
		self.avatar:SetPlayer(LocalPlayer(), avatarSize)
		self.avatar:Dock(LEFT)
		self.avatar:SetWide(avatarSize)
		self.avatar:DockMargin(0, 0, 10, 0)

	self.nick = vgui.Create("DLabel", self.avatarcontainer)
		self.nick:Dock(TOP)
		self.nick:SetContentAlignment(1)
		self.nick:SetFont(font_small)
		self.nick:SetText(LocalPlayer():FilteredNick())
		self.nick:SetTextColor(color_text)
		self.nick:SizeToContentsX()

	self.desc = vgui.Create("DLabelWordWrap2", self.avatarcontainer)
		self.desc:Dock(TOP)
		self.desc:SetContentAlignment(7)
		self.desc:SetFont(font_mini_i)
		self.desc:SetText(LocalPlayer():GetCustomDescription() or "")
		self.desc:SetTextColor(Color(180, 180, 180))
		self.desc:SizeToContents()
end

function PANEL:PerformLayout(w, h)
	local _, conty = self.avatarcontainer:GetPos()
	local calctall = conty + self.avatarcontainer:GetTall() + 10
	if h != calctall then
		self:SetTall(calctall)
	end

	self.nick:SetTall(avatarSize / 2)
end

function PANEL:Think()
	if LocalPlayer():FilteredNick() != self.nick:GetText() then
		self.nick:SetText(LocalPlayer():FilteredNick())
		self.nick:SizeToContentsX()
	end

	if (LocalPlayer():GetCustomDescription() or "") != self.desc:GetText() then
		self.desc:SetText(LocalPlayer():GetCustomDescription() or "")
		self.desc:SizeToContents()
	end
end
vgui.Register("FMEscapeMenuPlayerBox", PANEL, "FMEscapeMenuBox")
