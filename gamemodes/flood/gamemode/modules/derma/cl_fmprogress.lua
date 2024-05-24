
--[[
FMProgress
A progress bar.
]]

PANEL = {}
AccessorFunc(PANEL, "m_value", "Value", FORCE_NUMBER)
AccessorFunc(PANEL, "m_max", "Max", FORCE_NUMBER)
AccessorFunc(PANEL, "m_painttext", "PaintText", FORCE_BOOL)
function PANEL:Init()
	self.m_value = 0
	self.m_max = 0
	self.m_painttext = true

	self:SetTall(16)

	self.progwide = 0
end
local barcol = HSVToColor(86, 0.63, 0.50)
function PANEL:Paint(w,h)
	local tall = h-14
	surface.SetDrawColor(FMCOLORS.bg)
	surface.DrawRect(0,h-tall,w,tall)

	local width
	if self:GetMax() <= 0 then width = 0 else width = math.Clamp((self.progwide / self:GetMax()) * w, 0, w) end

	surface.SetDrawColor(barcol)
	surface.DrawRect(0,h-tall,width,tall)

	if self:GetPaintText() then
		draw.SimpleText(string.format("%i/%i", self:GetValue(), self:GetMax()), "DefaultSmall", w/2, 1, Color(100,100,100,255), TEXT_ALIGN_CENTER, 0)
	end
end
function PANEL:SetValue(x)
	if x == self:GetValue() then return end

	StartAnim(self:GetValue(), x, 2, function(tall)
		self.progwide = tall
	end)

	self.m_value = x
end
vgui.Register("FMProgress", PANEL, "Panel")
