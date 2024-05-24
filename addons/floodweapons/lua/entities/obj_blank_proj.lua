AddCSLuaFile()
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

function ENT:Initialize()
if SERVER then
	self:SetModel( "models/roller.mdl" )
	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:PhysicsDestroy()
	SafeRemoveEntityDelayed(self,0)
		local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass( 1 )
		phys:EnableGravity( false )
		phys:EnableDrag( false )
		phys:Wake()
		phys:ApplyForceCenter(self:GetForward()*3500)
	else
		self:Remove()
	end
end
end
