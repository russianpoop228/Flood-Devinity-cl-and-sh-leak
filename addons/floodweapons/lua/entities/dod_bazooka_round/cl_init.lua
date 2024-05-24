ENT.Spawnable			= false
ENT.AdminSpawnable		= false

include("shared.lua")

function ENT:Initialize()
	self.emitter = ParticleEmitter( self:GetPos() )
end

function ENT:Think()

	self.emitter:SetPos(self:GetPos())
	--local vel = -self:GetAngles():Forward() Not Needed
	if not (self:GetVelocity() == Vector(0, 0, 0)) then
		local anglechange=self:GetVelocity()
		self:SetAngles( anglechange:Angle() )
	end

	for i=1,math.ceil(3 * QUALITY) do
		local part = self.emitter:Add( "particle/smokesprites_000" .. math.random(1,6), self:GetPos() + self:GetAngles():Forward() * math.random(-50,0) )
		if part then
			--part:SetVelocity( vel * 700 + VectorRand() * 50 ) Not Needed
			part:SetLifeTime(0)
			part:SetDieTime(math.Rand(2.5,5))
			part:SetStartAlpha(100)
			part:SetEndAlpha(0)
			part:SetStartSize(12)
			part:SetEndSize(36)
			part:SetAirResistance(0)
			part:SetColor(50,50,50,255)
		end
	end
end

function ENT:Initialize()
	self.emitter = ParticleEmitter( self:GetPos() )
end
