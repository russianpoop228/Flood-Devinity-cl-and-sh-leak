ENT.Type      = "anim"
ENT.Base      = "base_gmodentity"
ENT.PrintName = "Sledgehammer"

function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"HasHit")
end
