
SWEP.Base                = "weapon_fmbase"

SWEP.DrawAmmo            = true
SWEP.DrawCrosshair       = true
SWEP.ViewModelFOV        = 50
SWEP.ViewModelFlip       = false
SWEP.CSMuzzleFlashes     = false

SWEP.HoldType            = ""
SWEP.UseHands            = true

SWEP.Primary.Ammo        = "357"
SWEP.Primary.Automatic   = false
SWEP.Primary.ClipSize    = -1
SWEP.Primary.DefaultClip = -1

SWEP.Primary.Cone        = 0
SWEP.Primary.Damage      = 0
SWEP.Primary.Delay       = 0
SWEP.Primary.EmptySound  = ""
SWEP.Primary.FireOnEmpty = false
SWEP.Primary.Force       = 5
SWEP.Primary.NumShots    = 1
SWEP.Primary.Sound       = ""
SWEP.Primary.Tracer      = 1
SWEP.Primary.TracerName  = nil

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetDeploySpeed(2)
end

function SWEP:FirePunch()
	local ang = self.Owner:EyeAngles()

	ang.p = ang.p + self:Rand("angp", -1, 1)
	ang.y = ang.y + self:Rand("angy", -1, 1)
	ang.r = 0

	self.Owner:SetEyeAngles(ang)

	self.Owner:ViewPunch(Angle(-8, self:Rand("pnch", -2, 2), 0))
end

function SWEP:GetBulletSpread()
	return Vector(self.Primary.Cone, self.Primary.Cone, 0)
end

function SWEP:GetPrimaryAttackActivity()
	return ACT_VM_PRIMARYATTACK
end

function SWEP:PrimaryAttack()
	if self:Clip1() <= 0 then
		if not self.Primary.FireOnEmpty then
			self:Reload()
		else
			self:EmitSound(self.Primary.EmptySound)
			self:SetNextPrimaryFire(CurTime() + 0.15)
		end

		return
	end

	self:EmitSound(self.Primary.Sound)
	self:MuzzleFlash()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	self:SetClip1(self:Clip1() - 1)

	if SERVER then self:LogWeaponFire() end

	local vecSrc = self.Owner:GetShootPos()
	local vecAim = self.Owner:GetAimVector()

	local bullet = {
		Attacker = self.Owner,
		Damage = self.Primary.Damage,
		Force = self.Primary.Force,
		Num = self.Primary.NumShots,
		Tracer = self.Primary.Tracer,
		AmmoType = self.Primary.Ammo,
		TracerName = self.Primary.TracerName,
		Dir = vecAim,
		Src = vecSrc,
		Spread = self:GetBulletSpread(),
	}

	self:FireBullets(bullet)

	self:FirePunch()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	return self:DefaultReload(ACT_VM_RELOAD)
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DEPLOY)
end