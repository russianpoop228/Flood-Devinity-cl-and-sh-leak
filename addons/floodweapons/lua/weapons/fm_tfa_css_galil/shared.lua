SWEP.Category				= "Flood Weapons"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Galil" -- Weapon name (Shown on HUD)
SWEP.Slot				= 2 -- Slot in the weapon selection menu
SWEP.SlotPos				= 64 -- Position in the slot
SWEP.DrawAmmo				= true -- Should draw the default HL2 ammo counter

SWEP.DrawCrosshair			= true -- set false if you want no crosshair
SWEP.Spawnable				= true


SWEP.HoldType 				= "shotgun" -- how others view you carrying the weapon

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/cstrike/c_rif_galil.mdl" -- Weapon view model
SWEP.WorldModel				= "models/weapons/w_rif_galil.mdl" -- Weapon world model
SWEP.Base				= "tfa_gun_base"

SWEP.UseHands = true

SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("Weapon_Galil.1") -- Script that calls the primary fire sound
SWEP.Primary.RPM			= 900 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 36 -- Size of a clip
SWEP.Primary.DefaultClip		= 70 -- Bullets you start with
SWEP.Primary.KickUp				= 0.1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.1 -- Maximum up recoil (stock)
SWEP.Primary.StaticRecoilFactor = 1 --Amount of recoil to directly apply to EyeA
SWEP.Primary.Automatic			= true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"

SWEP.Secondary.IronFOV			= 55 -- How much you 'zoom' in. Less is more!

SWEP.data 				= {} -- The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 28 -- Base damage per bullet
SWEP.Primary.Spread		= .01 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .005 -- Ironsight accuracy, should be the same for shotguns

SWEP.SelectiveFire		= true

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-6.362, -3.52, 2.52)
SWEP.IronSightsAng = Vector(-0.159, 0, 0)
SWEP.SightsPos = Vector(-6.362, -3.52, 2.64)
SWEP.SightsAng = Vector(-0.159, 0, 0)
SWEP.RunSightsPos = Vector(9.369, -17.244, -3.689)
SWEP.RunSightsAng = Vector(6.446, 62.852, 0)


--[[VIEWMODEL BLOWBACK]]--

SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(-0,-2,-0.05) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = true --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "ShellEject"--Which shell effect to use

-- devinity floodweapons viewmodel fix
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1 ,1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}