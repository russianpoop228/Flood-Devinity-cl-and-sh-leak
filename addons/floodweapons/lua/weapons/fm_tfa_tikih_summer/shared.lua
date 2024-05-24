
SWEP.Category				= "Flood Weapons"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "The Tiki Heartburn"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 21			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "shotgun"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.DisableChambering = true
SWEP.CanBeSilenced		= false
SWEP.ViewModelFOV			= 75
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_smg_tikih.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_smg_tikih.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.VMPos = Vector(-4,2,1)
SWEP.VMAng = Vector(-8,-15,0)
SWEP.FiresUnderwater = false
SWEP.Akimbo = false

SWEP.SelectiveFire		= false

SWEP.Primary.Sound			= Sound("Weapon_Tiki.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM				= 350			-- This is in Rounds Per Minute
SWEP.Primary.RPM_Semi				= 1300
SWEP.Primary.ClipSize			= 45		-- Size of a clip
SWEP.Primary.DefaultClip		= 240		-- Bullets you start with
SWEP.Primary.KickUp				= 0.09		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.09		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.09		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true	-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "smg1"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun

--Range Related
SWEP.Primary.Range = 3 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.9 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.


-- Selective Fire Stuff


-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 70		-- How much you 'zoom' in. Less is more!

SWEP.IronSightsSensitivity = 0.75

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 3		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 20	-- Base damage per bullet
SWEP.Primary.Spread		= .075	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .010 -- Ironsight accuracy, should be the same for shotguns

SWEP.Primary.SpreadMultiplierMax = 1.5 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 1/3.5 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 3 --How much the spread recovers, per second.

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(-4.45, -2.0, 1.75)
SWEP.SightsAng = Vector(0, 0, 3)

SWEP.RunSightsPos = Vector(3.364, -3.595, -0.843)
SWEP.RunSightsAng = Vector(-3.016, 49.14, 0)
SWEP.InspectPos = Vector(6.224, -5.738, -0.945)
SWEP.InspectAng = Vector(15.256, 49.308, 6.96)
SWEP.Offset = {
        Pos = {
        Up = 0.7,
        Right = .2,
        Forward = -0.2,
        },
        Ang = {
        Up = -1,
        Right = -14,
        Forward = 175,
        },
		Scale = 1
}

-- event multiplier stuff
	
local cv_dmg_mult = GetConVar("sv_tfa_damage_multiplier")
local cv_dmg_mult_min = GetConVar("sv_tfa_damage_mult_min")
local cv_dmg_mult_max = GetConVar("sv_tfa_damage_mult_max")
local dmg, con, rec

function SWEP:ShootBulletInformation()
	self:UpdateConDamage()
	self.lastbul = nil
	self.lastbulnoric = false
	self.ConDamageMultiplier = cv_dmg_mult:GetFloat()
	if not IsFirstTimePredicted() then return end
	con, rec = self:CalculateConeRecoil()
	local tmpranddamage = math.Rand(cv_dmg_mult_min:GetFloat(), cv_dmg_mult_max:GetFloat())
	basedamage = ISSUMMER and self:GetStat("Primary.Damage") * 1.25 or self:GetStat("Primary.Damage")
	dmg = basedamage * tmpranddamage
	local ns = self:GetStat("Primary.NumShots")
	local clip = (self:GetStat("Primary.ClipSize") == -1) and self:Ammo1() or self:Clip1()
	ns = math.Round(ns, math.min(clip / self:GetStat("Primary.NumShots"), 1))
	ns = math.Round(ns)
	self:ShootBullet(dmg, rec, ns, con)
end
