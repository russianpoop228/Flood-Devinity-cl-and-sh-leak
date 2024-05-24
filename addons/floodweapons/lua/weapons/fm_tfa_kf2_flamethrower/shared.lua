if ( CLIENT ) then
SWEP.WepSelectIcon 					= surface.GetTextureID("vgui/hud/tfa_kf2_flamethrower")
end
SWEP.Base							= "tfa_gun_base"								-- Swep base
SWEP.Category						= "Flood Weapons" 								-- The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer 					= "JFA" 										-- Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author							= "JFA" 										-- Author Tooltip
SWEP.Contact						= "" 											-- Contact Info Tooltip
SWEP.Purpose						= "" 											-- Purpose Tooltip
SWEP.Instructions					= "" 											-- Instructions Tooltip
SWEP.Spawnable						= true 											-- Can you, as a normal user, spawn this?
SWEP.AdminSpawnable					= true 											-- Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair					= false										-- Draw the crosshair?
SWEP.DrawCrosshairIS 				= false 										-- Draw the crosshair in ironsights?
SWEP.PrintName						= "Flamethrower"								-- Weapon name (Shown on HUD)
SWEP.Slot							= 4												-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos						= 73											-- Position in the slot
SWEP.AutoSwitchTo					= true											-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom					= true											-- Auto switch from if you pick up a better weapon
SWEP.Weight							= 30											-- This controls how "good" the weapon is for autopickup.
SWEP.Type 							= "Flamethrower"
SWEP.FireModeName 					= "Flamethrower"

--[[WEAPON HANDLING]]--
SWEP.Primary.Sound 					= ""											-- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound			= ""											-- This is the sound of the weapon, when you shoot and weapon is slienced
SWEP.Primary.PenetrationMultiplier 	= 1 											-- Change the amount of something this gun can penetrate through
SWEP.Primary.Damage 				= 4 											-- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled 		= true 											-- true will handle damagetype in base
--SWEP.Primary.DamageType 			= DMG_BURN 										-- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force 					= nil 											-- Force value, leave nil to autocalc
SWEP.Primary.Knockback 				= 10 -- test											-- Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize 				= 0 											-- Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots 				= 1 											-- The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic			 	= true 											-- Automatic/Semi Auto
SWEP.Primary.RPM 					= 1000 											-- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Semi 				= 0 											-- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Burst 				= nil 											-- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay 			= nil 											-- How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay 			= nil 											-- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater 				= false

--Miscelaneous Sounds
SWEP.IronInSound 					= nil 											-- Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound 					= nil 											-- Sound to play when ironsighting out?  nil for default

--Silencing
SWEP.CanBeSilenced 					= false 										-- Can we silence?  Requires animations.
SWEP.Silenced						= false 										-- Silenced by default?

-- Selective Fire Stuff
SWEP.SelectiveFire 					= false 											-- Allow selecting your firemode?
SWEP.DisableBurstFire 				= false 										-- Only auto/single?
SWEP.OnlyBurstFire 					= false 										-- No auto, only burst/single?
SWEP.DefaultFireMode				= "" 											-- Default to auto or whatev
SWEP.FireModeName 					= nil 											-- Change to a text value to override it

--Ammo Related
SWEP.Primary.ClipSize 				= 125										-- This is the size of a clip
SWEP.Primary.DefaultClip 			= 250 											-- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo 					= "pistol" 									-- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption 		= 1 											-- Ammo consumed per shot

--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering 				= true 											-- Disable round-in-the-chamber

--Recoil Related
SWEP.Primary.KickUp 				= 1											-- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown 				= 1											-- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal 		= 2										-- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor 	= 0.5											-- Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

--Firing Cone Related
SWEP.Primary.Spread 				= .15										 	-- This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy			= .005 											-- Ironsight accuracy, should be the same for shotguns

--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax 	= 2.5											-- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement 		= 0.4 											-- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery	 		= 3												-- How much the spread recovers, per second. Example val: 3

--Range Related
SWEP.Primary.Range 					= 350											-- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff 			= 0.5 											-- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

