
--[[
FMWebImage
A image from de webs
]]

PANEL = {}
function PANEL:Init()
	self:SetKeyboardInputEnabled(false)
	self:SetMouseInputEnabled(false)
end
function PANEL:SetURL(url)
	self:SetHTML("<img src='" .. url .. "' style='max-width:100%;max-height:100%;'>")
end
derma.DefineControl("FMWebImage", "", PANEL, "Awesomium")
