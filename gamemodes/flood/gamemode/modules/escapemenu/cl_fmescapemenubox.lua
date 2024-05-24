
-- FMEscapeMenuBox
-- Base for all "boxes" in the escape menu

local font_small = "FMEscapeMenuSmall"
local color_text = Color(220, 220, 220)

local PANEL = {}
function PANEL:Init()
	self.lbl = vgui.Create("DLabel", self)
		self.lbl:Dock(TOP)
		self.lbl:SetFont(font_small)
		self.lbl:SetTextColor(color_text)
end

function PANEL:SetText(txt)
	self.lbl:SetText(txt)
	self.lbl:SizeToContents()
	self:InvalidateLayout()
end

function PANEL:PerformLayout(w, h)
	self:DockPadding(0, self.lbl:GetTall(), 0, 0)
end

function PANEL:Paint(w, h)
	local bgy = self.lbl:GetTall()
	surface.SetDrawColor(Color(0, 0, 0, 150))
	surface.DrawRect(0, bgy, w, h - bgy)
end
vgui.Register("FMEscapeMenuBox", PANEL, "Panel")
