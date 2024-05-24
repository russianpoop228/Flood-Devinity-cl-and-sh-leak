ENT.Type = "anim"
ENT.Author = "Donkie"
ENT.PrintName = "Boat motor"

function ENT:SetupDataTables()
	self:NetworkVar("Entity",0,"Possessor")
	self:NetworkVar("Int",0,"Throttle")
end
