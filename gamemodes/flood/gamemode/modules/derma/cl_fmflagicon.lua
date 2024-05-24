
--[[
FMFlagIcon
A flag icon.
]]

PANEL = {}
function PANEL:Init()
	self:SetKeyboardInputEnabled(false)
	self:SetMouseInputEnabled(false)
	self:SetSize(16,11)
end
function PANEL:SetFlag(flagstr)
	if not flagstr then return end
	local url = string.format("http://devinity.org/silkflags/%s.png", string.lower(flagstr))
	self:OpenURL(url)
end
derma.DefineControl("FMFlagIcon", "", PANEL, "Awesomium")
