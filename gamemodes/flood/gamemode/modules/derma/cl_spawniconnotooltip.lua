
--[[
SpawnIconNoTooltip
]]

PANEL = {}
function PANEL:Init()
	//self:SetCursor("arrow")
end
function PANEL:PaintOver(w, h)
end
function PANEL:PerformLayout()
	self.Icon:StretchToParent( 0, 0, 0, 0 )
	return false
end
function PANEL:SetModel(mdl, iSkin, BodyGorups)
	if (!mdl) then debug.Trace() return end

	self:SetModelName( mdl )
	self:SetSkinID( iSkin )

	if ( tostring(BodyGorups):len() != 9 ) then
		BodyGorups = "000000000"
	end

	self.m_strBodyGroups = BodyGorups;

	self.Icon:SetModel( mdl, iSkin, BodyGorups )
end
vgui.Register("SpawnIconNoTooltip", PANEL, "SpawnIcon")