--Penetration Related
SWEP.MaxPenetrationCounter 			= 3 											-- The maximum number of ricochets.  To prevent stack overflows.

--Misc
SWEP.IronRecoilMultiplier			= 0.6 											-- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier 		= 0.4 											-- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

--Movespeed
SWEP.MoveSpeed 						= 0.5 											-- Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed 			= SWEP.MoveSpeed 						-- Multiply the player's movespeed by this when sighting.

--[[PROJECTILES]]--
SWEP.ProjectileEntity 				= nil 											-- Entity to shoot
SWEP.ProjectileVelocity 			= 0 											-- Entity to shoot's velocity
SWEP.ProjectileModel 				= nil 											-- Entity to shoot's model

--[[VIEWMODEL]]--
SWEP.ViewModel						= "models/weapons/kf2/tfa_c_flamethrower.mdl"				-- Viewmodel path
SWEP.ViewModelFOV					= 70											-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip					= false											-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands		 				= true 											-- Use gmod c_arms system.
SWEP.VMPos 							= Vector(4.8, 6, -2.5)							-- The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng 							= Vector(0,0,0)								-- The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive					= false 										-- Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos 					= nil 											-- The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng 					= nil 											-- The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V = nil --{
	--[0] = 1,
	--[1] = 4,
	--[2] = etc.
--}

--[[WORLDMODEL]]--
SWEP.WorldModel						= "models/weapons/kf2/tfa_w_flamethrower.mdl" 	-- Weapon world model path
SWEP.Bodygroups_W = nil --{
--[0] = 1,
--[1] = 4,
--[2] = etc.
--}
SWEP.HoldType = "physgun" 															-- This is how others view you carrying the weapon. Options include: normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive. You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
        Pos = {
        Up = -4,
        Right = 2,
        Forward = 6,
        },
        Ang = {
        Up = 92,
        Right = 6,
        Forward = 190
        },
		Scale = 0.95
}																					-- Procedural world model animation, defaulted for CS:S purposes.
SWEP.ThirdPersonReloadDisable 		= false											-- Disable third person reload?  True disables.

--[[SCOPES]]--
SWEP.IronSightsSensitivity 			= 1 											-- Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BoltAction 					= false 										-- Unscope/sight after you shoot?
SWEP.Scoped	 						= false 										-- Draw a scope overlay?
SWEP.ScopeOverlayThreshold 			= 0.875 										-- Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset 				= 0.25 											-- How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale 					= 0.5 											-- Scale of the scope overlay
SWEP.ReticleScale 					= 0.7 											-- Scale of the reticle overlay

--GDCW Overlay Options.  Only choose one.
SWEP.Secondary.UseACOG 				= false 										-- Overlay option
SWEP.Secondary.UseMilDot 			= false 										-- Overlay option
SWEP.Secondary.UseSVD 				= false 										-- Overlay option
SWEP.Secondary.UseParabolic 		= false 										-- Overlay option
SWEP.Secondary.UseElcan 			= false 										-- Overlay option
SWEP.Secondary.UseGreenDuplex 		= false 										-- Overlay option
if surface then
	SWEP.Secondary.ScopeTable = nil --[[
		{
			scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
			reticletex = surface.GetTextureID("scope/gdcw_acogchevron"),
			dottex = surface.GetTextureID("scope/gdcw_acogcross")
		}
	]]--
end

--[[SHOTGUN CODE]]--
SWEP.Shotgun 						= false 										-- Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim 				= false 										-- Enable emtpy reloads on shotguns?
SWEP.ShotgunEmptyAnim_Shell 		= true 											-- Enable insertion of a shell directly into the chamber on empty reload?
SWEP.ShellTime 						= .35 											-- For shotguns, how long it takes to insert a shell.

--[[SPRINTING]]--
SWEP.RunSightsPos 					= Vector(4.2, 1.6, -1) 							-- Change this, using SWEP Creation Kit preferably
SWEP.RunSightsAng 					= Vector(-13.4, 15.5, -7.7) 					-- Change this, using SWEP Creation Kit preferably

