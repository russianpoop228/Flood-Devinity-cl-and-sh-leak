AddCSLuaFile()

SWEP.PrintName     = "Sticky TNT"

SWEP.HoldType      = "slam"

SWEP.Base          = "weapon_grenadebase"

SWEP.ViewModel     = "models/weapons/tfa_nmrih/v_exp_tnt.mdl"
SWEP.WorldModel    = "models/weapons/tfa_nmrih/w_exp_tnt.mdl"

SWEP.WepSelectIcon = Material( "vgui/entities/weapon_stickynade.png" )

SWEP.UseHands      = true
SWEP.FuseLength    = 7

function SWEP:SpawnGrenade()
	local ent = ents.Create("fm_stickynade")
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
		if self.animstep == 0 and diff >= 2.5 then
			self:SendWeaponAnim( ACT_VM_THROW )
			self:Throw()

			self.animstep = 1
		elseif self.animstep == 1 and diff >= 3 then

			self.animstep = 2
		elseif self.animstep == 2 and diff >= 5 then
			self:SendWeaponAnim( ACT_VM_DRAW )

			self.animstep = nil
		end
	end

	self:NextThink(CurTime())
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 6)
	if not self:CanPrimaryAttack() then return end

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	self.animstart = CurTime()
	self.animstep = 0
	self:SendWeaponAnim( ACT_VM_PULLPIN )

	return true
end

local SNDLVL_NORM = 80

sound.Add({
	name    = "Weapon_TNT.Explode",
	channel = CHAN_AUTO,
	volume  = 1.0,
	level   = SNDLVL_NORM,
	sound   = {
		"weapons/firearms/exp_tnt/tnt_explode_01.wav",
		"weapons/firearms/exp_tnt/tnt_explode_02.wav"
	}
})

sound.Add({
	name    = "Weapon_TNT.Ignite",
	channel = CHAN_WEAPON,
	volume  = 1.0,
	level   = SNDLVL_NORM,
	sound   = "weapons/firearms/exp_tnt/tnt_ignite_01.wav",
})

sound.Add({
	name    = "Weapon_TNT.Spark_Loop2",
	channel = CHAN_AUTO,
	volume  = 1.0,
	level   = SNDLVL_NORM,
	sound   = "weapons/firearms/exp_tnt/tnt_spark_loop_02.wav",
})

sound.Add({
	name    = "Weapon_Zippo.Open",
	channel = CHAN_AUTO,
	volume  = 1.0,
	level   = SNDLVL_NORM,
	sound   = {
		"weapons/tools/zippo/zippo_open_01.wav",
		"weapons/tools/zippo/zippo_open_02.wav"
	},
})

sound.Add({
	name    = "Weapon_Zippo.Close",
	channel = CHAN_AUTO,
	level   = SNDLVL_NORM,
	volume  = 1.0,
	sound   = {
		"weapons/tools/zippo/zippo_close_01.wav",
		"weapons/tools/zippo/zippo_close_02.wav"
	},
})

sound.Add({
	name    = "Weapon_Strike_Success",
	channel = CHAN_AUTO,
	level   = SNDLVL_NORM,
	volume  = 1.0,
	sound   = "weapons/tools/zippo/zippo_strike_success_01.wav",
})