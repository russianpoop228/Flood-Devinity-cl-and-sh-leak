SWEP.Category				= "Flood Weapons"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "HK UMP45" -- Weapon name (Shown on HUD)
SWEP.Slot				= 2 -- Slot in the weapon selection menu
SWEP.SlotPos				= 78 -- Position in the slot
SWEP.DrawAmmo				= true -- Should draw the default HL2 ammo counter

SWEP.DrawCrosshair			= true -- set false if you want no crosshair
SWEP.AllowSprintAttack = true


SWEP.HoldType 				= "shotgun" -- how others view you carrying the weapon

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/cstrike/c_smg_ump45.mdl" -- Weapon view model
SWEP.WorldModel				= "models/weapons/w_smg_ump45.mdl" -- Weapon world model
SWEP.Base				= "tfa_gun_base"

SWEP.UseHands = true

SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("Weapon_UMP45.1") -- Script that calls the primary fire sound
SWEP.Primary.RPM			= 500 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 25 -- Size of a clip
SWEP.Primary.DefaultClip		= 60 -- Bullets you start with
SWEP.Primary.KickUp				= 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.IronFOV			= 55 -- How much you 'zoom' in. Less is more!

SWEP.data 				= {} -- The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 24 -- Base damage per bullet
SWEP.Primary.Spread		= .02 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.StaticRecoilFactor = 0.8 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

SWEP.SelectiveFire		= true

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-8.754, -5.351, 4.219)
SWEP.IronSightsAng = Vector(-1.331, -0.28, -2.112)
SWEP.SightsPos = Vector(-8.754, -5.351, 4.219)
SWEP.SightsAng = Vector(-1.331, -0.28, -2.112)
SWEP.RunSightsPos = Vector(8.135, -7.776, 0)
SWEP.RunSightsAng = Vector(-5.575, 39.759, 0)

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