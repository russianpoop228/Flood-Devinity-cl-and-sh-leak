
--[[
DLabelWordWrap
A label with wordwrapping
Deprecated, use DLabelWordWrap2
]]
PANEL = {}
AccessorFunc(PANEL, "m_maxwide", "MaxWidth", FORCE_NUMBER)
function PANEL:Init()
	self.m_maxwide = 100
end
function PANEL:SetText(txt)

	surface.SetFont(self:GetFont() or "DermaDefault")
	txt = string.WordWrap(txt, self:GetMaxWidth())

	DLabel.SetText(self, txt)
end

vgui.Register("DLabelWordWrap", PANEL, "DLabel")

--[[
DLabelWordWrap2
A label with wordwrapping
]]
PANEL = {}
function PANEL:Init()
	self.lbl = vgui.Create("DLabel", self)
end
function PANEL:SetText(txt)
	self.txt = txt
	self.oldwidth = nil
	self:InvalidateLayout()
end
function PANEL:SetFont(font)
	self.oldwidth = nil
	self.lbl:SetFont(font)
end
function PANEL:SetTextColor(...)
	self.lbl:SetTextColor(...)
end
function PANEL:SetDark(...)
	self.lbl:SetDark(...)
end
function PANEL:GetFont()
	return self.lbl:GetFont() or "DermaDefault"
end
function PANEL:GetText()
	return self.txt
end
function PANEL:GetWrappedText(w)
	local text = string.Wrap(self:GetFont(), self:GetText(), w)
	return table.concat(text, "\n")
end
function PANEL:PerformLayout(w, h)
	if not IsValid(self.lbl) then return end
	if not self.txt then return end

	if not self.oldwidth or self.oldwidth != w then -- Update word wrapping if needed
		self.lbl:SetText(self:GetWrappedText(w))
		self.lbl:SizeToContents()
		self.lbl:InvalidateLayout(true) -- Lol, this is needed to make sure height is properly updated
		self.lbl:SizeToContentsY()

		local lbltall = self.lbl:GetTall()
		if h != lbltall then
			self:SetTall(lbltall) -- Update height if needed
		end

		self.oldwidth = w
	end
end
vgui.Register("DLabelWordWrap2", PANEL, "Panel")
