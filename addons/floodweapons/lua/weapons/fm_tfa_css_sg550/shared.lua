SWEP.Spawnable				= true 
SWEP.Category				= "Flood Weapons"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "SG550" -- Weapon name (Shown on HUD)
SWEP.Slot				= 3 -- Slot in the weapon selection menu
SWEP.SlotPos				= 68 -- Position in the slot
SWEP.DrawAmmo				= true -- Should draw the default HL2 ammo counter

SWEP.DrawCrosshair			= false -- Set false if you want no crosshair from hip



SWEP.XHair					= false -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.HoldType 				= "shotgun"

SWEP.ViewModelFOV			= 55
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/cstrike/c_snip_sg550.mdl" -- Weapon view model
SWEP.VMPos = Vector(0,0,0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0,0,0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.WorldModel				= "models/weapons/w_snip_sg550.mdl" -- Weapon world model
SWEP.Base 				= "tfa_gun_base"

SWEP.UseHands = true

SWEP.Primary.Sound			= Sound("Weapon_SG550.1") -- script that calls the primary fire sound
SWEP.Primary.RPM				= 500 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 20 -- Size of a clip
SWEP.Primary.DefaultClip			= 60 -- Bullets you start with
SWEP.Primary.KickUp			= .2 -- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= .05 -- Maximum up recoil (stock)
SWEP.Primary.StaticRecoilFactor = 0.8 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
SWEP.Primary.Automatic			= false -- Automatic/Semi Auto
SWEP.Primary.Ammo			= "ar2"

--[[SCOPES]]--
SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.IronSightsSensitivity = 0.3
SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.Scoped = true --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.9 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = .2 --Scale of the scope overlay
SWEP.ReticleScale = .2 --Scale of the reticle overlay
SWEP.Secondary.IronFOV = 10 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.


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

SWEP.Primary.NumShots	= 1 -- how many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 50 -- base damage per bullet
SWEP.Primary.Spread		= .005 -- define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-7.401, -5.94, 1.279)
SWEP.IronSightsAng = Vector(1.18, 0, 0)
SWEP.SightsPos = Vector(-7.401, -5.94, 1.279)
SWEP.SightsAng = Vector(1.18, 0, 0)
SWEP.RunSightsPos = Vector(10.786, -18.347, 0)
SWEP.RunSightsAng = Vector(-7.982, 70, 0)


-- devinity floodweapons viewmodel fix
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1 ,1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}