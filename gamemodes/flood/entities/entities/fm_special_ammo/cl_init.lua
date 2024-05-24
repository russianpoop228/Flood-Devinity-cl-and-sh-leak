include("shared.lua")

net.Receive("FMSpecialAmmoPile", function()
	local healer = net.ReadEntity()
	if not IsValid(healer) then return end

	local target = net.ReadEntity()

	healer:DoEffect(target)
end)

function ENT:DoEffect(target)
	if not IsValid(self.emitter) then
		self.emitter = ParticleEmitter(self:GetPos())
	end

	self.emitter:SetPos(self:GetPos())

	-- Sparks from the generator
	for _ = 1, math.ceil(math.Rand(20, 30) * QUALITY) do
		local part = self.emitter:Add("effects/spark", self:GetPos() + Vector(0, 0, 5) + VectorRand() * 10)
		if part then
			part:SetVelocity(Vector(0, 0, 200) + VectorRand() * 50)
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

	-- Plus sign effect
	local size = 32
	for _ = 1, math.ceil(math.Rand(2, 5) * QUALITY) do
		local part = self.emitter:Add("icon32/bullet", target:GetPos() + Vector(math.Rand(-size, size), math.Rand(-size, size), 50))
		if part then
			part:SetVelocity(Vector(0, 0, 10))
			part:SetLifeTime(0)
			part:SetDieTime(1.5)
			part:SetStartAlpha(255)
			part:SetEndAlpha(0)
			part:SetStartSize(5)
			part:SetEndSize(5)
			part:SetRoll(math.Rand(0, 360))
			part:SetGravity(Vector(0, 0, 20))
			part:SetColor(120, 120, 60)
			part:SetAirResistance(0)
		end
	end
end