--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights 				= 1 											-- Enable Ironsights
SWEP.Secondary.IronFOV 				= 70											-- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos 					= Vector(3,10,-2)
SWEP.IronSightsAng 					= Vector(0 , 0 ,0)

--[[INSPECTION]]--
SWEP.InspectPos 					= Vector(14, 1.8, -1)
SWEP.InspectAng 					= Vector(15.5, 35, 16)

--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment 			= true 											-- Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled	 			= false 											-- Enable Blowback?
SWEP.BlowbackVector 				= Vector(0,-2,0)								-- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot 			= 0 											-- Amount of blowback currently, for root
SWEP.BlowbackCurrent				= 0 											-- Amount of blowback currently, for bones
SWEP.BlowbackBoneMods 				= nil 											-- Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron 			= true 											-- Only do blowback on ironsights
SWEP.Blowback_PistolMode 			= false 										-- Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled 		= false 										-- Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect 			= nil											-- Which shell effect to use

--[[VIEWMODEL PROCEDURAL ANIMATION]]--
SWEP.DoProceduralReload 			= false											-- Animate first person reload using lua?
SWEP.ProceduralReloadTime 			= 1 											-- Procedural reload time?

--[[HOLDTYPES]]--
SWEP.IronSightHoldTypeOverride 		= "" 											-- This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.SprintHoldTypeOverride		 	= "" 											-- This variable overrides the sprint holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.

--[[ANIMATION]]--
SWEP.StatusLengthOverride = {
	["base_reload"] 				= 57 / 30,
	["base_reload_empty"] 			= 66 / 30
} 																					-- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
SWEP.SequenceLengthOverride = {
	[ACT_VM_DRAW] = 1.25,
	[ACT_VM_RELOAD] = 3.75,
	[ACT_VM_RELOAD_EMPTY] = 3.65,
}								 													-- Changes both the status delay and the nextprimaryfire of a given animation
SWEP.SequenceRateOverride 			= {} 											-- Like above but changes animation length to a target
SWEP.SequenceRateOverrideScaled 	= {} 											-- Like above but scales animation length rather than being absolute

SWEP.ProceduralHoslterEnabled 		= nil
SWEP.ProceduralHolsterTime		 	= 0.3
SWEP.ProceduralHolsterPos 			= Vector(3, 0, -5)
SWEP.ProceduralHolsterAng 			= Vector(-40, -30, 10)

SWEP.Sights_Mode 					= TFA.Enum.LOCOMOTION_HYBRID 					-- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode 					= TFA.Enum.LOCOMOTION_HYBRID 					-- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult 					= 1.5
SWEP.Idle_Mode 						= TFA.Enum.IDLE_BOTH 							-- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend 					= 0.25 											-- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth	 				= 0.05			 								-- Start an idle this far early into the end of another animation
--MDL Animations Below

--[[EFFECTS]]--
--Attachments
SWEP.MuzzleAttachment				= "1" 											-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment				= "2" 											-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled 			= true 											-- Enable muzzle flash
SWEP.MuzzleAttachmentRaw			= nil 											-- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment 	= false 										-- For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect 				= nil 											-- Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle 					= nil 											-- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled 			= false 										-- Disable automatic ejection smoke

--Shell eject override
SWEP.LuaShellEject 					= false 										-- Enable shell ejection through lua?
SWEP.LuaShellEjectDelay 			= 0 											-- The delay to actually eject things
SWEP.LuaShellEffect 				= "RifleShellEject" 							-- The effect used for shell ejection; Defaults to that used for blowback

--Tracer Stuff
SWEP.TracerName 					= nil 											-- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 					= 3 											-- 0 disables, otherwise, 1 in X chance

--Impact Effects
SWEP.ImpactEffect					= nil                                           -- Impact Effect
SWEP.ImpactDecal 					= nil											-- Impact Decal

--[[RENDER TARGET]]--
SWEP.RTMaterialOverride 			= nil 											-- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
SWEP.RTOpaque 						= false 										-- Do you want your render target to be opaque?
SWEP.RTCode							= nil											-- function(self) return end --This is the function to draw onto your rendertarget

