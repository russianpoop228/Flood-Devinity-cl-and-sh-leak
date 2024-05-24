include("shared.lua")

function ENT:Initialize()
	self.fakemdl = ClientsideModel(self.Model, RENDERGROUP_OPAQUE)
	self.fakemdl:SetNoDraw(true)
end

net.Receive("FMSpecialHealer", function()
	local healer = net.ReadEntity()
	if not IsValid(healer) then return end

	local targs = {}
	for i = 1, net.ReadUInt(8) do
		targs[i] = net.ReadEntity()
	end

	healer:DoEffect(targs)
end)

local function estimateSize(ent)
	local mn, mx = ent:GetRenderBounds()
	local size = 0
	size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
	size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
	-- size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) ) -- Don't care about z size

	return size
end

function ENT:DoEffect(targets)
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
	for _, targ in pairs(targets) do
		local size = estimateSize(targ) * 0.8

		for _ = 1, math.ceil(math.Rand(2, 5) * QUALITY) do
			local part = self.emitter:Add("icon32/plus", targ:GetPos() + Vector(math.Rand(-size, size), math.Rand(-size, size), 0))
			if part then
				part:SetVelocity(Vector(0, 0, 10))
				part:SetLifeTime(0)
				part:SetDieTime(1.5)
				part:SetStartAlpha(255)
				part:SetEndAlpha(0)
				part:SetStartSize(5)
				part:SetEndSize(5)
				part:SetGravity(Vector(0, 0, 20))
				part:SetColor(0, 200, 0)
				part:SetAirResistance(0)
			end
		end
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
