
SWEP.PrintName     = "HE Grenade"
SWEP.Base          = "weapon_grenadebase"

SWEP.ViewModel     = Model("models/weapons/cstrike/c_eq_fraggrenade.mdl")
SWEP.ViewModelFOV  = 50
SWEP.WorldModel    = Model("models/weapons/w_eq_fraggrenade.mdl")
SWEP.UseHands      = true

SWEP.ThrowStrength = 1
SWEP.FuseLength    = 2.3

SWEP.WepSelectIcon = Material( "vgui/entities/weapon_fragfm.png" )

function SWEP:SpawnGrenade()
	local ent = ents.Create("fm_frag")
	return ent
end

function SWEP:Deploy()
	self.animstart = nil
	self.animstep = nil
	self:SendWeaponAnim( ACT_VM_DRAW )
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
