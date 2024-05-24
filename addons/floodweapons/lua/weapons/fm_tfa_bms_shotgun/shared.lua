SWEP.Base				= "tfa_gun_base"
SWEP.Category				= "Flood Weapons" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = nil --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "The Boot Collective" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
SWEP.PrintName				= "SPAS-12"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 2				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			-- Position in the slot
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 40			-- This controls how "good" the weapon is for autopickup.

--[[WEAPON HANDLING]]--
SWEP.Primary.Sound = Sound("weapon_shotgun_bms.1") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = nil -- This is the sound of the weapon, when silenced.
SWEP.Primary.PenetrationMultiplier = 2 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage = 14 -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Primary.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = nil --Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize = 0 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 8 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = true -- Automatic/Semi Auto
SWEP.Primary.RPM = 80 -- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Semi = nil -- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Burst = nil -- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay = nil --How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay = nil -- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = true

SWEP.Secondary.Act = ACT_VM_SECONDARYATTACK
SWEP.Secondary.Sound = Sound("weapon_shotgun_bms.2") -- This is the sound of the weapon, when you shoot.
SWEP.Secondary.SilencedSound = nil -- This is the sound of the weapon, when silenced.
SWEP.Secondary.PenetrationMultiplier = 3 --Change the amount of something this gun can penetrate through
SWEP.Secondary.Damage = 13 -- Damage, in standard damage points.
SWEP.Secondary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Secondary.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Secondary.Force = 1 --Force value, leave nil to autocalc
SWEP.Secondary.Knockback = 0.5 --Autodetected if nil; this is the velocity kickback
SWEP.Secondary.HullSize = 1 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Secondary.NumShots = 16 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Secondary.Automatic = true -- Automatic/Semi Auto
SWEP.Secondary.RPM = 60 -- This is in Rounds Per Minute / RPM
SWEP.Secondary.RPM_Semi = nil -- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Secondary.RPM_Burst = nil -- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Secondary.DryFireDelay = nil --How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Secondary.BurstDelay = nil -- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = true

--Ammo Related
SWEP.Primary.ClipSize = 8 -- This is the size of a clip
SWEP.Primary.DefaultClip = 125 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "buckshot" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = false --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0.6 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.2 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.6 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .085 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .085 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 1.5 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.5 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 1.5 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = -1 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = -1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

SWEP.Secondary.AmmoConsumption = 2 --Ammo consumed per shot
--Recoil Related
SWEP.Secondary.KickUp = 1.5 -- This is the maximum upwards recoil (rise)
SWEP.Secondary.KickDown = 0.4 -- This is the maximum downwards recoil (skeet)
SWEP.Secondary.KickHorizontal = 0.12 -- This is the maximum sideways recoil (no real term)
SWEP.Secondary.StaticRecoilFactor = 0.8 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Secondary.Spread = .080 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Secondary.SpreadMultiplierMax = 1.5 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Secondary.SpreadIncrement = 0.5 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Secondary.SpreadRecovery = 1.5 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Secondary.Range = -1 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Secondary.RangeFalloff = -1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.


--Miscelaneous Sounds
SWEP.IronInSound = nil --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = nil --Sound to play when ironsighting out?  nil for default
--Silencing
SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?
-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = false --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
SWEP.DefaultFireMode = "" --Default to auto or whatev
SWEP.FireModeName = nil --Change to a text value to override it
--Ammo Related
SWEP.Primary.ClipSize = 8 -- This is the size of a clip
SWEP.Primary.DefaultClip = 125 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "buckshot" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = false --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0.6 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.2 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.6 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .085 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .085 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 1.5 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.5 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 1.5 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = -1 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = -1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Penetration Related
SWEP.MaxPenetrationCounter = 3 --The maximum number of ricochets.  To prevent stack overflows.
--Misc
SWEP.IronRecoilMultiplier = 0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.5 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.8 --Multiply the player's movespeed by this when sighting.
--[[PROJECTILES]]--
SWEP.ProjectileEntity = nil --Entity to shoot
SWEP.ProjectileVelocity = 0 --Entity to shoot's velocity
SWEP.ProjectileModel = nil --Entity to shoot's model
--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/weapons/tfa_bms/c_bms_shotgun.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 57		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.VMPos = Vector(0,0,0) --Vector(0.300,-7.02,0.603) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0,0,0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = true --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos = nil --The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng = nil --The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V = nil --{
	--[0] = 1,
	--[1] = 4,
	--[2] = etc.
--}
--[[WORLDMODEL]]--
SWEP.WorldModel			= "models/weapons/tfa_bms/w_shotgun_bms.mdl" -- Weapon world model path
SWEP.Bodygroups_W = nil --{
--[0] = 1,
--[1] = 4,
--[2] = etc.
--}
SWEP.HoldType = "shotgun" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = 1,
		Right = 1,
		Forward = 0
	},
	Ang = {
		Up = 0,
		Right = -10,
		Forward = 178
	},
	Scale = 1.15
} --Procedural world model animation, defaulted for CS:S purposes.
SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.
--[[SCOPES]]--
SWEP.IronSightsSensitivity = 1 --Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.Scoped = false --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.875 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = 0.5 --Scale of the scope overlay
SWEP.ReticleScale = 0.7 --Scale of the reticle overlay
--GDCW Overlay Options.  Only choose one.
SWEP.Secondary.UseACOG = false --Overlay option
SWEP.Secondary.UseMilDot = false --Overlay option
SWEP.Secondary.UseSVD = false --Overlay option
SWEP.Secondary.UseParabolic = false --Overlay option
SWEP.Secondary.UseElcan = false --Overlay option
SWEP.Secondary.UseGreenDuplex = false --Overlay option
if surface then
	SWEP.Secondary.ScopeTable = {
	}
