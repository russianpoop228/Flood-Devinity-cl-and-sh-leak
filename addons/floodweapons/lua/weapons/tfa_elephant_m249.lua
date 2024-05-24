SWEP.Base				= "tfa_gun_base"
SWEP.Category			= "Elephant's TFA Armoury" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer		= "FN Herstal" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "AnOldRetiredElephant" --Author Tooltip
SWEP.Contact			= "" --Contact Info Tooltip
SWEP.Type			= "Standard issue LMG of the United States of America"
SWEP.Instructions		= "" --Instructions Tooltip
SWEP.Spawnable			= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable		= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair		= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS	= false --Draw the crosshair in ironsights?
SWEP.PrintName			= "M249 SAW"		-- Weapon name (Shown on HUD)
SWEP.Slot = 3				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos			= 54			-- Position in the slot
SWEP.AutoSwitchTo		= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom		= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 60			-- This controls how "good" the weapon is for autopickup.
SWEP.AdminOnly 			= false
SWEP.Type_Displayed		= "Light Machine Gun"

--[[WEAPON HANDLING]]--
SWEP.Primary.Sound = Sound("TFA_ELEPHANT_M249.FIRE") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("TFA_ELEPHANT_M249.INDOOR_TRAIL"), -- This is the sound of the weapon, when you shoot.
	[256] = Sound("TFA_ELEPHANT_M249.OUTDOOR_TRAIL") -- This is the sound of the weapon, when you shoot.
}

SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage = 34 * (1) -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Primary.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 0 --Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize = 0 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = true -- Automatic/Semi Auto
SWEP.Primary.RPM = 800 -- This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay = 0.2 --How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay = 0.1 -- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = true
--Miscelaneous Sounds
SWEP.IronInSound = nil --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = nil --Sound to play when ironsighting out?  nil for default
--Silencing
SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?
-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = true --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
--Ammo Related
SWEP.Primary.ClipSize = 100 -- This is the size of a clip
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "556_nato" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = true --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = .7 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = .1 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = .4 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.8 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .0333 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .0333 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 4 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 1 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 6 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = 0.35 / 0.7 * (3280.84 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.7 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Penetration Related
SWEP.MaxPenetrationCounter = 4 --The maximum number of ricochets.  To prevent stack overflows.
--Misc
SWEP.IronRecoilMultiplier = 1.15 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.2 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_rifle"
--Movespeed
SWEP.MoveSpeed = .65 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed --Multiply the player's movespeed by this when sighting.
--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/weapons/eleweps/c_m249.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 65		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.VMPos = Vector(-0.603, -1.81, 1.205) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0, 0, 0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1	
SWEP.CenteredPos = nil --The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng = nil --The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V = {

}
--[[WORLDMODEL]]--
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl" --Wmodel path
SWEP.Bodygroups_W = {}
SWEP.HoldType = "ar2" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = -2,
		Right = 1,
		Forward = 8
	},
	Ang = {
		Up = 94,
		Right = -6,
		Forward = 185
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.
SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.
--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(4.221, -1.407, -4.02)
SWEP.RunSightsAng = Vector(-10.554, 41.507, -26.734)
SWEP.SafetyPos = Vector(10.05, -14.674, -1.81)
SWEP.SafetyAng = Vector(0, 90, 0)
SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_TO_LOWERED --Number for act, String/Number for sequence
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_LOWERED, --Number for act, String/Number for sequence
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_LOWERED_TO_IDLE --Number for act, String/Number for sequence
	}
}
--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.Secondary.IronFOV = 78 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(-5.981, -11.86, 3.5)
SWEP.IronSightsAng = Vector(0.5, 0, 0)
--[[INSPECTION]]--
SWEP.InspectPos = Vector(10, -15, -2)
SWEP.InspectAng = Vector(24, 42, 16)
--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1
--Shell eject override
SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0.015 --The delay to actually eject things
SWEP.LuaShellModel = "models/hdweapons/rifleshell.mdl"
SWEP.ShellScale = 0.625

local m_C, m_R = math.Clamp, math.Round
function SWEP:UpdateBeltBG(vm)
	local target = self:Clip1()
	if TFA.Enum.ReloadStatus[self:GetStatus()] then
		target = self:Clip1() + self:Ammo1()
	end

	self.Bodygroups_V[1] = m_C(target, 0, 12)
	--self.Bodygroups_V[1] = m_C(m_R(target / 5), 0, 10)
end

--[[EVENT TABLE]]--
SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{time = 1 / 30, type = "lua", value = SWEP.UpdateBeltBG},
	},
	[ACT_VM_RELOAD] = {
		{time = 50 / 30, type = "lua", value = SWEP.UpdateBeltBG},
	},
	[ACT_VM_RELOAD_EMPTY] = {
		{time = 70 / 30, type = "lua", value = SWEP.UpdateBeltBG},
	},
	--[ACT_VM_RELOAD_STANAG] = {
	--},
	--[ACT_VM_RELOAD_EMPTY_STANAG] = {
	--},
	[ACT_VM_PRIMARYATTACK] = {
		{time = 0 / 30, type = "lua", value = SWEP.UpdateBeltBG},
	},
	[ACT_VM_PRIMARYATTACK_1] = {
		{time = 0 / 30, type = "lua", value = SWEP.UpdateBeltBG},
	},
	[ACT_VM_PRIMARYATTACK_EMPTY] = {
		{time = 0 / 30, type = "lua", value = SWEP.UpdateBeltBG},
	}
	--[ACT_VM_PRIMARYATTACK_DEPLOYED_EMPTY] = {
	--},
	--[ACT_VM_RELOAD_DEPLOYED] = {
	--},
}
--[[ATTACHMENTS]]--

SWEP.ViewModelBoneMods = {}


SWEP.WorldModelBoneMods = {}

SWEP.VElements = {}
SWEP.WElements = {}
SWEP.Attachments = {
	[1] = { atts = { 0, 0 }, atts = { "eleweps_box_200rnd" }, order = 3 },
	[2] = { offset = { 0, 0 }, atts = { "am_match", "am_magnum", "am_gib" }, order = 4 },
}

SWEP.MuzzleAttachmentSilenced = 3
SWEP.MuzzleAttachment			= "muzzle"

SWEP.AttachmentDependencies = {}
SWEP.AttachmentExclusions = {}

SWEP.SequenceLengthOverride = {
[ACT_VM_RELOAD] = 6.7,
[ACT_VM_RELOAD_EMPTY] = 7.5,
[ACT_VM_RELOAD_DEPLOYED] = 3.1,
[ACT_VM_PRIMARYATTACK_DEPLOYED_EMPTY] = 4,
}

SWEP.StatusLengthOverride = {
[ACT_VM_RELOAD] = 3.85,
[ACT_VM_RELOAD_EMPTY] = 4.6,
[ACT_VM_RELOAD_DEPLOYED] = 2.2,
[ACT_VM_PRIMARYATTACK_DEPLOYED_EMPTY] = 3.2,
}


DEFINE_BASECLASS(SWEP.Base)