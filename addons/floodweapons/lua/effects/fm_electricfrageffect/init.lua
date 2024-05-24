function EFFECT:Init(data)
	local pos = data:GetOrigin() + Vector(0, 0, 2)

	self.Start = pos
	self.StartTime = CurTime()

	self.Alpha = 255
	self.Life = 0

	sound.Play("ambient/levels/labs/electric_explosion"..math.random(1,5)..".wav", pos, 70, math.random(120, 130))

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(32, 48)

	for i=1, 50 do
		local particle = emitter:Add("particles/fire_glow", pos)
		particle:SetDieTime(1.5)
		particle:SetColor(235,210,160)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(1)
		particle:SetEndSize(10)
		particle:SetVelocity(VectorRand():GetNormal() * 350)
		particle:SetGravity(Vector(0,0,-500))
		particle:SetCollide(true)
		particle:SetBounce(0.5)
	end

	for i=1, 16 do
		local particle = emitter:Add("effects/fire_cloud1", pos)
		particle:SetDieTime(0.5)
		particle:SetColor(235,210,160)
		particle:SetStartAlpha(178)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(200)
		particle:SetVelocity(VectorRand():GetNormal() * 150)
	end

	for i=1, 16 do
		local particle = emitter:Add("sprites/flamelet"..math.random(1, 4), pos)
		particle:SetVelocity(VectorRand():GetNormal() * 110)
		particle:SetDieTime(math.Rand(0.5, 0.6))
		particle:SetStartAlpha(220)
		particle:SetEndAlpha(0)
		particle:SetStartSize(48)
		particle:SetEndSize(1)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetColor(255, 230, 150)
		particle:SetRollDelta(math.Rand(-3, 3))
	end

	for i=1, 50 do
		local particle = emitter:Add("effects/fire_embers"..math.random(1, 3), pos)
		particle:SetVelocity(VectorRand():GetNormal() * 300)
		particle:SetDieTime(math.Rand(1.25, 1.5))
		particle:SetStartAlpha(130)
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(15, 19))
		particle:SetEndSize(3)
		particle:SetRoll(math.Rand(0, 359))
		particle:SetRollDelta(math.Rand(-3, 3))
		particle:SetAirResistance(50)
		particle:SetCollide(true)
		particle:SetBounce(0.3)
		particle:SetGravity(Vector(0,0,-400))
	end
		
	for i=1, 5 do
		local particle = emitter:Add("particle/smokesprites_000"..math.random(1, 5), pos)
		particle:SetVelocity(VectorRand():GetNormal() * 100)
		particle:SetDieTime(0.6)
		particle:SetStartAlpha(225)
		particle:SetEndAlpha(0)
		particle:SetStartSize(1)
		particle:SetEndSize(300)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetColor(255, 230, 150)
		particle:SetRollDelta(math.Rand(-3, 3))
	end

	emitter:Finish() emitter = nil collectgarbage("step", 64)
end

function EFFECT:Think()
	self.Life = self.Life + FrameTime() * 4
	self.Alpha = 255 * (1 - self.Life)
	return self.Life < 1
end