
SWEP.Category             = "TFA CS:S"
SWEP.Author               = ""
SWEP.Contact              = ""
SWEP.Purpose              = ""
SWEP.Instructions         = ""
SWEP.MuzzleAttachment     = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName            = "Steyr AUG" -- Weapon name (Shown on HUD)
SWEP.Slot                 = 2 -- Slot in the weapon selection menu
SWEP.SlotPos              = 60 -- Position in the slot
SWEP.DrawAmmo             = true -- Should draw the default HL2 ammo counter

SWEP.DrawCrosshair = true -- Set false if you want no crosshair from hip
SWEP.XHair         = true -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.HoldType      = "shotgun"

SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.ViewModel     = "models/weapons/cstrike/c_rif_aug.mdl" -- Weapon view model
SWEP.WorldModel    = "models/weapons/w_rif_aug.mdl" -- Weapon world model
SWEP.Base          = "tfa_scoped_base"

SWEP.UseHands = true

SWEP.Primary.Sound          = Sound("Weapon_AUG.1") -- script that calls the primary fire sound
SWEP.Primary.RPM            = 700 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30 -- Size of a clip
SWEP.Primary.DefaultClip    = 60 -- Bullets you start with
SWEP.Primary.KickUp         = .1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = .2 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = .2 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic/Semi Auto
SWEP.Primary.Ammo           = "ar2"
SWEP.Primary.StaticRecoilFactor = 0.8 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
SWEP.Primary.Spread		= .005
SWEP.Primary.IronAccuracy = .001


SWEP.Primary.SpreadMultiplierMax 	= 1.8											-- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement 		= 0.45 											-- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery	 		= 3	

--[[SCOPES]]--
SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.IronSightsSensitivity = 0.02
SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.Scoped = true --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.9 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = .2 --Scale of the scope overlay
SWEP.ReticleScale = .2 --Scale of the reticle overlay
SWEP.Secondary.IronFOV = 3 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightTime = 0.3
SWEP.Primary.StaticRecoilFactor 	= 1		

--GDCW Overlay Options.  Only choose one.
SWEP.Secondary.UseACOG = false --Overlay option
SWEP.Secondary.UseMilDot = false --Overlay option
SWEP.Secondary.UseSVD = false --Overlay option
SWEP.Secondary.UseParabolic = true --Overlay option
SWEP.Secondary.UseElcan = false --Overlay option
SWEP.Secondary.UseGreenDuplex = false --Overlay option
SWEP.Secondary.UseGreenDuplex = false --Overlay option
SWEP.Secondary.ScopeTable = {
	["ScopeMaterial"] =  Material("tfa_cso2/scope/scope_arc.png", "smooth"),
	["ScopeBorder"] = color_black,
	["ScopeCrosshair"] = { ["r"] = 0, ["g"]  = 0, ["b"] = 0, ["a"] = 255, ["s"] = 1 }
}

SWEP.Primary.NumShots     = 1 -- how many bullets to shoot per trigger pull
SWEP.Primary.Damage       = 30 -- base damage per bullet
SWEP.Primary.Spread       = .02 -- define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below
SWEP.IronSightsPos         = Vector(-11.24, 10.222, 3.24)
SWEP.IronSightsAng         = Vector(-0.201, -3.401, -8.443)
SWEP.SightsPos             = Vector(-8.24, -4.222, 2.24)
SWEP.SightsAng             = Vector(-0.201, -3.401, -8.443)
SWEP.ScopeOverlayThreshold = 0.85
SWEP.RunSightsPos          = Vector(9.369, -10.908, -3.689)
SWEP.RunSightsAng          = Vector(6.446, 64.627, 0)

-- devinity floodweapons viewmodel fix
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1 ,1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}