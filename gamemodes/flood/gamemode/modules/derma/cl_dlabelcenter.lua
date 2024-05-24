--[[
DLabelCenter
A label which always centers the text
Deprecated, just use SetContentAlignment(5) instead
]]
PANEL = {}
AccessorFunc(PANEL, "m_centery", "CenterY", FORCE_BOOL)
function PANEL:Init()
	self.txt = vgui.Create("DLabel", self)
	self:SetCenterY(false)
end
function PANEL:SetFont(f)
	self.txt:SetFont(f)
end
function PANEL:SetTextColor(f)
	self.txt:SetTextColor(f)
end
function PANEL:SetBright(f)
	self.txt:SetBright(f)
end
function PANEL:SetDark(f)
	self.txt:SetDark(f)
end
function PANEL:SizeToContents()
	self.txt:SizeToContents()

	if not self.m_centery then
		self:SetTall(self.txt:GetTall())
	end
end
function PANEL:GetText()
	return self.txt:GetText()
end
function PANEL:SetText(f)
	self.txt:SetText(f)
	self.txt:SizeToContents()
	self:InvalidateLayout()
end
function PANEL:PerformLayout()
	local w, h = self:GetSize()
	local tw, th = self.txt:GetSize()

	local y = 0
	if self.m_centery then
		y = h / 2 - th / 2
	end

	self.txt:SetPos(w / 2 - tw / 2, y)
end
function PANEL:Paint(w,h)
end
vgui.Register("DLabelCenter", PANEL, "Panel")
