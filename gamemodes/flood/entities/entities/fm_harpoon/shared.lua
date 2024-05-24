ENT.Type = "anim"
ENT.Author = "Donkie"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PrintName = "Harpoon"

function ENT:SetupDataTables()
	self:NetworkVar("Entity",0,"Owner")
	self:NetworkVar("Bool", 0, "Anchored")
end
