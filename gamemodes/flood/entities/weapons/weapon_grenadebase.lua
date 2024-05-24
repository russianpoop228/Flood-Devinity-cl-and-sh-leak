AddCSLuaFile()

SWEP.Base                  = "weapon_fmbase"

SWEP.PrintName             = "Grenade"
SWEP.Author                = "Donkie"
SWEP.Slot                  = 4
SWEP.SlotPos               = 1

SWEP.HoldType              = "grenade"

SWEP.Spawnable             = false
SWEP.AdminSpawnable        = false

SWEP.ViewModel             = "models/weapons/c_grenade.mdl"
SWEP.WorldModel            = "models/weapons/w_grenade.mdl"

SWEP.Weight                = 5
SWEP.AutoSwitchTo          = false
SWEP.AutoSwitchFrom        = false

SWEP.Primary.ClipSize      = 100
SWEP.Primary.DefaultClip   = 100
SWEP.Primary.Automatic     = false
SWEP.Primary.Ammo          = "Grenade"

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false
SWEP.Secondary.Ammo        = "none"

SWEP.ThrowStrength         = 1
SWEP.FuseLength            = 4

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:SpawnGrenade()
end

function SWEP:Throw()
	if CLIENT then return end

	local ent = self:SpawnGrenade()
	if not IsValid(ent) then return end

	local ply = self.Owner

	local ang = ply:EyeAngles()
	local src = ply:GetPos() + (ply:Crouching() and ply:GetViewOffsetDucked() or ply:GetViewOffset()) + (ang:Forward() * 8) + (ang:Right() * 10)
	local target = ply:GetEyeTraceNoCursor().HitPos
	local tang = (target-src):Angle() -- A target angle to actually throw the grenade to the crosshair instead of fowards
	-- Makes the grenade go upgwards
	if tang.p < 90 then
		tang.p = -10 + tang.p * ((90 + 10) / 90)
	else
		tang.p = 360 - tang.p
		tang.p = -10 + tang.p * -((90 + 10) / 90)
	end
	tang.p = math.Clamp(tang.p,-90,90) -- Makes the grenade not go backwards :/
	local vel = math.min(800, (90 - tang.p) * 6) * self.ThrowStrength
	local thr = tang:Forward() * vel + ply:GetVelocity()

	ent:SetPos(src)

	ent:SetOwner(ply)
	ent:SetThrower(ply)

	ent:SetGravity(0.4)
	ent:SetFriction(0.2)
	ent:SetElasticity(0.45)

	ent:Spawn()

	ent:PhysWake()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(thr)
		phys:AddAngleVelocity(Vector(600, math.random(-1200, 1200), 0))
	end

	ent:SetDetonateTimer(self.FuseLength)

	self:TakePrimaryAmmo(1)
	self:DefaultReload(0)
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 2)
	if not self:CanPrimaryAttack() then return end

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	self:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
	timer.Simple(0.5, function()
		self:SendWeaponAnim( ACT_VM_THROW )
		timer.Simple(0.4, function()
			self:Throw()
		end)
	end)

	return true
end

function SWEP:CanPrimaryAttack()
	return self:Clip1() > 0 or self:Ammo1() > 0
end
