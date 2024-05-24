SWEP.Category             = "Flood Weapons"
SWEP.Author               = ""
SWEP.Contact              = ""
SWEP.Purpose              = ""
SWEP.Instructions         = ""
SWEP.MuzzleAttachment     = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName            = "Scout" -- Weapon name (Shown on HUD)
SWEP.Slot                 = 3 -- Slot in the weapon selection menu
SWEP.SlotPos              = 52 -- Position in the slot
SWEP.DrawAmmo             = true -- Should draw the default HL2 ammo counter

SWEP.DrawCrosshair = false -- Set false if you want no crosshair from hip
SWEP.XHair         = false -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.HoldType      = "shotgun"

SWEP.ViewModelFOV  = 55
SWEP.ViewModelFlip = false
SWEP.ViewModel     = "models/weapons/cstrike/c_snip_scout.mdl" -- Weapon view model
SWEP.VMPos = Vector(0,2,0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0,0,0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.WorldModel    = "models/weapons/w_snip_scout.mdl" -- Weapon world model
SWEP.Base          = "tfa_scoped_base"

SWEP.UseHands = true

SWEP.Primary.Sound          = Sound("Weapon_SCOUT.1") -- script that calls the primary fire sound
SWEP.Primary.RPM            = 50 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 10 -- Size of a clip
SWEP.Primary.DefaultClip    = 60 -- Bullets you start with
SWEP.Primary.KickUp         = 0.8 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.8 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.8 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic/Semi Auto
SWEP.Primary.Ammo           = "SniperPenetratedRound"

SWEP.Secondary.ScopeZoom      = 0.2
SWEP.Secondary.UseParabolic   = false -- Choose your scope type,
SWEP.Secondary.UseACOG        = false
SWEP.Secondary.UseMilDot      = true
SWEP.Secondary.UseSVD         = false
SWEP.Secondary.UseElcan       = false
SWEP.Secondary.UseGreenDuplex = false

--[[SCOPES]]--
SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.IronSightsSensitivity = 0.25
SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.Scoped = true --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.9 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = .2 --Scale of the scope overlay
SWEP.ReticleScale = .2 --Scale of the reticle overlay
SWEP.Secondary.IronFOV = 8 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.Primary.StaticRecoilFactor = 0.8 --Amount of recoil to di

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
SWEP.Primary.Damage       = 95 -- base damage per bullet
SWEP.Primary.Spread       = .01 -- define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-7.722, 0.827, 2.079)
SWEP.IronSightsAng = Vector(0.892, -0.81, -2.309)
SWEP.SightsPos     = Vector(-7.722, 0.827, 2.079)
SWEP.SightsAng     = Vector(0.892, -0.81, -2.309)
SWEP.RunSightsPos  = Vector(13.868, -12.744, -2.05)
SWEP.RunSightsAng  = Vector(-4.435, 62.558, 0)


-- devinity floodweapons viewmodel fix
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1 ,1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}