
-- FMEscapeMenuButton
-- Stylized text button for the escape menu

local sound_button_hover = Sound("fm/button_very_bright_click.wav")
local color_text = Color(220, 220, 220)

local PANEL = {}
function PANEL:Init()
	self:SetTextColor(color_text)
	self.isactive = false
end

function PANEL:Deactivate()
	self.isactive = false
	self:SetTextColor(color_text)
end

function PANEL:Activate()
	for _, pnl in pairs(self:GetParent():GetChildren()) do
		if pnl:GetName() == "FMEscapeMenuButton" then
			pnl:Deactivate()
		end
	end

	self.isactive = true
	self:SetTextColor(FMCOLORS.txt)
end

function PANEL:OnCursorEntered()
	surface.PlaySound(sound_button_hover)
	if not self.isactive then
		self:SetTextColor(Color(255, 255, 255))
	end
end

function PANEL:OnCursorExited()
	if not self.isactive then
		self:SetTextColor(color_text)
	end
end

function PANEL:Paint(w, h)
end
vgui.Register("FMEscapeMenuButton", PANEL, "DButton")
