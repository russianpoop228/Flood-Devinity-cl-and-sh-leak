-- Variables that are used on both client and server
SWEP.Gun = "tfcss_usp" -- must be the name of your swep
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "TFA CS:S"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.MuzzleDirectionIsFucked = true
SWEP.ShellEjectAttachment			= "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "HK USP" -- Weapon name (Shown on HUD)
SWEP.Slot				= 1 -- Slot in the weapon selection menu
SWEP.SlotPos				= 45 -- Position in the slot
SWEP.DrawAmmo				= true -- Should draw the default HL2 ammo counter

SWEP.DrawCrosshair			= true -- set false if you want no crosshair



SWEP.HoldType 				= "pistol" -- how others view you carrying the weapon

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/cstrike/c_pist_usp.mdl" -- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pist_usp.mdl" -- Weapon world model
SWEP.Base				= "tfa_gun_base"

SWEP.UseHands = true

SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("Weapon_USP.1") -- Script that calls the primary fire sound
SWEP.Primary.SilencedSound = Sound("Weapon_USP.2")
SWEP.Primary.RPM			= 825 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 15 -- Size of a clip
SWEP.Primary.DefaultClip		= 45 -- Bullets you start with
SWEP.Primary.KickUp				= 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.IronFOV			= 55 -- How much you 'zoom' in. Less is more!

SWEP.data 				= {} -- The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 20 -- Base damage per bullet
SWEP.Primary.Spread		= .025 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .015 -- Ironsight accuracy, should be the same for shotguns

SWEP.CanBeSilenced		= true

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-5.89, -3.237, 2.68)
SWEP.IronSightsAng = Vector(0.087, 0.041, 0)
SWEP.SightsPos = Vector(-5.89, -3.237, 2.68)
SWEP.SightsAng = Vector(0.087, 0.041, 0)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-9.469, -1.701, 0)

SWEP.DisableIdleAnimations = false



if GetConVar("tfaUniqueSlots") != nil then
	if not (GetConVar("tfaUniqueSlots"):GetBool()) then
		SWEP.SlotPos = 2
	end
end