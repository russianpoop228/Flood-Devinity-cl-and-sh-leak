
local BLASTRADIUS = MORTAR_BLASTRADIUS or 200
local TIMESPAN = MORTAR_TIMESPAN or 7

function EFFECT:Init( data )

	self.starttime = CurTime()
	self.lifespan = TIMESPAN-- data:GetScale()
	self.radius = BLASTRADIUS-- data:GetRadius()
	self.pos = data:GetOrigin()

	self.emitter = ParticleEmitter(self.pos)
	self.obj = ClientsideModel("models/Combine_Helicopter/helicopter_bomb01.mdl", RENDERGROUP_TRANSLUCENT)
	self.obj:SetNoDraw(true)
	self.obj:SetModelScale(0.5,0)
end

local function RemapValClamped( val, a, b, c, d )
	local cval = (val - a) / (b - a)
	cval = math.Clamp(cval, 0, 1)
	return c + (d - c) * cval
end

local function Bias(x, amt)
	local lastamt = -1
	local lastexponent = 0

	if amt != -1 then
		lastexponent = math.log(amt) * -1.4427
	end

	return math.pow( x, lastexponent )
end

local function Gain(x, amt)
	if x < 0.5 then
		return 0.5 * Bias(2 * x, 1-amt)
	else
		return 1 - 0.5 * Bias(2 - 2 * x, 1-amt)
	end
end

function EFFECT:AddParticles( flPerc, exploding )
	local radius = exploding and (48 * flPerc) or (self.radius * 0.25 * flPerc)

	local val = RemapValClamped(CurTime(), self.starttime, self.starttime + self.lifespan, 0, 1)

	local pos = Vector(math.Rand(-1,1), math.Rand(-1,1), 0):GetNormal() * math.Rand(-self.radius,self.radius) + Vector(0, 0, math.Rand(-8, 8)) + self.pos

	local part = self.emitter:Add("effects/spark", pos)
	if not part then return end

	if exploding then
		part:SetVelocity((VectorRand() + Vector(0,0,1)) * 750 * flPerc)
		part:SetStartSize(math.Rand(2,4) * flPerc)
		part:SetDieTime(math.Rand(0.25,0.5))
	else
		part:SetVelocity(Vector(math.Rand(-1,1), math.Rand(-1,1), 0):GetNormal() * 4 + Vector(0, 0, math.Rand(32,256) * Bias(val, 0.25)))
		part:SetStartSize(math.Rand(4,8) * flPerc)
		part:SetDieTime(math.Rand(0.5,1))
	end

	part:SetRoll(math.random(0,360))

	local a = 255 * flPerc

	part:SetRollDelta(math.Rand(-8 * flPerc, 8 * flPerc))
	part:SetStartAlpha(a)
	part:SetEndAlpha(0)
	part:SetEndSize(0)
	part:SetLifeTime(0)

end

function EFFECT:GetStartPerc()
	local val = RemapValClamped(CurTime(), self.starttime, self.starttime + self.lifespan, 0, 1)
	return Gain(val, 0.2)
end

function EFFECT:GetEndPerc()
	local val = RemapValClamped(CurTime(), self.starttime + self.lifespan, self.starttime + self.lifespan + 1, 1, 0)
	return Gain(val, 0.75)
end

local lastblast = 0
hook.Add("PostRenderVGUI", "DrawBlueEffect", function()
	local a = math.Clamp((lastblast + 1) - CurTime(), 0, 1) * 150
	if a > 0 then
		surface.SetDrawColor(Color(42,190,255,a))
		surface.DrawRect(0,0,ScrW(),ScrH())
	end
end)

function EFFECT:Think()

	local dist = LocalPlayer():GetPos():Distance(self.pos)
	local distmax = BLASTRADIUS
	local volume = math.Clamp(distmax * 3 - dist, 0, distmax * 2) / (distmax * 2)

	local perc
	local ending
	if CurTime() < (self.starttime + self.lifespan) then
		perc = self:GetStartPerc()
		ending = false
	else
		perc = self:GetEndPerc()
		ending = true

		if not self.pboom then
			self.pboom = true

			if volume > 0 then
				EmitSound(string.format("weapons/mortar/mortar_explode%i.wav", math.random(1,3)), self.pos, 0, CHAN_AUTO, volume, 100, 0, 100)
			end

			if dist < distmax then
				util.ScreenShake( self.pos, 5, 5, 2, 30 )
				lastblast = CurTime()
			end
		end
	end

	if not self.pinc and CurTime() >= (self.starttime + self.lifespan - 0.957) then
		self.pinc = true

		if volume > 0 then
			EmitSound("weapons/mortar/mortar_shell_incomming1.wav", self.pos, 0, CHAN_AUTO, volume, 100, 0, 100)
		end
	end

	self.perc = perc
	self.ending = ending

	self:AddParticles(perc, ending)

	if ending and perc == 0 then
		return false
	end

	return true
end

local mat = Material("effects/combinemuzzle2_nocull")
local lasermat = Material("effects/laser1")
function EFFECT:Render()
	if not self.perc then return end

	self:SetRenderBounds(Vector(-50,-50,0),Vector(50,50,100000))

	local ending = self.ending
	local a = self.perc * 255

	local col = Color(255,255,255,a)
	render.SetMaterial(mat)
	render.DrawQuadEasy(self.pos, Vector(0,0,1), self.radius * 6, self.radius * 6, col, 0)

	local col = Color(255,195,130,a)
	local dir = Vector(1,0,30):GetNormal()
	render.SetMaterial(lasermat)
	render.DrawBeam(self.pos, self.pos + dir * 10000, self.radius * self.perc * 5, 0, 1, col)

	if not ending then
		self.obj:SetRenderOrigin(self.pos + dir * (Bias(1-self.perc,0.8) * 1000 - 400))
		render.SetColorModulation(150,0,0)
		render.SetBlend((self.perc-0.5) * 0.6)
		self.obj:DrawModel()
		render.SetBlend(1)
		render.SetColorModulation(255,255,255)
	end
end
