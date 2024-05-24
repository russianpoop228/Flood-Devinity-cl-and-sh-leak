
--[[
FMPanel
A normal panel with that little extra flood feeling to it.
Don't use this...
]]
PANEL = {}
function PANEL:Init()
	self:SetBackgroundColor(Color(230,230,230,255))
end
vgui.Register("FMPanel", PANEL, "DPanel")
