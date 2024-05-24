
AddCSLuaFile()

ENT.Type         = "anim"
ENT.Base         = "fm_grenadebase"
ENT.PrintName    = "Snowball"
ENT.Model        = Model("models/weapons/w_snowball_thrown.mdl")
ENT.ExplodeOnHit = true

function ENT:Initialize()
	self.BaseClass.Initialize(self)

	if SERVER then
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:EnableGravity(true);
			phys:SetBuoyancyRatio(0);
		end

		self.Trail = util.SpriteTrail(self, 0, Color(255, 255, 255), false, 15, 1, 2, 1 / (15 + 1) * 0.5, "trails/laser.vmt")
	end
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
			effectdata:SetScale(1.5)
		self:EmitSound("hit.wav")
		util.Effect("WheelDust", effectdata)
		util.Effect("GlassImpact", effectdata)

		self:Remove()
	end
end