--[[AKIMBO]]--
SWEP.Akimbo 						= false 										--	Akimbo gun?  Alternates between primary and secondary attacks.
SWEP.AnimCycle 						= 0 											-- Start on the right

--[[ATTACHMENTS]]--

SWEP.ForceDryFireOff			 	= true
SWEP.ForceEmptyFireOff 				= true
SWEP.InspectionLoop 				= false 										--Setting false will cancel inspection once the animation is done.  CS:GO style.

DEFINE_BASECLASS( SWEP.Base )

// Big thanks for this code to Robotnik :P

game.AddParticles("particles/ef_flamer.pcf")
game.AddParticles("particles/kf2_flamethrower2.pcf")
PrecacheParticleSystem("flamethrower")
function SWEP:Think2(...)
	if not IsFirstTimePredicted() then return BaseClass.Think2(self, ...) end
	if not self:VMIV() then return end

	if self.Shooting_Old == nil then
		self.Shooting_Old = false
	end

	local shooting = self:GetStatus() == TFA.GetStatus("shooting")

	if shooting ~= self.Shooting_Old then
		if shooting then
			self:EmitSound("weapons/kf2/flamethrower/trapper/FlamerStart.wav")
			self.NextIdleSound = CurTime() + 0.2
			
		else
			self:EmitSound("weapons/kf2/flamethrower/trapper/FlamerStop.wav")
			self.NextIdleSound = -1
			self:CleanParticles()
		end
	end

	if shooting then
		if self.NextIdleSound and CurTime() > self.NextIdleSound then
		self:EmitSound("weapons/kf2/flamethrower/trapper/FlamerLoop.wav")
		self.NextIdleSound = CurTime() + SoundDuration( "weapons/kf2/flamethrower/trapper/FlamerLoop.wav" ) - 0.1
		end
	end

	self.Shooting_Old = shooting
	BaseClass.Think2(self, ...)
end

function SWEP:ShootEffectsCustom()
end

function SWEP:DoImpactEffect()
	return true
end

local range
local bul = {}

local function cb(a, b, c)
	if b.HitPos:Distance(a:GetShootPos()) > range then return end

	if SERVER then
		local flamefx = EffectData()
			flamefx:SetOrigin(b.HitPos)
		util.Effect("swep_flamethrower_explosion", flamefx, true, true)

		if IsValid(b.Entity) and b.Entity:IsDestroyable() then
			b.Entity:FMIgnite(a, c:GetDamage())
		end
	end
end

function SWEP:ShootBullet()
	local trace = self.Owner:GetEyeTrace()

	if SERVER then
		local flamefx = EffectData()
			flamefx:SetOrigin(trace.HitPos)
			flamefx:SetStart(self.Owner:GetShootPos())
			flamefx:SetAttachment(1)
			flamefx:SetEntity(self)
		util.Effect("swep_flamethrower_flame", flamefx, true, true)
	end

	bul.Attacker = self.Owner
	bul.Distance = self.Primary.Range
	bul.HullSize = self.Primary.HullSize
	bul.Num = 1
	bul.Damage = self.Primary.Damage
	bul.Distance = self.Primary.Range
	bul.Tracer = 0
	bul.Callback = cb
	bul.Src = self.Owner:GetShootPos()
	bul.Dir = self.Owner:GetAimVector()
	range = bul.Distance
	self.Owner:FireBullets(bul)
end

function SWEP:Deploy()
self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
self:SetDeploySpeed(self.Owner:GetViewModel():SequenceDuration())
self.Weapon:SetNextPrimaryFire( 10 + self.Owner:GetViewModel():SequenceDuration() )
self.Weapon:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
end

-- devinity floodweapons viewmodel fix
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1.144, 1.144, 1.144), pos = Vector(30, 30, 30), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, -30, 30), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, 30, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(30, 30, -30), angle = Angle(0, 0, 0) }

}
