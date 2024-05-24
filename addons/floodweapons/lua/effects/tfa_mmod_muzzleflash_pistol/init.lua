local ang
EFFECT.ParticleName1 = "hl2mmod_muzzleflash_pistol"
EFFECT.ParticleName2 = "hl2mmod_muzzleflash_pistol_alt"

function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	if not IsValid(self.WeaponEnt) then return end
	self.Attachment = data:GetAttachment()
	self.Position = self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)
	
	local particlename = self.ParticleName1
	local randomnum = math.random(1,2)
	
	if randomnum == 1 then
		particlename = self.ParticleName1
	else
		particlename = self.ParticleName2
	end
	


	self.Forward = self.Forward or data:GetNormal()
	self.Angle = self.Forward:Angle()
	local dlight = DynamicLight(self.WeaponEnt:EntIndex())

	if (dlight) then
		dlight.pos = self.Position + self.Angle:Up() * 3 + self.Angle:Right() * -2
		dlight.r = 255
		dlight.g = 192
		dlight.b = 64
		dlight.brightness = 5
		dlight.Size = math.Rand(32, 64)
		dlight.Decay = math.Rand(32, 64) / 0.05
		dlight.DieTime = CurTime() + 0.05
	end

	local pcf = CreateParticleSystem(self.WeaponEnt, particlename, PATTACH_POINT_FOLLOW, self.Attachment)
	if IsValid(pcf) then
		pcf:StartEmission()
	end
	timer.Simple(3.0, function()
		if IsValid(pcf) then
			pcf:StopEmissionAndDestroyImmediately()
		end
	end)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end