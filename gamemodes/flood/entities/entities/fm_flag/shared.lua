ENT.Type      = "anim"
ENT.Author    = "Donkie"
ENT.PrintName = "Flag"

function ENT:SetupDataTables()
	self:NetworkVar("Vector",0,"FlagColor")
	self:NetworkVar("String",0,"FlagMaterial")
	self:NetworkVar("String",1,"FlagText")
	self:NetworkVar("Int",0,"WindAngle")
	self:NetworkVar("Int",1,"WindStrength")
	self:NetworkVar("Entity",0,"Player")
end
