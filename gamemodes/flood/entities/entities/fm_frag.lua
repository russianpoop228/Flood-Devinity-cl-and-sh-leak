
AddCSLuaFile()

local penetrate = true
local ignitechance = 30
local burntime = 10
local explodedmg = 20
local radius = 180
local radiussqr = radius * radius

ENT.Type = "anim"
ENT.Base = "fm_grenadebase"
ENT.PrintName = "Frag Grenade"
ENT.Model = Model("models/weapons/w_eq_fraggrenade_thrown.mdl")

function ENT:Initialize()
	self.BaseClass.Initialize(self)
end

function ENT:Explode(tr)
	if SERVER then
		self:SetNoDraw(true)
		self:SetSolid(SOLID_NONE)

		-- pull out of the surface
		if tr.Fraction != 1.0 then
			self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
		end

		local effectdata = EffectData()
			effectdata:SetStart(self:GetPos())
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetScale(1)
		util.Effect("Explosion", effectdata)

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
