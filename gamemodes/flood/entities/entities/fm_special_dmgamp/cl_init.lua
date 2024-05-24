include("shared.lua")

function ENT:Initialize()
	self.fakemdl = ClientsideModel(self.Model, RENDERGROUP_OPAQUE)
	self.fakemdl:SetNoDraw(true)
end

function ENT:Think()
	if not self:GetNWBool("IsActive", false) then
		self.doneParticles = 0
		return
	end

	if not IsValid(self.emitter) then
		self.emitter = ParticleEmitter(self:GetPos())
	end

	self.emitter:SetPos(self:GetPos())

	local particlesToMake = self:GetNWInt("PCount", 0) - (self.doneParticles or 0)
	if particlesToMake > 0 then
		for _ = 1, particlesToMake do

			local part = self.emitter:Add("effects/spark", self:LocalToWorld(Vector(-35, 0, 45)))
			if part then
				part:SetVelocity(self:GetForward() * -200 + Vector(0, 0, 200) + VectorRand() * 50)
				part:SetLifeTime(0)
				part:SetDieTime(3)
				part:SetStartAlpha(255)
				part:SetEndAlpha(255)
				part:SetStartSize(3)
				part:SetEndSize(3)
				part:SetRoll(math.Rand(0, 360))
				part:SetRollDelta(1)
				part:SetGravity(Vector(0, 0, -300))
				part:SetAirResistance(0)
			end
		end

		self.doneParticles = self:GetNWInt("PCount", 0)
	end
end

function ENT:Draw()
	self.fakemdl:SetRenderAngles(self:GetAngles())
	if self:GetNWBool("IsActive") then
		self.fakemdl:SetRenderOrigin(self:GetPos() + VectorRand() * 0.5)
	else
		self.fakemdl:SetRenderOrigin(self:GetPos())
	end
	self.fakemdl:DrawModel()
end