end

--[[SHOTGUN CODE]]--
SWEP.Shotgun = true --Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim = true --Enable insertion of a shell directly into the chamber on empty reload?
SWEP.ShellTime = 0.4 -- For shotguns, how long it takes to insert a shell.
--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 0 --Enable Ironsights
SWEP.Secondary.IronFOV = 70 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

--[[INSPECTION]]--
SWEP.InspectPos = Vector(3.015, -3.217, 0.402) --Replace with a vector, in style of ironsights position, to be used for inspection
SWEP.InspectAng = Vector(6.55, 27.42, 7.3) --Replace with a vector, in style of ironsights angle, to be used for inspection
--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon SWEP.Secondary while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-.5,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil
--Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = true --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "ShotgunShellEject"--Which shell effect to use
--[[VIEWMODEL PROCEDURAL ANIMATION]]--
SWEP.DoProceduralReload = false--Animate first person reload using lua?
SWEP.ProceduralReloadTime = 1 --Procedural reload time?
--[[HOLDTYPES]]--
SWEP.IronSightHoldTypeOverride = "" --This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.SprintHoldTypeOverride = "" --This variable overrides the sprint holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
--[[ANIMATION]]--

SWEP.ProceduralHoslterEnabled = nil
SWEP.ProceduralHolsterTime = 0.3
SWEP.ProceduralHolsterPos = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng = Vector(-40, -30, 10)

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0 -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this > 1 probably for sprinting.
--MDL Animations Below
SWEP.IronAnimation = {
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "idletosprint", --Number for act, String/Number for sequence
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprintidle1", --Number for act, String/Number for sequence
		["is_idle"] = true
	},--looping animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprinttoidle", --Number for act, String/Number for sequence
		["transition"] = true
	} --Outward transition
}
--[[EFFECTS]]--
--SWEP.Secondarys
SWEP.MuzzleAttachment			= "1" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "2" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled = true --Enable muzzle flash
SWEP.MuzzleAttachmentRaw = nil --This will override whatever string you gave.  This is the raw SWEP.Secondary number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper SWEP.Secondary?
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_rifle" --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle = nil --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = true --Disable automatic ejection smoke
--Shell eject override
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0.7 --The delay to actually eject things
SWEP.LuaShellEffect = "ShotgunShellEject" --The effect used for shell ejection; Defaults to that used for blowback
--Tracer Stuff
SWEP.TracerName 		= nil 	--Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 3 	--0 disables, otherwise, 1 in X chance
--Impact Effects
SWEP.ImpactEffect = nil--Impact Effect
SWEP.ImpactDecal = nil--Impact Decal

SWEP.ShouldPumpReload = false

