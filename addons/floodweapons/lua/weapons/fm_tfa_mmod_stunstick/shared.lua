SWEP.Category				= "Flood Weapons"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "STUNSTICK\n(CIVIL PROTECTION MELEE ISSUE)"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 27			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 35			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "melee"		-- how others view you carrying the weapon
SWEP.Primary.Sound = Sound("Weapon_StunStick.Swing") 
SWEP.KnifeShink = "Weapon_StunStick.Melee_Hit" --Sounds
SWEP.KnifeSlash = "Weapon_StunStick.Melee_Hit" --Sounds
SWEP.KnifeStab = "TFA_MMOD.StunStick.Hit" --Sounds
SWEP.Primary.Delay = 0.0 --Delay for hull (primary)
SWEP.Secondary.Delay = 0.0 --Delay for hull (secondary)
SWEP.Primary.RPM = 100
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = nil
SWEP.DamageType = DMG_CLUB
SWEP.AllowSprintAttack = true

function SWEP:ThrowKnife()
	return false
end

SWEP.IsMelee = true

SWEP.VMPos = Vector(1,2,-1)
SWEP.VMAng = Vector(0, 0, 0)

-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.SlashTable = {"misscenter1", "misscenter2"} --Table of possible hull sequences
SWEP.StabTable = {"hitcenter1", "hitcenter2", "hitcenter3"} --Table of possible hull sequences
SWEP.SlashMissTable = {"misscenter1", "misscenter2"}
SWEP.StabMissTable = {"misscenter1", "misscenter2"} --Table of possible hull sequences

SWEP.Primary.Length = 125
SWEP.Secondary.Length = 55

SWEP.Primary.Damage = 35
SWEP.Secondary.Damage = 55

SWEP.ViewModelFlip			= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel				= "models/weapons/tfa_mmod/c_stunstick.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_stunbaton.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "tfa_knife_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = true

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
}

SWEP.WalkAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "walk", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
}

SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Walk_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

DEFINE_BASECLASS ( SWEP.Base )

local tracedata = {}

function SWEP:DoImpactEffect(tr, dmgtype)
	if tr.HitSky then return true end
	local ib = self.BashBase and IsValid(self) and self:GetBashing()
	local dmginfo = DamageInfo()
	dmginfo:SetDamageType(dmgtype)

	if ib and self.Secondary.BashDamageType == DMG_GENERIC then return true end
	if ib then return end

	if self.ImpactDecal and self.ImpactDecal ~= "" then
		util.Decal(self.ImpactDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
		return true
	end
end


function SWEP:SecondaryAttack()
return false
end

function SWEP:SmackEffect(tr)
	local vSrc = tr.StartPos
	local bFirstTimePredicted = IsFirstTimePredicted()
	local bHitWater = bit.band(util.PointContents(vSrc), MASK_WATER) ~= 0
	local bEndNotWater = bit.band(util.PointContents(tr.HitPos), MASK_WATER) == 0

	local trSplash = bHitWater and bEndNotWater and util.TraceLine({
		start = tr.HitPos,
		endpos = vSrc,
		mask = MASK_WATER
	}) or not (bHitWater or bEndNotWater) and util.TraceLine({
		start = vSrc,
		endpos = tr.HitPos,
		mask = MASK_WATER
	})

	if (trSplash and bFirstTimePredicted) then
		local data = EffectData()
		data:SetOrigin(trSplash.HitPos)
		data:SetScale(1)

		if (bit.band(util.PointContents(trSplash.HitPos), CONTENTS_SLIME) ~= 0) then
			data:SetFlags(1) --FX_WATER_IN_SLIME
		end

		util.Effect("watersplash", data)
	end

	self:DoImpactEffect(tr, self.DamageType)

	if (tr.Hit and bFirstTimePredicted and not trSplash) then
		local data = EffectData()
		data:SetOrigin(tr.HitPos)
		data:SetStart(vSrc)
		data:SetSurfaceProp(tr.SurfaceProps)
		data:SetDamageType(self.DamageType)
		data:SetHitBox(tr.HitBox)
		data:SetEntity(tr.Entity)
		util.Effect("Impact", data)
		util.Effect("StunstickImpact", data)
	end
	
end

-- devinity floodweapons viewmodel fix
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1.144, 1.144, 1.144), pos = Vector(30, 30, 30), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, -30, 30), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, 30, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(0.1, 0.1, 0.1), pos = Vector(0, 0, 0), angle = Angle(20, 180, 0) }

}