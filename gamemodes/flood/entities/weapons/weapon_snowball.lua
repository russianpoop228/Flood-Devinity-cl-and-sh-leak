
SWEP.PrintName     = "Snowball"
SWEP.Base          = "weapon_grenadebase"

SWEP.ViewModel    = "models/weapons/v_snowball.mdl"
SWEP.WorldModel   = "models/weapons/w_snowball.mdl"
SWEP.ViewModelFOV = 50
SWEP.UseHands     = false

SWEP.ThrowStrength = 2
SWEP.FuseLength    = 9999

game.AddAmmoType({
	name      = "fmsnowballs",
	dmgtype   =	DMG_BULLET,
	tracer    =	TRACER_LINE_AND_WHIZ,
	plydmg    =	20,
	npcdmg    =	20,
	force     =	100,
	minsplash =	5,
	maxsplash =	10
})

SWEP.Primary.ClipSize    = 3
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Ammo        = "fmsnowballs"

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetClip1(3)
	util.PrecacheSound("weapons/iceaxe/iceaxe_swing1.wav")
	util.PrecacheSound("hit.wav")
end

function SWEP:SpawnGrenade()
	local ent = ents.Create("fm_snowball")
	return ent
end

function SWEP:Think()
	if self.animstart then
		local diff = (CurTime() - self.animstart)
		if self.animstep == 0 and diff >= 1 then
			self:SendWeaponAnim( ACT_VM_THROW )

			self.animstep = 1
		elseif self.animstep == 1 and diff >= 1.3 then
			self:Throw()

			self.animstep = 2
		elseif self.animstep == 2 and diff >= 2.5 then
			self:SendWeaponAnim( ACT_VM_DRAW )

			self.animstep = nil
		end
	end

	if SERVER and self:Clip1() <= 0 then
		self.Owner:DropWeapon(self)
		self:Remove()
	end

	self:NextThink(CurTime())
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 3)
	if not self:CanPrimaryAttack() then return end

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	self.animstart = CurTime()
	self.animstep = 0
	self:SendWeaponAnim( ACT_VM_PULLPIN )

	return true
end