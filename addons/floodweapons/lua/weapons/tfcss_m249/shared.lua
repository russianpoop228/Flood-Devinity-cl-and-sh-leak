-- Variables that are used on both client and server
SWEP.Gun = "tfcss_m249" -- must be the name of your swep
--redacted
SWEP.Category				= "TFA CS:S"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "M249 Para" -- Weapon name (Shown on HUD)
SWEP.Slot				= 3 -- Slot in the weapon selection menu
SWEP.SlotPos				= 64 -- Position in the slot
SWEP.DrawAmmo				= true -- Should draw the default HL2 ammo counter

SWEP.DrawCrosshair			= true -- set false if you want no crosshair



SWEP.HoldType 				= "shotgun" -- how others view you carrying the weapon

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/cstrike/c_mach_m249para.mdl" -- Weapon view model
SWEP.WorldModel				= "models/weapons/w_mach_m249para.mdl" -- Weapon world model
SWEP.Base				= "tfa_gun_base"

SWEP.UseHands = true

SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("Weapon_M249.1") -- Script that calls the primary fire sound
SWEP.Primary.RPM			= 900 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 100 -- Size of a clip
SWEP.Primary.DefaultClip		= 300 -- Bullets you start with
SWEP.Primary.KickUp				= 0.5 -- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.5 -- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"

SWEP.Secondary.IronFOV			= 55 -- How much you 'zoom' in. Less is more!

SWEP.data 				= {} -- The starting firemode
SWEP.data.ironsights			= 0

SWEP.Primary.NumShots	= 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 30 -- Base damage per bullet
SWEP.Primary.Spread		= .05 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .03 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-5.933, -1.727, 2.279)
SWEP.IronSightsAng = Vector(0.209, 0.057, 0)
SWEP.SightsPos = Vector(-5.933, -1.727, 2.279)
SWEP.SightsAng = Vector(0.209, 0.057, 0)
SWEP.RunSightsPos = Vector(13.307, -15.827, 0)
SWEP.RunSightsAng = Vector(-10.749, 70, -3.583)

--redacted