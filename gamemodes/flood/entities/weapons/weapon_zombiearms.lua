
AddCSLuaFile()

if CLIENT then
	SWEP.DrawAmmo        = false
	SWEP.DrawCrosshair   = false
	SWEP.ViewModelFOV    = 70
	SWEP.ViewModelFlip   = false
end

SWEP.HoldType     = "knife"
SWEP.Author       = "Donkie"
SWEP.Purpose      = "Kill"
SWEP.Instructions = ""
SWEP.PrintName    = "Zombie Arms"

SWEP.ViewModel             = "models/weapons/v_zombiearms.mdl"
SWEP.WorldModel            = ""

SWEP.Primary.ClipSize      = -1
SWEP.Primary.DefaultClip   = -1
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "none"
SWEP.Primary.Delay         = 2

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = true
SWEP.Secondary.Ammo        = "none"

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
	return true
end

function SWEP:Attack()
	local damage = 6

	local start = self.Owner:EyePos() + Vector(0, 0, -20)
	local endpos = start + self.Owner:GetAimVector() * 80

	self.Owner:LagCompensation(true)
	local ent = self.Owner:TraceHullAttack(start, endpos, Vector(-16,-16,0), Vector(16,16,0), damage, DMG_SLASH, 0, true)
	self.Owner:LagCompensation(false)

	self.Owner:EmitSound("npc/zombie/claw_miss" .. math.random(1, 2) .. ".wav", 75, 100, 1)

	if IsValid(ent) then
		self.Owner:EmitSound("npc/zombie/claw_strike" .. math.random(1, 3) .. ".wav", 75, 100, 0.5)

		if not ent:IsPlayer() then
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() and not ent:IsNPC() and phys:IsMoveable() then
				local vel = damage * 50 * self.Owner:GetAimVector()

				phys:ApplyForceOffset(vel, (ent:NearestPoint(self.Owner:GetShootPos()) + ent:GetPos() * 2) / 3)
			end
		end
	end
end

function SWEP:PrimaryAttack()
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	self.Owner:DoAnimationEvent(PLAYER_ATTACK1)
	self.Owner:EmitSound("npc/zombie/zo_attack" .. math.random(1, 2) .. ".wav", 75, 100, 0.1)

	if SERVER then
		self:Attack()
	end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

SWEP.NextMoan = 0
function SWEP:SecondaryAttack()
	if CurTime() < self.NextMoan then return end

	if SERVER then
		self.Owner:EmitSound("npc/zombie/zombie_voice_idle" .. math.random(1, 14) .. ".wav")
	end

	self.NextMoan = CurTime() + 3
end

function SWEP:Precache()
	for i = 1,14 do
		util.PrecacheSound("npc/zombie/zombie_voice_idle" .. i .. ".wav")

		if i <= 3 then
			util.PrecacheSound("npc/zombie/claw_strike" .. i .. ".wav")
		end

		if i <= 2 then
			util.PrecacheSound("npc/zombie/claw_miss" .. i .. ".wav")
			util.PrecacheSound("npc/zombie/zo_attack" .. i .. ".wav")
		end
	end
end