ENT.Type      = "anim"
ENT.Author    = "Donkie"
ENT.PrintName = "Cannon"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "EscapeVelocity")
	self:NetworkVar("Int", 1, "Balls")
	self:NetworkVar("Int", 2, "MaxBalls")
	self:NetworkVar("Entity", 0, "InternalFMOwner")
	self:NetworkVar("Entity", 1, "Possessor")
	self:NetworkVar("Bool", 0, "PlayFuseSound")
end
