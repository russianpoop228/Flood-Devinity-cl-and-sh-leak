include("shared.lua")

local throwDuration = 1 -- Number of seconds the thrown gun will take to reach the target

net.Receive("FMSpecialGunCabinet", function()
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end

	local target = net.ReadEntity()
	if not IsValid(target) then return end

	local wepclass = net.ReadString()

	ent:DoEffect(target, wepclass)
end)

local gunThrows = {}
function ENT:DoEffect(target, wepclass)
	if not IsValid(self.emitter) then
		self.emitter = ParticleEmitter(self:GetPos())
	end

	self.emitter:SetPos(self:GetPos())

	-- Sparks from the generator
	for _ = 1, math.ceil(math.Rand(20, 30) * QUALITY) do
		local part = self.emitter:Add("effects/spark", self:GetPos() + Vector(0, 0, 90) + VectorRand() * 10)
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

	-- Gun throw effect
	local startloc = self:GetPos()

	local mdl = GetWeaponData(wepclass).model

	local gun = ClientsideModel(mdl, RENDERGROUP_BOTH)
	gun:SetPos(startloc)

	table.insert(gunThrows, {
		gun = gun,
		start = CurTime(),
		startloc = startloc,
		endloc = target:GetPos() + Vector(0, 0, 50),
		rotaxis = VectorRand()
	})
end

hook.Add("Think", "FMSpecialGunCabinet", function()
	for i = 1, #gunThrows do
		local guntbl = gunThrows[i]

		local dur = CurTime() - guntbl.start
		local frac = dur / throwDuration
		if frac > 1 then
			guntbl.gun:Remove()
			table.remove(gunThrows, i)
			i = i - 1
			return
		end

		local zplus = math.sin(frac * math.pi) * 60

		local pos = LerpVector(frac, guntbl.startloc, guntbl.endloc) + Vector(0, 0, zplus)
		local ang = Angle(0, 0, 0)
		ang:RotateAroundAxis(guntbl.rotaxis, dur * 500)

		guntbl.gun:SetPos(pos)
		guntbl.gun:SetAngles(ang)
	end
end)
