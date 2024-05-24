SWEP.Category             = "Flood Weapons"
SWEP.Author               = ""
SWEP.Contact              = ""
SWEP.Purpose              = ""
SWEP.Instructions         = ""
SWEP.MuzzleAttachment     = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName            = "AK47" -- Weapon name (Shown on HUD)
SWEP.Slot                 = 2 -- Slot in the weapon selection menu
SWEP.SlotPos              = 58 -- Position in the slot
SWEP.DrawAmmo             = true -- Should draw the default HL2 ammo counter

SWEP.DrawCrosshair        = true -- set false if you want no crosshair



SWEP.HoldType             = "shotgun" -- how others view you carrying the weapon

SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false -- should have left it as original, and let everybody do as little change to the coding as necessary.
 -- But no, you just had to go and screw with the viewmodel.
 -- goddammit, you're making me spend a lot of time fixing this mess.
SWEP.ViewModel       = "models/weapons/cstrike/c_rif_ak47.mdl" -- Weapon view model
SWEP.WorldModel      = "models/weapons/w_rif_ak47.mdl" -- Weapon world model
SWEP.Base            = "tfa_gun_base"
SWEP.UseHands        = true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound          = Sound("Weapon_AK47.1") -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 600 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30 -- Size of a clip
SWEP.Primary.DefaultClip    = 60 -- Bullets you start with
SWEP.Primary.KickUp         = 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "ar2"

SWEP.Secondary.IronFOV = 55 -- How much you 'zoom' in. Less is more!

SWEP.data            = {} -- The starting firemode
SWEP.data.ironsights = 1

SWEP.Primary.NumShots     = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage       = 30 -- Base damage per bullet
SWEP.Primary.Spread       = .02 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.StaticRecoilFactor = 1 --Amount of recoil to di

SWEP.SelectiveFire = true

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-6.605, -9.414, 2.565)
SWEP.IronSightsAng = Vector(2.388, 0.052, 0)
SWEP.SightsPos     = Vector(-6.605, -9.414, 2.565)
SWEP.SightsAng     = Vector(2.388, 0.052, 0)
SWEP.RunSightsPos  = Vector(9.369, -17.244, -3.689)
SWEP.RunSightsAng  = Vector(6.446, 62.852, 0)

--[[VIEWMODEL BLOWBACK]]--

SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(-0,-2,0.05) --Vector to move bone <or root> relative to bone <or view> orientation.
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