-- Variables that are used on both client and server
SWEP.Gun = "tfcss_m4a1" -- must be the name of your swep
--redacted
SWEP.Category				= "TFA CS:S"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "M4A1" -- Weapon name (Shown on HUD)
SWEP.Slot				= 2 -- Slot in the weapon selection menu
SWEP.SlotPos				= 66 -- Position in the slot
SWEP.DrawAmmo				= true -- Should draw the default HL2 ammo counter

SWEP.DrawCrosshair			= true -- set false if you want no crosshair



SWEP.HoldType 				= "ar2" -- how others view you carrying the weapon

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/cstrike/c_rif_m4a1.mdl" -- Weapon view model
SWEP.WorldModel				= "models/weapons/w_rif_m4a1.mdl" -- Weapon world model
SWEP.Base				= "tfa_gun_base"

SWEP.UseHands = true

SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("Weapon_M4A1.1") -- Script that calls the primary fire sound
SWEP.Primary.SilencedSound = Sound("Weapon_M4A1.2")
SWEP.Primary.RPM			= 825 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30 -- Size of a clip
SWEP.Primary.DefaultClip		= 60 -- Bullets you start with
SWEP.Primary.KickUp				= 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"

SWEP.Secondary.IronFOV			= 55 -- How much you 'zoom' in. Less is more!

SWEP.data 				= {} -- The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 30 -- Base damage per bullet
SWEP.Primary.Spread		= .02 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- Ironsight accuracy, should be the same for shotguns

SWEP.CanBeSilenced		= true
SWEP.SelectiveFire		= true

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-7.875, -1.772, 0.159)
SWEP.IronSightsAng = Vector(3.144, -1.412, -3.07)
SWEP.SightsPos = Vector(-7.875, -1.772, 0.159)
SWEP.SightsAng = Vector(3.144, -1.412, -3.07)
SWEP.RunSightsPos = Vector(8.145, -8.968, -1.969)
SWEP.RunSightsAng = Vector(-1.667, 66.777, 0)




--redacted