--[[EVENT TABLE]]--
SWEP.EventTable = {
	[ACT_VM_SECONDARYATTACK] = {
		{ ["time"] = 0.6, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and vm then
				if wep:Clip1() != 0 then
					vm:SendViewModelMatchingSequence( vm:LookupSequence("pump1") )
				end
			end
		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 0.3, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and vm then
				if wep:Clip1() != 0 then
					wep:EventShell()
				end
			end
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_PRIMARYATTACK] = {
		{ ["time"] = 0.4, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and vm then
				if wep:Clip1() != 0 then
					vm:SendViewModelMatchingSequence( vm:LookupSequence("pump1") )
				end
			end
		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 0.9, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and vm then
				if wep:Clip1() != 0 then
					wep:EventShell()
				end
			end
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_SHOTGUN_RELOAD_START] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and vm then
				if wep:Clip1() == 0 then
					wep.ShouldPumpReload = true
				end
			end
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_SHOTGUN_RELOAD_FINISH] = {
		{ ["time"] = 0.3, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and vm then
				if wep.ShouldPumpReload then
					vm:SendViewModelMatchingSequence( vm:LookupSequence("pump1") )
					wep:SetStatus( TFA.Enum.STATUS_RELOADING_SHOTGUN_END )
					wep:SetStatusEnd( CurTime() + vm:SequenceDuration( vm:LookupSequence( "pump1" ) ) )
					wep.ShouldPumpReload = false
				end
			end
		end, ["client"] = true, ["server"] = true }
	},
}
--[[RENDER TARGET]]--
SWEP.RTMaterialOverride = nil -- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
SWEP.RTOpaque = false -- Do you want your render target to be opaque?
SWEP.RTCode = nil--function(self) return end --This is the function to draw onto your rendertarget
--[[AKIMBO]]--
SWEP.Akimbo = false --Akimbo gun?  Alternates between primary and secondary attacks.
SWEP.AnimCycle = 0 -- Start on the right
--[[SWEP.SecondaryS]]--
SWEP.VElements = nil --Export from SWEP Creation Kit.  For each item that can/will be toggled, set active=false in its individual table
SWEP.WElements = nil --Export from SWEP Creation Kit.  For each item that can/will be toggled, set active=false in its individual table
SWEP.Attachments = {
	--[MDL_SWEP.Secondary] = = { offset = { 0, 0 }, atts = { "si_eotech" }, sel = 0 }
	--Sorry for kind-of copying your syntax, Spy, but it makes it easier on the users and you did an excellent job.  The internal code's all mine anyways.
	--sel allows you to have an SWEP.Secondary pre-selected, and is used internally by the base to show which SWEP.Secondary is selected in each category.
}

local hudcolor = Color(255, 80, 0, 191)
if killicon and killicon.Add then
    killicon.Add("tfa_bms_shotgun", "bms/vgui/icons/tfa_bms_shotgun", hudcolor)
end


DEFINE_BASECLASS( SWEP.Base )

function SWEP:CanPrimaryAttack( )
	stat = self:GetStatus()
	if stat == TFA.Enum.STATUS_SHOOTING then return false end
	if not TFA.Enum.ReadyStatus[stat] then
		if self.Shotgun and TFA.Enum.ReloadStatus[stat] then
			self:SetShotgunCancel( true )
		end
		return false
	end
	if self:IsSafety() then
		self:EmitSound("Weapon_AR2.Empty2")
		self.LastSafetyShoot = self.LastSafetyShoot or 0

		if CurTime() < self.LastSafetyShoot + 0.5 then
			self:CycleSafety()
			self:SetNextPrimaryFire(CurTime() + 0.1)
		end

		self.LastSafetyShoot = CurTime()

		return
	end
	if self:GetSprinting() and not self.AllowSprintAttack then
		return false
	end
	if self:Clip1() < 1 then
		if self:GetOwner():KeyPressed(IN_ATTACK) then
			self:ChooseDryFireAnim()
		end
		self:EmitSound("Weapon_Pistol.Empty2")
		return false
	end
	if self.FiresUnderwater == false and self:GetOwner():WaterLevel() >= 3 then
		self:SetNextPrimaryFire(CurTime() + 0.1)
		self:EmitSound("Weapon_AR2.Empty")
		return false
	end

	if CurTime() < self:GetNextSecondaryFire() then return false end

	return true
end

function SWEP:PrimaryAttack()
	if not IsValid(self) then return end
	if not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end
	if self:GetShotgunCancel() then return end
	self:SetStatus(TFA.Enum.STATUS_SHOOTING)
	self:SetStatusEnd( CurTime() + 60 / self.Primary.RPM )
	self:SetNextPrimaryFire(CurTime() + 60 / self.Primary.RPM)
	succ, tanim = self:ChooseShootAnim()
	if ( not game.SinglePlayer() ) or ( not self:IsFirstPerson() ) then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	end
	self:EmitSound(self:GetStat("Secondary.Sound"))
	self.Primary.NumShots = 8
	self:TakePrimaryAmmo( 1 )
	self:ShootBulletInformation()
	local _, CurrentRecoil = self:CalculateConeRecoil()
	self:Recoil(CurrentRecoil,IsFirstTimePredicted())
	if sp and SERVER then
		self:CallOnClient("Recoil","")
	end
	if self.MuzzleFlashEnabled and ( not self:IsFirstPerson() or not self.AutoDetectMuzzleAttachment ) then
		self:ShootEffectsCustom()
	end
	if self.EjectionSmoke and IsFirstTimePredicted() and not (self.LuaShellEject and self.LuaShellEjectDelay > 0) then
		self:EjectionSmoke()
	end
	self:DoAmmoCheck()
	self:SendViewModelMatchingSequence( self:LookupSequence( "fire2" ) )
	if self:GetStatus() == TFA.GetStatus("shooting") then
		if ( self:GetStat("Primary.ClipSize") < 2 or self:Clip1() > 2 ) then
			self:SetShotgunCancel( true )
		end
	end
end

function SWEP:CanSecondaryAttack( )
	stat = self:GetStatus()
	if stat == TFA.Enum.STATUS_SHOOTING then return false end
	if not TFA.Enum.ReadyStatus[stat] then
		if self.Shotgun and TFA.Enum.ReloadStatus[stat] then
			self:SetShotgunCancel( true )
		end
		return false
	end
	if self:IsSafety() then
		self:EmitSound("Weapon_AR2.Empty2")
		self.LastSafetyShoot = self.LastSafetyShoot or 0

		if CurTime() < self.LastSafetyShoot + 0.2 then
			self:CycleSafety()
			self:SetNextPrimaryFire(CurTime() + 0.1)
		end

		self.LastSafetyShoot = CurTime()

		return
	end
	if self:GetStat("Primary.ClipSize") <= 0 and self:Ammo1() < self:GetStat("Secondary.AmmoConsumption") then
		return false
	end
	if self:GetSprinting() and not self.AllowSprintAttack then
		return false
	end
	if self:Clip1() < 2 then
		if self:GetOwner():KeyPressed(IN_ATTACK2) then
			self:ChooseDryFireAnim()
		end
		self:EmitSound("Weapon_Pistol.Empty2")
		return false
	end
	if self.FiresUnderwater == false and self:GetOwner():WaterLevel() >= 3 then
		self:SetNextPrimaryFire(CurTime() + 0.2)
		self:EmitSound("Weapon_AR2.Empty")
		return false
	end

	self.HasPlayedEmptyClick = false

	if CurTime() < self:GetNextSecondaryFire() then return false end

	return true
end

function SWEP:SecondaryAttack()
	if not IsValid(self) then return end
	if not self:VMIV() then return end
	if self:Ammo1() == 1 then
		self.PrimaryAttack( self )
		return
	end
	if not self:CanSecondaryAttack() then return end
	if self:GetShotgunCancel() then return end
	self:SetStatus(TFA.Enum.STATUS_SHOOTING)
	self:SetStatusEnd( CurTime() + 60 / self.Secondary.RPM )
	self:SetNextPrimaryFire(CurTime() + 60 / self.Secondary.RPM)
	self:SetNextSecondaryFire(CurTime() + 60 / self.Secondary.RPM)
	succ, tanim = self:ChooseShootAnim()
	if ( not game.SinglePlayer() ) or ( not self:IsFirstPerson() ) then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	end
	self:EmitSound(self:GetStat("Secondary.Sound"))
	self.Primary.NumShots = 16
	self:TakePrimaryAmmo( 2 )
	if self:Clip1() == 0 and self:GetStat("Primary.ClipSize") >= 2 then
		self:SetNextSecondaryFire( math.max( self:GetNextSecondaryFire(), CurTime() + ( self.Secondary.DryFireDelay or self:GetActivityLength(tanim, true) ) ) )
	end
	self:ShootBulletInformation()
	local _, CurrentRecoil = self:CalculateConeRecoil()
	self:Recoil(CurrentRecoil,IsFirstTimePredicted())
	if sp and SERVER then
		self:CallOnClient("Recoil","")
	end
	if self.MuzzleFlashEnabled and ( not self:IsFirstPerson() or not self.AutoDetectMuzzleAttachment ) then
		self:ShootEffectsCustom()
	end
	if self.EjectionSmoke and IsFirstTimePredicted() and not (self.LuaShellEject and self.LuaShellEjectDelay > 0) then
		self:EjectionSmoke()
	end
	self:DoAmmoCheck()
	self:SendViewModelAnim( ACT_VM_SECONDARYATTACK )
	if self:GetStatus() == TFA.GetStatus("shooting") then
		if ( self:GetStat("Primary.ClipSize") < 2 or self:Clip1() > 2 ) then
			self:SetShotgunCancel( true )
		end
	end
end

-- devinity floodweapons viewmodel fix
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1 ,1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}