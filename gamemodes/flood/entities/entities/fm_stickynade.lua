
AddCSLuaFile()

local penetrate = true
local ignitechance = 30
local burntime = 10
local explodedmg = 30
local radius = 250
local radiussqr = radius * radius

ENT.Type = "anim"
ENT.Base = "fm_grenadebase"
ENT.PrintName = "Sticky Grenade"
ENT.Model = Model("models/weapons/tfa_nmrih/w_exp_tnt.mdl")

game.AddParticles("particles/nmrih_gas.pcf")
game.AddParticles("particles/nmrih_tnt.pcf")

PrecacheParticleSystem("nmrih_tnt_sparks")
PrecacheParticleSystem("explosion_tnt_1")

function ENT:Initialize()
	self.BaseClass.Initialize(self)

	self:EmitSound("Weapon_TNT.Spark_Loop2")

	local attid = self:LookupAttachment("particle")
	if not attid then return end

	ParticleEffectAttach("nmrih_tnt_sparks", PATTACH_POINT_FOLLOW, self, attid)
end

function ENT:Think()
	self.BaseClass.Think(self)
	if SERVER then
		if not self.watertimerstarted and self:WaterLevel() > 0 then
			self.watertimerstarted = true
			timer.Create("underwatertick" .. self:EntIndex(), 1.5, 1, function()
				if not IsValid(self) or self.stickied then return end

				self:Remove()
			end)
		end
	end
end

function ENT:PhysicsCollide(data)
	if self.stickied then return end
	self.stickied = true

	timer.Simple(0, function()
		self:SetMoveType(MOVETYPE_NONE)

		self:SetPos(data.HitPos - data.HitNormal * 1)

		local ang = data.HitNormal:Angle()
		ang:RotateAroundAxis(ang:Right(), 90)
		ang:RotateAroundAxis(data.HitNormal, math.random(-180,180))

		self:SetAngles(ang)

		if IsValid(data.HitEntity) then
			self:SetParent(data.HitEntity)
		end
	end)
end

function ENT:Explode(tr)
	ParticleEffect("explosion_tnt_1", self:GetPos(), Angle(0,0,0), self)

	self:StopSound("Weapon_TNT.Spark_Loop2")

	if SERVER then
		self:SetNoDraw(true)
		self:SetSolid(SOLID_NONE)

		-- pull out of the surface
		if tr.Fraction != 1.0 then
			self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
		end


		self:EmitSound("Weapon_TNT.Explode")

		local dmginfo = DamageInfo()
		dmginfo:SetAttacker(self:GetThrower())
		dmginfo:SetInflictor(self)
		dmginfo:SetDamagePosition(self:GetPos())
		dmginfo:SetDamageType(DMG_BLAST)

		--Ignition
		local damageapplied = 0
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

			local distfrac = (radiussqr - self:GetPos():DistToSqr(v:GetPos())) / radiussqr
			local dmg = math.Round(distfrac * explodedmg)
			dmginfo:SetDamage(dmg)
			damageapplied = damageapplied + dmg

			v:AddFMDamage(dmginfo)
		end

		hook.Run("FMPlayerDamage", self:GetThrower(), damageapplied)

		self:Remove()
	end
end
