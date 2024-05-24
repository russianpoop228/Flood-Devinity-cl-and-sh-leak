
AddCSLuaFile()

local penetrate = true
local ignitechance = 80
local burntime = 10
local radius = 180

ENT.Type = "anim"
ENT.Base = "fm_grenadebase"
ENT.PrintName = "Incendiary Grenade"
ENT.Model = Model("models/weapons/tfa_nmrih/w_exp_molotov.mdl")

game.AddParticles("particles/nmrih_gas.pcf")
game.AddParticles("particles/nmrih_tnt.pcf")

PrecacheParticleSystem("nmrih_molotov_explosion")
PrecacheParticleSystem("nmrih_molotov_rag_fire")

function ENT:Initialize()
	self.BaseClass.Initialize(self)

	if CLIENT then
		local attid = self:LookupAttachment("particle")
		if not attid then return end

		ParticleEffectAttach("nmrih_molotov_rag_fire", PATTACH_POINT_FOLLOW, self, attid)
	end
end

function ENT:PhysicsCollide()
	self:SetDetonateExact()
end

function ENT:Think()
	self.BaseClass.Think(self)
	if SERVER then
		if self:WaterLevel() > 0 then self:Remove() end
	end
end

function ENT:Explode(tr)
	ParticleEffect("nmrih_molotov_explosion", (tr.HitPos or self:GetPos()) - Vector(0,0,15), Angle(0,0,0), self)

	if SERVER then
		self:SetNoDraw(true)
		self:SetSolid(SOLID_NONE)

		-- pull out of the surface
		if tr.Fraction != 1.0 then
			self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
		end

		local pos = self:GetPos()

		if util.PointContents(pos) == CONTENTS_WATER then
			self:Remove()
			return
		end

		self:EmitSound("Weapon_Molotov.Explode")

		--Ignition
		for k,v in pairs(ents.FindInSphere(self:GetPos(), radius)) do
			if not v:IsDestroyable() then continue end
			if not hook.Run("FMPlayerCanDamage", self:GetThrower(), v) then continue end

			if not penetrate then
				trdata.endpos = v:GetPos()
				trdata.filter = {v, self}
				if util.TraceLine(trdata).Hit then continue end
			end

			if math.random(1,100) <= ignitechance then
				v:FMIgnite(self:GetThrower(), burntime)
			end
		end

		self:Remove()
	end
end
