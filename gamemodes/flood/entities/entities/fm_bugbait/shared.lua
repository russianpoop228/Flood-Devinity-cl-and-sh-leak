ENT.Type = "anim"
ENT.Author = "Donkie"
ENT.PrintName = "Bugbait"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Exploded")
end
