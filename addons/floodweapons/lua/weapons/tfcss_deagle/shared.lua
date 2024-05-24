-- Variables that are used on both client and server
SWEP.Gun = "tfcss_deagle" -- must be the name of your swep
--redacted
SWEP.Category				= "TFA CS:S"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Desert Eagle" -- Weapon name (Shown on HUD)
SWEP.Slot				= 1 -- Slot in the weapon selection menu
SWEP.SlotPos				= 35 -- Position in the slot
SWEP.DrawAmmo				= true -- Should draw the default HL2 ammo counter

SWEP.DrawCrosshair			= true -- set false if you want no crosshair



SWEP.HoldType 				= "revolver" -- how others view you carrying the weapon

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/cstrike/c_pist_deagle.mdl" -- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pist_deagle.mdl" -- Weapon world model
SWEP.Base				= "tfa_gun_base"

SWEP.UseHands = true

SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("Weapon_DEagle.1") -- Script that calls the primary fire sound
SWEP.Primary.RPM			= 300 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 7 -- Size of a clip
SWEP.Primary.DefaultClip		= 28 -- Bullets you start with
SWEP.Primary.KickUp				= 1.5 -- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "357"

SWEP.Secondary.IronFOV			= 65 -- How much you 'zoom' in. Less is more!

SWEP.data 				= {} -- The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 50 -- Base damage per bullet
SWEP.Primary.Spread		= .03 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .02 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-6.361, -5.579, 1.919)
SWEP.IronSightsAng = Vector(0.718, 0, 0)
SWEP.SightsPos = Vector(-6.361, -5.579, 1.919)
SWEP.SightsAng = Vector(0.718, 0, 0)
SWEP.RunSightsPos = Vector(2.405, -17.334, -15.011)
SWEP.RunSightsAng = Vector(70, 0, 0)

SWEP.BlowbackEnabled = true
SWEP.Blowback_Only_Iron = true -- Only do blowback on ironsights
SWEP.BlowbackVector = Vector(0,-6,1) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackBoneMods = {
	["v_weapon.Deagle_Slide"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 1.75), angle = Angle(0, 0, 0) }
}
SWEP.BlowbackVector = Vector(0,-2,0)
SWEP.Blowback_PistolMode = true -- Do we recover from blowback when empt
