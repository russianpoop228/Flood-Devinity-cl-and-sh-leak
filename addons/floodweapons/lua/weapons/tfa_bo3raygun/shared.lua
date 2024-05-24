SWEP.Ispackapunched = 0
SWEP.Firstdraw = 1
SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-1,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = true --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false
SWEP.Blowback_Shell_Effect = "nil"-- ShotgunShellEject shotgun or ShellEject for a SMG  
 
SWEP.DoMuzzleFlash = false
SWEP.TracerName 		= "rgun1_trail_child1"
SWEP.TracerCount 		= 0 	--0 disables, otherwise, 1 in X chance
 
SWEP.UseHands				= true
SWEP.DisableChambering		= true
SWEP.Type					= "Wonder Weapon"
SWEP.Category				= "Black Ops 3"
SWEP.Author				= "Raven"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Ray Gun"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 21			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon

SWEP.Primary.HullSize = 150
SWEP.SelectiveFire		= false
SWEP.CanBeSilenced		= false
SWEP.ViewModelFOV			= 65
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/raygun/c_raygun.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/raygun/w_bo3_raygun.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.NZWonderWeapon = true
SWEP.NZPaPReplacement = "tfa_bo3_porters_x2_raygun"

game.AddAmmoType({
	name = "Atomic Cold Cells",
	dmgtype = DMG_BLAST,
	tracer = TRACER_NONE,
	plydmg = 50,
	npcdmg = 20,
	force = 2000,
	minsplash = 10,
	maxsplash = 20
})

SWEP.Primary.Sound			= Sound("raygun_fire.wav")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 181		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 20		-- Size of a clip
SWEP.Primary.DefaultClip		= 160		-- Bullets you start with
SWEP.Primary.KickUp				= 0.3		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.5		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.4		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true	-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "Atomic Cold Cells"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 80		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1	-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 115	-- Base damage per bullet
SWEP.Primary.Spread		= .025	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below

SWEP.InspectPos = Vector(5.92, 0, -1.441)
SWEP.InspectAng = Vector(13.199, 26.6, 10)

--[[PROJECTILES]]--

SWEP.ProjectileEntity = "obj_blank_proj" --Entity to shoot
SWEP.ProjectileVelocity = 30000 --Entity to shoot's velocity
SWEP.ProjectileModel = nil

DEFINE_BASECLASS( SWEP.Base )

function SWEP:NZMaxAmmo(maxammo)
if SERVER then
self.Primary.NZMaxAmmo = 160
end
BaseClass.NZMaxAmmo( self, maxammo ) 
end

SWEP.VMPos = Vector(0.1, 2, 0.7) 
SWEP.VMAng = Vector(0, 0, 0)

function SWEP:PrimaryAttack(test)
if !self:CanPrimaryAttack() then return end
	local own = self.Owner
	
	if SERVER then
		local orb1 = ents.Create("obj_bo3rgun_proj")
		orb1.Trail = util.SpriteTrail(orb1,1,Color(50,255,50,255),false,32,0,0.2,0.118,"effects/laser_citadel1.vmt")
		local pos
		/*local obj,pos = own:LookupAttachment("anim_attachment_RH")
		if obj != 0 then
			pos = own:GetAttachment(obj).Pos-own:GetForward()*50 
		else
			pos = own:GetShootPos()-own:GetForward()*25 
		end*/	
		if ( self.Owner:KeyDown( IN_FORWARD )) then 
			pos = own:GetShootPos() + own:GetUp()*-3 + own:GetRight()*5 + own:GetForward() * 12
		elseif ( self.Owner:KeyDown( IN_BACK )) then
			pos = own:GetShootPos() + own:GetUp()*-3 + own:GetRight()*5 + own:GetForward() * -30
		elseif ( self.Owner:KeyDown( IN_MOVELEFT )) then
			pos = own:GetShootPos() + own:GetUp()*-3 + own:GetRight()*-5 + own:GetForward() * -10
		elseif ( self.Owner:KeyDown( IN_MOVERIGHT )) then
			pos = own:GetShootPos() + own:GetUp()*-3 + own:GetRight()*15 + own:GetForward() * -10
		else		
			pos = own:GetShootPos() + own:GetUp()*-5 + own:GetRight()*8 + own:GetForward() * -10
		end
		if self:GetIronSights() and ( self.Owner:KeyDown( IN_FORWARD )) then 
			pos = own:GetShootPos() + own:GetUp()*-6 + own:GetRight()*0.3 + own:GetForward() * 12
		elseif self:GetIronSights() and ( self.Owner:KeyDown( IN_BACK )) then 
			pos = own:GetShootPos() + own:GetUp()*-6 + own:GetRight()*0.3 + own:GetForward() * -25
		elseif self:GetIronSights() and ( self.Owner:KeyDown( IN_MOVERIGHT )) then 
			pos = own:GetShootPos() + own:GetUp()*-6 + own:GetRight()*3 + own:GetForward() * -25
		elseif self:GetIronSights() and ( self.Owner:KeyDown( IN_MOVELEFT )) then 
			pos = own:GetShootPos() + own:GetUp()*-6 + own:GetRight()*-3 + own:GetForward() * -25
		else
		if self:GetIronSights() then
			pos = own:GetShootPos() + own:GetUp()*-6 + own:GetRight()*0.3 + own:GetForward() * 7
		    end
		end
		orb1:SetPos(pos)
		orb1:SetAngles((own:GetEyeTrace().HitPos - pos):Angle())
		orb1.Owner = own
		if SERVER then
		orb1.TrailPCF = "rgun1_trail_child1"
		orb1.CollidePCF = "rgun1_impact"
		orb1.MuzzlePCF = "rgun1_flash"
		end
		orb1:Spawn()
		orb1:Activate()
	end
	BaseClass.PrimaryAttack( self, test ) 
end

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_ANI --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.0 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.0 --Start an idle this far early into the end of another animation

--MDL Animations Below

SWEP.IronAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "ads up", --Number for act, String/Number for sequence
		["value_empty"] = "ads up",
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "ads idle", --Number for act, String/Number for sequence
		["value_empty"] = "ads idle"
	}, --Looping Animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "ads down", --Number for act, String/Number for sequence
		["value_empty"] = "ads down",
		["transition"] = true
	}, --Outward transition
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "ads fire", --Number for act, String/Number for sequence
		["value_last"] = "ads fire",
		["value_empty"] = "reload"
	} --What do you think
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint in", --Number for act, String/Number for sequence
		["value_empty"] = "sprint in empty",
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint loop", --Number for act, String/Number for sequence
		["value_empty"] = "sprint loop empty",
		["is_idle"] = true
	},--looping animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint out", --Number for act, String/Number for sequence
		["value_empty"] = "sprint out empty",
		["transition"] = true
	} --Outward transition
}

hook.Add("EntityTakeDamage", "bo3raygunz", function(ent, dmginfo) 
	local inf = dmginfo:GetInflictor()
	if IsValid(inf) and inf:GetClass() == "obj_bo3rgun_proj" then
		dmginfo:SetDamage( 3 )
		dmginfo:SetDamagePosition(ent:GetPos())
	end
	
end)

-- sh_bullet code
	
local cv_dmg_mult = GetConVar("sv_tfa_damage_multiplier")
local cv_dmg_mult_min = GetConVar("sv_tfa_damage_mult_min")
local cv_dmg_mult_max = GetConVar("sv_tfa_damage_mult_max")
local dmg, con, rec

